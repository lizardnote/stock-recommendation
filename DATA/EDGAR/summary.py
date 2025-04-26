import pandas as pd
import numpy as np
import json
import os
from tqdm import tqdm


def read_json(is_processed=True):
    if is_processed:
        results = dict()
        managers = os.listdir(dir_market_values)
        for manager in managers:
            results[manager.split('.')[0]] = pd.read_csv(f"{dir_market_values}/{manager}", index_col=0)
    else:
        results = dict()
        reports_name = os.listdir(dir_raw)
        for report_name in tqdm(reports_name):
            with open(f"{dir_raw}/{report_name}") as report_file:
                report = json.load(report_file)
            manager = cik2name[report['cik']]
            result = dict()
            # result = pd.DataFrame([report["filing_date"]], columns=['Date'])
            for company, data in report['data'].items():
                result[f"{company}"] = data['values']
                # result_temp = pd.DataFrame([data['values']], columns=[company])
                # result = pd.concat((result, result_temp), axis=1)
                # result.insert(len(result.columns), f"{company}", data['values'])
                # result[f"{company}_share"] = data['shares']
            result = pd.DataFrame(result, index=[report['filing_date']])
            if manager not in results.keys():
                results[manager] = result
            else:
                results[manager] = pd.concat((results[manager], result), axis=0)
        for manager, data in results.items():
            data.to_csv(f'{dir_market_values}/{manager}.csv')
    return results


def preprocessing(data: pd.DataFrame):
    data.fillna(0, inplace=True)
    result = data.values
    quartile_sum = result.sum(axis=1, keepdims=True)
    result /= quartile_sum
    result *= 100
    result = pd.DataFrame(result, index=data.index, columns=data.columns)
    return result


def main():
    dataset = read_json()

    processed_dset = dict()
    for manager, data in dataset.items():
        if manager == 'JP Morgan':
            # missing quartile 존재
            continue
        data = preprocessing(data)
        data.to_csv(f'{dir_proportion}/{manager}.csv')
        processed_dset[manager] = data


if __name__ == '__main__':
    dir_raw = "datasets/EXTRACTED_FILINGS"
    dir_market_values = 'datasets/market_values'
    dir_proportion = 'datasets/proportion'
    with open('Target company.json') as json_target:
        cik2name = json.load(json_target)
    main()
