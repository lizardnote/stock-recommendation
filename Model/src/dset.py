from torch.utils.data import Dataset
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np
import pandas as pd

class CosDSet(Dataset):
    def __init__(self, data):
        super(CosDSet, self).__init__()
        positive_edges = []
        negative_edges = []
        for tick in data:
            tick = tick[1:, :].astype(float)
            cosim = cosine_similarity(tick)
            dist = pd.DataFrame(cosim.reshape((-1, 1))).describe().to_numpy()
            cosim[np.identity(len(tick))==1] = 0
            positive = np.argwhere(cosim > dist[6, 0])
            positive = np.concatenate((positive, np.ones(len(positive))[:, np.newaxis]), axis=1).astype(np.int32)

            negative = np.argwhere(cosim < dist[4, 0])
            negative = np.concatenate((negative, np.zeros(len(negative))[:, np.newaxis]), axis=1).astype(np.int32)

            positive_edges.extend(positive[np.random.choice(positive.shape[0], min(100, positive.shape[0]), replace=False)])
            negative_edges.extend(negative[np.random.choice(negative.shape[0], min(10, negative.shape[0]), replace=False)])

        edges = np.concatenate((np.array(positive_edges), np.array(negative_edges)))
        self.edges = edges

    def __getitem__(self, idx):
        return self.edges[idx][:2], self.edges[idx][2]

    def __len__(self):
        return len(self.edges)
