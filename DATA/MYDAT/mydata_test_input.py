import pandas as pd
import numpy as np
from datetime import datetime, timedelta
from tqdm import tqdm


def main():
    c_invest = load_customer()
    stock_close, companies_idx, companies_name = load_stock()
    company_candidates = load_company_candidates(list(stock_close.columns))

    for user in (c_invest['ID']):
        mydata = pd.DataFrame()
        companies = np.random.choice(company_candidates, 10, replace=False).tolist()
        for company in companies:
            company_idx, company_name = company.split('_')
            timing = np.sort(np.random.choice(stock_close['Date'], 5, replace=True))
            company_close = stock_close[company][stock_close['Date'].isin(timing)].to_numpy()
            if np.isnan(company_close).sum() != 0:
                print()
            quantity = np.random.choice([1, 2, 3, 4, 5], 5, replace=True)

            transaction = pd.DataFrame([timing, company_close, quantity]).T
            transaction.columns = ['Date', 'Stock_price', 'Quantity']
            transaction['Stock_id'] = company_idx
            transaction['Stock_name'] = company_name

            transaction = transaction[['Stock_id', 'Stock_name', 'Date', 'Stock_price', 'Quantity']]
            mydata = pd.concat((mydata, transaction), axis=0)
        mydata.sort_values(by=['Date'], inplace=True)
        mydata.to_csv(f'dataset/{user}.csv')


def load_customer():
    return pd.read_csv('../Customer/dataset/investment_propensity.csv', index_col=0)


def load_stock():
    dat = pd.read_csv('../stock/dataset/RAW/Close300.csv', parse_dates=['Date'])
    dat.dropna(axis=1, inplace=True)
    idx_names = pd.Series(list(dat.columns)[1:])
    company_idx = idx_names.apply(lambda x: x.split('_')[0])
    company_name = idx_names.apply(lambda x: x.split('_')[1])

    mask = (dat['Date'] < end)
    return dat[mask], company_idx.to_numpy(), company_name.to_numpy()


def load_company_candidates(companies):
    candidates = []
    for group in group_list:
        for i in companies:
            if group in i:
                candidates.append(i)
    return candidates


if __name__ == '__main__':
    start = datetime.strptime("2018-12-31", "%Y-%m-%d")
    end = datetime.strptime("2022-1-1", "%Y-%m-%d")
    period = end - start
    group_list = ['삼성', 'SK', '현대', '한화', '롯데', 'LG', 'KT']
    time_stamp = [end-timedelta(days=i) for i in range(period.days)][::-1]
    main()
