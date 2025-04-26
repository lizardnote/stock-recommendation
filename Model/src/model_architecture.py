import torch.nn as nn
import torch


class EmbRec(nn.Module):
    def __init__(self, company_num, embedding_dim):
        super(EmbRec, self).__init__()
        self.embedding = nn.Embedding(company_num, embedding_dim)

        self.fc1 = nn.Linear(embedding_dim, 10)
        self.fc2 = nn.Linear(embedding_dim, 10)

        torch.nn.init.kaiming_normal(self.embedding.weight)
        torch.nn.init.kaiming_normal(self.fc1.weight)
        torch.nn.init.kaiming_normal(self.fc2.weight)

        self.activation = nn.ReLU()
        self.bn1 = nn.BatchNorm1d(embedding_dim)
        self.bn2 = nn.BatchNorm1d(embedding_dim)
        self.sig = nn.Sigmoid()

    def forward(self, idx):
        company_1_idx = idx[:, 0]
        company_2_idx = idx[:, 1]

        company_1_emb = self.embedding(company_1_idx)
        company_1_emb = self.bn1(company_1_emb)

        company_2_emb = self.embedding(company_2_idx)
        company_2_emb = self.bn2(company_2_emb)

        # output = torch.sum(company_1_emb * company_2_emb, dim=1) / torch.sqrt(company_1_emb.pow(2).sum(dim=1)) / torch.sqrt(company_2_emb.pow(2).sum(dim=1))
        return self.sig(torch.sum(company_1_emb * company_2_emb, dim=1))
        # embs = self.embedding[idx]
        # embs = self.fc1(self.activation(self.bn(embs)))
        # dot = torch.matmul(embs, embs.T)
        # norm = embs.pow(2).sum(dim=1)
        # sim = dot / norm.unsqueeze(0) / norm.unsqueeze(1)
        # return sim
