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

# 경기날짜 변수 선언
now = datetime.now().strftime("%Y-%m-%d")
now = '2023-04-09'


# 크롤링 데이터 전처리 함수 
def transform_pitching_data(pitching_list,team):
    player_list = []
    for i in pitching_list:
        date = now
        name = i.split('>')[1].split('<')[0]
        birth = i.split('"')[0]
        today_type = i.split('(')[1].split(',')[0]
        if '"popup/pitlog.php' in today_type:
            today_type = '' 
        IP = i.split('<b>')[1].split('</b>')[0]
        TBF = i.split('<td>')[1].split('</td>')[0]
        H = i.split('<td>')[2].split('</td>')[0]
        R = i.split('<td>')[3].split('</td>')[0]
        ER = i.split('<td>')[4].split('</td>')[0]
        BB = i.split('<td>')[5].split('</td>')[0]
        HBP = i.split('<td>')[6].split('</td>')[0]
        K = i.split('<td>')[7].split('</td>')[0]
        HR = i.split('<td>')[8].split('</td>')[0]
        GO_FO = i.split('<td align="center">')[2].split('</td>')[0]
        PIT_S = i.split('<td align="center">')[3].split('</td>')[0]
        IR_IS = i.split('<td align="center">')[4].split('</td>')[0]
        GSC = i.split('<td>')[9].split('</td>')[0]
        ERA = i.split('<td align="center">')[5].split('</td>')[0]
        WHIP = i.split('<td align="center">')[6].split('</td>')[0]
        LI = i.split('<td>')[10].split('</td>')[0]
        WPA = i.split('<td>')[11].split('</td>')[0]
        RE24 = i.split('<td>')[12].split('</td>')[0]
        player_list.append([date, name,birth,team,today_type,IP,TBF,H,R,ER,BB,HBP,K,HR,GO_FO,PIT_S,IR_IS,GSC,ERA,WHIP,LI,WPA,RE24])
    return player_list

def transform_batting_data(batting_list, team):
    player_list = []
    for i in batting_list:
        date = now
        name = i.split('>')[1].split('<')[0]
        birth = i.split('"')[0]
        P = i.split('<td>')[1].split('</td>')[0]
        TPA = i.split('<b>')[1].split('</b>')[0]
        AB = i.split('<td>')[3].split('</td>')[0]
        R = i.split('<td>')[4].split('</td>')[0]
        H = i.split('<td>')[5].split('</td>')[0]
        HR = i.split('<td>')[6].split('</td>')[0]
        RBI = i.split('<td>')[7].split('</td>')[0]
        BB = i.split('<td>')[8].split('</td>')[0]
        HBP = i.split('<td>')[9].split('</td>')[0]   
        SO = i.split('<td>')[10].split('</td>')[0]
        GO = i.split('<td>')[11].split('</td>')[0]
        FO = i.split('<td>')[12].split('</td>')[0]
        PIT = i.split('<td>')[13].split('</td>')[0]
        GDP = i.split('<td>')[14].split('</td>')[0]
        LOB = i.split('<td>')[15].split('</td>')[0]
        AVG = i.split('<td>')[16].split('</td>')[0]
        OPS = i.split('<td>')[17].split('</td>')[0]
        LI = i.split('<td>')[18].split('</td>')[0]
        WPA = i.split('<td>')[19].split('</td>')[0]
        RE24 = i.split('<td>')[20].split('</td>')[0]
        
        player_list.append([date, name,birth,team,P,TPA,AB,R,H,HR,RBI,BB,HBP,SO,GO,FO,PIT,GDP,LOB,AVG,OPS,LI,WPA,RE24])
    return player_list




