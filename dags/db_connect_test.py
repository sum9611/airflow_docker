# 필요 모듈 import
from datetime import datetime
from airflow import DAG
from airflow.operators.python import PythonOperator
import pymysql
import yaml



with open('yamls/sql_info.yaml') as f:

    info = yaml.load(f, Loader=yaml.FullLoader)

# DAG 정의
dag = DAG(
    'db_connect_test',        
    default_args={                  
        'retries': 1,               
        },
    schedule_interval='@once',      
    start_date=datetime(2023,4, 3)  
)

# 함수 설정
def connect_test():
    conn = pymysql.connect(host = info['MARIADB']['IP'], user = info['MARIADB']['USER'] , passwd=info['MARIADB']['PASSWD'], db = info['MARIADB']['DB'], charset='utf8', port = info['MARIADB']['PORT'])
    cur = conn.cursor()
    sql = 'select * from player_info'
    cur.execute(sql)
    result = cur.fetchall()
    print(result)
    conn.close()

# task 설정
t1 = PythonOperator( 
    task_id = 'connect_test', #task 이름 설정
    python_callable=connect_test, # 불러올 함수 설정
    dag=dag #dag 정보 
)

# task 진행
t1 