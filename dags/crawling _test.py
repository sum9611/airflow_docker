# 필요 모듈 import
from datetime import datetime
from airflow import DAG
from airflow.operators.python import PythonOperator
import pymysql
import yaml
from bs4 import BeautifulSoup
import pandas as pd
from selenium import webdriver
import re
from selenium.webdriver.common.by import By
from sqlalchemy import create_engine
import os 
import urllib.request

with open('yamls/sql_info.yaml') as f:

    info = yaml.load(f, Loader=yaml.FullLoader)

# DAG 정의
dag = DAG(
    'crawling_test',        
    default_args={                  
        'retries': 1,               
        },
    schedule_interval='@once',      
    start_date=datetime(2023,4, 3)  
)

# 함수 설정
def crawling():
  
    # 크롤링 사이트
    target_url = 'http://www.statiz.co.kr/schedule.php'
    html = urllib.request.urlopen(target_url).read()
    bsObject = BeautifulSoup(html, 'html.parser')
    print(bsObject)
    
    # 경기날짜 
    now = datetime.now().strftime("%Y-%m-%d")
    now = '2023-04-08'

    
    init_url = str(bsObject.find_all('table', {'class' : 'table table-striped table-bordered'})).split(f'boxscore.php?date={now}&amp;')[-5:]
    
    # 경기마다 하나씩 출력 
    for i in init_url:
        print('=' * 50)
        stadium = str(i).split('>')[0]
        url = f'http://www.statiz.co.kr/boxscore.php?opt=4&date={now}&{stadium}'
        html = urllib.request.urlopen(url).read()
        bsObject = BeautifulSoup(html, 'html.parser')
        print(bsObject)
  


    
# task 설정
t1 = PythonOperator( 
    task_id = 'crawling', #task 이름 설정
    python_callable=crawling, # 불러올 함수 설정
    dag=dag #dag 정보 
)

# task 진행
t1 