import FinanceDataReader as fdr
import pandas as pd
from tqdm import tqdm

# 상위 300개
kospi_300 = pd.read_csv('dataset/RAW/kospi_300.csv', encoding='euc-kr')
symbol_300 = kospi_300['종목코드'].astype(str).tolist()
name_300 = kospi_300['종목명'].astype(str).tolist()

# 한국거래소 상장종목 전체
df_krx = fdr.StockListing('KRX')
df_krx.head()

df_krx.dropna(inplace=True)
df_krx = df_krx.loc[df_krx['Market']=='KOSPI']

df_krx.to_csv('dataset/meta_data.csv')

db = pd.DataFrame()
for i in tqdm(range(len(df_krx))):
    symbol = df_krx.iloc[i].loc['Symbol']
    name = df_krx.iloc[i]['Name']
    # # Filter Top 300
    # if symbol not in symbol_300 and name not in name_300:
    #     continue

    df = fdr.DataReader(symbol, '2019')['Close']
    df.name = f"{symbol}_{name}"
    db = pd.concat((db, df.to_frame()), axis=1)

db.dropna(axis=1, inplace=True)
db.to_csv('dataset/RAW/Close.csv')
print()