# task 함수 설정
def crawling():
  
    # 크롤링 사이트
    target_url = 'http://www.statiz.co.kr/schedule.php'
    html = urllib.request.urlopen(target_url).read()
    bsObject = BeautifulSoup(html, 'html.parser')

    init_url = str(bsObject.find_all('table', {'class' : 'table table-striped table-bordered'})).split(f'boxscore.php?date={now}&amp;')[-5:]
    
    batting = pd.DataFrame()
    pitching = pd.DataFrame()  
    
    # 경기마다 하나씩 출력 
    for i in init_url:
        print('=' * 50)
        stadium = str(i).split('>')[0]
        url = f'http://www.statiz.co.kr/boxscore.php?opt=4&date={now}&{stadium}'
        html = urllib.request.urlopen(url).read()
        bsObject = BeautifulSoup(html, 'html.parser')
        
        # 홈팀
        home_batting = str(bsObject.find_all('h3')[1])
        hometeam = home_batting.split('(')[1].split(')')[0]
        
        # 원정팀 
        away_batting = str(bsObject.find_all('h3')[2])
        awayteam = away_batting.split('(')[1].split(')')[0]
        
        print(f'{hometeam} vs {awayteam} 경기 데이터 크롤링 !')
        
        # 타자 컬럼 데이터 추출
        batting_columns = ['yyyymmdd', 'player_name', 'player_birth', 'team']
        for i in bsObject.find_all('th')[2:22]:
            batting_columns.append(str(i).split('<th>')[1].split('</th>')[0])
            
        ############################
        ## 홈팀 데이터 추출 진행 ! ##  
        ############################

        # 홈팀 타자들의 정보 리스트로 담아두기
        home_batting_list = []
        for i in str(bsObject.find_all('table')[3]).split('birth=')[1:]:
            home_batting_list.append(i)

        # 타자별 정보 분리 및 2차월 배열로 저장           
        home_player_list = transform_batting_data(home_batting_list, hometeam)
        home_team_batting = pd.DataFrame(home_player_list,columns=batting_columns)            
  
        ##############################
        ## 원정팀 데이터 추출 진행 ! ##  
        ##############################
        
        # 원정팀 타자들의 정보 리스트로 담아두기
        away_batting_list = []
        for i in str(bsObject.find_all('table')[5]).split('birth=')[1:]:
            away_batting_list.append(i)
        
        # 타자별 정보 분리 및 2차월 배열로 저장
        away_player_list = transform_batting_data(away_batting_list, awayteam)
        away_team_batting = pd.DataFrame(away_player_list,columns=batting_columns)
        

        # 홈팀, 원정팀 정보 concat
        batting = pd.concat([batting,home_team_batting,away_team_batting])
        
        
        ##############################
        ## 타자 정보가져오기 완료 !! ##
        ##############################

        # 타자 컬럼 데이터 추출
        pitching_columns = ['yyyymmdd', 'player_name', 'player_birth', 'team','today_type']
        for i in str(bsObject.find_all('table')[7]).split('<th>')[2:]:
            
            # 주석처리된 지표 핸들링
            if i.split('</th>')[0] != 'RS':
                pitching_columns.append(i.split('</th>')[0])

        ############################
        ## 홈팀 데이터 추출 진행 ! ##  
        ############################

        # 홈팀 투수들의 정보 리스트로 담아두기
        home_pitching_list = []
        for i in str(bsObject.find_all('table')[7]).split('birth=')[1:]:
            home_pitching_list.append(i)

        # 투수별 정보 분리 및 2차월 배열로 저장
        player_list = transform_pitching_data(home_pitching_list, hometeam)
        home_team_pitching = pd.DataFrame(player_list,columns=pitching_columns)

        ##############################
        ## 원정팀 데이터 추출 진행 ! ##  
        ##############################

        # 원정팀 투수들의 정보 리스트로 담아두기
        away_pitching_list = []
        for i in str(bsObject.find_all('table')[9]).split('birth=')[1:]:
            away_pitching_list.append(i)

        # 투수별 정보 분리 및 2차월 배열로 저장
        player_list = transform_pitching_data(away_pitching_list, awayteam)
        away_team_pitching = pd.DataFrame(player_list,columns=pitching_columns)

        # 홈팀, 원정팀 정보 concat
        pitching = pd.concat([pitching,home_team_pitching,away_team_pitching])
        
        
    # 데이터 적재 전 전처리         
    batting['yyyymmdd'] = batting['yyyymmdd'].apply(lambda x : x[0:4] + x[5:7] + x[8:10])
    pitching['yyyymmdd'] = pitching['yyyymmdd'].apply(lambda x : x[0:4] + x[5:7] + x[8:10])

    # null 값 제거
    batting['LI'] = batting['LI'].apply(lambda x : '0' if x =='' else x)
    batting['LI'] = batting['LI'].astype(float)        


    # db 정보 가져오기         
    host = info['MARIADB']['IP']
    user = info['MARIADB']['USER']
    passwd=info['MARIADB']['PASSWD']
    db = info['MARIADB']['DB']
    port = info['MARIADB']['PORT']
    
    # to_sql로 밀어넣기 
    engine = create_engine(f"mysql+pymysql://{user}:{passwd}@{host}:{port}/{db}?charset=utf8")
    conn = engine.connect()
    batting.to_sql(name = 'batting_info', con = engine, if_exists = 'append', index=False)


    
    


    
# task 설정
t1 = PythonOperator( 
    task_id = 'crawling', #task 이름 설정
    python_callable=crawling, # 불러올 함수 설정
    dag=dag #dag 정보 
)


# task 진행
t1