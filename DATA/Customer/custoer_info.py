import yaml
import numpy as np
import pandas as pd
import datetime


def main():
    result = pd.DataFrame()

    gen_id(result)
    gen_name(result)
    gen_birth(result)
    gen_email(result)
    gen_pw(result)
    gen_stock(result)
    gen_invest_propensity(result)
    result.to_csv('dataset/customer_info.csv')


def gen_id(data:pd.DataFrame):
    data['ID'] = np.random.choice(np.arange(1000000), size=args['people_num'], replace=False)


def gen_name(data: pd.DataFrame):
    first_name = args['people_last_name'].split(',')
    data['Name'] = data['ID'].apply(lambda x: np.random.choice(first_name, size=1)[0]+str(x))


def gen_birth(data: pd.DataFrame):
    # 연령대 분포는 uniform 가정
    today = np.datetime64(datetime.datetime.today(), 'D')
    ages = np.random.randint(low=args['age_low'], high=args['age_high'], size=(len(data)))
    data['Birthday'] = today - ages*365 + np.random.randint(low=-180, high=180, size=len(data))


def gen_email(data: pd.DataFrame):
    data['Email'] = data['Name'].apply(lambda x: f"{x}@han2m.com")


def gen_pw(data: pd.DataFrame):
    def pw(id_num):
        np.random.seed(id_num)
        size = np.random.choice(np.arange(7, 15), size=1)[0]
        alpha_num = list('1234567890!@#$%^&*()qwertyuiopasdfghjklzxcvbnm')
        return ''.join(np.random.choice(alpha_num, size=size))
    data['PW'] = data['ID'].apply(lambda x: pw(x))


def gen_stock(data: pd.DataFrame):
    print("STOCK SETUP NEEDED")


def gen_invest_propensity(data: pd.DataFrame):
    def risk_take(age):
        if age < args['age_regular']:
            weight = args['risk_take_young']
            return np.random.choice(['Conservative', 'Risky'], size=1, p=[1 - weight, weight])[0]
        else:
            weight = args['risk_take_old']
            return np.random.choice(['Conservative', 'Risky'], size=1, p=[1-weight, weight])[0]

    today = np.datetime64(datetime.datetime.today(), 'D')
    data['Age'] = today - data['Birthday']
    data['Age'] = pd.to_timedelta(data['Age']).astype('timedelta64[Y]').astype(int)
    data['Invest_Propensity'] = data['Age'].apply(lambda x: risk_take(x))
    # 실제로는 모르는 상황이기 때문
    data.drop(axis=1, labels=['Age'], inplace=True)


if __name__ == '__main__':
    with open('config.yaml', 'r') as f:
        args = yaml.safe_load(f)
    main()
