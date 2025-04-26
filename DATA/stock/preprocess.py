import pandas as pd
import numpy as np
from datetime import datetime


def load_data(data_type):
    data = pd.read_csv(f'dataset/RAW/{data_type}.csv', parse_dates=['Date'])
    meta = pd.read_csv('dataset/meta_data.csv')
    return data, meta


def extract_train(data: pd.DataFrame):
    end = datetime.strptime("2022-01-01", "%Y-%m-%d")
    return data[data['Date'] < end]


def extract_test(data: pd.DataFrame):
    start = datetime.strptime("2021-12-29", "%Y-%m-%d")
    end = datetime.strptime("2022-01-07", "%Y-%m-%d")
    mask = (data['Date'] < end) & (data['Date'] > start)
    return data[mask]


def window(change, split_type='train'):
    change = change.iloc[:, 1:]
    data = []
    for i in range(len(change) - 4):
        dat = change.iloc[i:i + 5].T.values
        data.append(dat)
    data = np.array(data)

    symbols = pd.Series(list(change.columns)[1:]).apply(lambda x: x.split('_')[0])
    names = pd.Series(list(change.columns)[1:]).apply(lambda x: x.split('_')[1])
    np.savez(f"dataset/DL/{split_type}.npz", x=data, symbols=symbols, names=names)


def main():
    change, meta = load_data('Change')
    close, meta = load_data('Close')
    change.dropna(inplace=True, axis=1)
    train_change = extract_train(change)
    window(train_change)

    test_close = extract_test(close)
    test_close.to_csv('dataset/DL/test_label.csv')
    print()


if __name__ == '__main__':
    main()