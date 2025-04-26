# Stock-Recommendation Modeling Using Mydata

## :page_with_curl: Purpose
Recommend stocks based on similarity and profitability

## :pencil2: Functions Introduction

:one: **_dtw_similarity_**  
Find similar stocks using dtw model

:two: **_dl_similarity, dl_implementation_**  
Find similar items using deep learning algorithms with cosine similarity

:three: **_prophet_arima_netprofit.py_**  
Implementation of a function to predict net income using propet and arima models

:four: **_compare_model.py_**  
Given a stock item for each candidate model, look for stocks that are similar to one particular stock item.  
And among these, Present and compare the expected indicators of the stocks with the highest net income to the actual indicators

:five: **_choose_model_using_sample30.py_**    
After selecting 30 stocks as samples, for each candidate model,  
Select similar stocks and recommend the one with the highest expected net profit.  
Among the stocks recommended by each candidate model, the model with the highest actual net profit is given a score.  
The model with the highest score was selected as the final model.

:six: **_performance_dtw_per_arima_using_top1, performance_dtw_per_arima_using_top10_**  
Performance measurement of **_dtw(per) + arima model_** selected as final model  


**_This project is the result of the Hanium 2022 Mentoring Contest._**

원본 공동 프로젝트: https://github.com/naemamchu/Modeling  
담당 파트: [데이터 수집/DTW 모델링/문서 작성]

