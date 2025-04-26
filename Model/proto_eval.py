import torch
import numpy as np
from src.model_architecture import EmbRec


def load_data():
    return np.load('../DATA/stock/dataset/DL/train300.npz', allow_pickle=True)['names']


def main():
    names = load_data()
    if search_name not in names:
        return None
    idx = np.argwhere(names==search_name)[0]

    model = EmbRec(len(names), 64).to(device)
    model.load_state_dict(torch.load("snapshot/bpr300.pt"))

    with torch.no_grad():
        embs = model.embedding.weight.data
        candidates = torch.matmul(embs, embs.T)[idx]
        recom_score, recom_label = torch.topk(candidates, 30, sorted=True)
        # top_ten = torch.argsort(candidates, descending=True)[:30].detach().cpu().numpy().tolist()
    top_n = recom_label.detach().cpu().numpy()
    for name_k, top_k in enumerate(top_n[0]):
        print(f"Top {name_k}: {names[top_k]}")
    print()


if __name__ == '__main__':
    device = "cuda" if torch.cuda.is_available() else 'cpu'
    search_name = input("어떤 종목을 추천받으시나요?")
    main()
