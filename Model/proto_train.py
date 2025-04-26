import sys
import numpy as np

import torch
import torch.nn as nn

from torch.optim import Adam, SGD
from torch.utils.data import DataLoader
from torch.nn.functional import logsigmoid as lsig
from torch.nn import CrossEntropyLoss
from src.model_architecture import EmbRec
from src.dset import CosDSet


import matplotlib.pyplot as plt
from tqdm import tqdm


def load_data():
    return np.load('../DATA/stock/dataset/DL/train300.npz', allow_pickle=True)['x']


def main():
    data = load_data()
    dataset = CosDSet(data)
    data_loader = DataLoader(dataset, batch_size=128, shuffle=True)

    model = EmbRec(data.shape[1]-1, 64).to(device)
    criterion = CrossEntropyLoss().to(device)
    optimizer = SGD(model.parameters(), lr=1e-1, weight_decay=1e-2)
    losses = []
    for epoch in tqdm(range(30)):
        loss_cum = []
        for data, label in data_loader:
            data = torch.Tensor(data).to(device)
            label = label.to(device).float()
            optimizer.zero_grad()

            # pred_sim = model(data)
            score = model(data)

            # loss = lsig(torch.sum(score*label))
            loss = criterion(score, label)

            loss.backward()
            optimizer.step()

            loss_cum.append(loss.detach().cpu().numpy())
        if epoch % 5 == 1:
            print(f"Loss: {np.mean(loss_cum):.4f}")
        losses.append(np.mean(loss_cum))

    torch.save(model.state_dict(), "snapshot/bpr300.pt")
    plt.figure()
    plt.plot(losses)
    plt.show()


if __name__ == '__main__':
    device = "cuda" if torch.cuda.is_available() else 'cpu'
    # sys.path.append('../DATA/stock/dataset/')
    main()
