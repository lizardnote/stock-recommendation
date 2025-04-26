import numpy as np
import pandas as pd
import yaml
import datetime


def main():
    result = customer_info[['ID', 'Invest_Propensity']]
    result['Info_Approval'] = 'Y'

    gen_age(result)
    gen_available(result)
    gen_experience(result)
    gen_knowledge(result)
    gen_money(result)
    gen_money_src(result)
    gen_risk_take(result)
    result.to_csv('dataset/investment_propensity.csv')


def gen_age(data: pd.DataFrame):
    today = np.datetime64(datetime.datetime.today(), 'D')
    data['Age'] = today - customer_info['Birthday']
    data['Age'] = pd.to_timedelta(data['Age']).astype('timedelta64[Y]').astype(int)


def gen_available(data: pd.DataFrame):
    # 투자는 55살까지만 한다고 가정
    data['Available'] = data['Age'].apply(lambda x: 55-x)


def gen_experience(data: pd.DataFrame):
    # Experience = coefficient * age 가정(Linear)
    data['Experience'] = data['Age'].apply(lambda x: np.round(args['experience_coeff']*np.random.normal(loc=x, scale=args['experience_scale'],size=1)).astype(np.int32)[0])


def gen_knowledge(data: pd.DataFrame):
    # 연령대별 고학력자 비중을 조절하기로 한다.
    def age_filter(age):
        if age < args['age_student']:
            return 1
        elif age < 28:
            weight = args['knowledge_mid_high']
            return np.random.choice([1, 2], size=1, p=[1-weight, weight])[0]
        else:
            weight = args['knowledge_old_high']
            return np.random.choice([2, 3], size=1, p=[1-weight, weight])[0]

    data['Knowledge'] = data['Age'].apply(lambda x: age_filter(x))


def gen_money(data: pd.DataFrame):
    # 만원 단위
    # 연령에 따른 자본 규모를 exp 가정
    def money(age):
        pos = (age-age_low)/age_width * 10
        seed_money = np.exp(pos)+low
        if seed_money > high:
            seed_money = high
        return seed_money

    age_low = args['age_low']
    age_width = args['age_high'] - args['age_low']
    low = args['money_low']
    high = args['money_high']

    data['Money'] = data['Age'].apply(lambda x: money(x))


def gen_money_src(data: pd.DataFrame):
    def job_filter(age):
        if age < args['age_student']:
            return 'PartTime'
        elif age < args['age_regular']:
            return 'Salary'
        else:
            weight = args['job_old_invest']
            return np.random.choice(['Salary', 'Salary+Invest'], size=1, p=[1-weight, weight])[0]
    data['Money_src'] = data['Age'].apply(lambda x: job_filter(x))


def gen_risk_take(data: pd.DataFrame):
    def risk_take(propensity):
        if propensity == 'Risky':
            return 'High'
        else:
            return 'Low'
    data['Risk_Take'] = data['Invest_Propensity'].apply(lambda x: risk_take(x))


if __name__ == '__main__':
    customer_info = pd.read_csv('dataset/customer_info.csv', index_col=0)
    customer_info['Birthday'] = pd.to_datetime(customer_info['Birthday']).astype('datetime64[D]')
    with open('config.yaml', 'r') as f:
        args = yaml.safe_load(f)
    main()

