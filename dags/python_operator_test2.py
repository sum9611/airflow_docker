# 필요 모듈 import
from datetime import datetime
import time
from airflow import DAG
from airflow.operators.python import PythonOperator
from pytz import timezone

KST = timezone('Asia/Seoul')


# DAG 정의
dag = DAG(
    'DAG_test_2',         # DAG_Name
    default_args={                  
        'retries': 1,               # 실패시 재시도 횟수
        },
    schedule_interval='@once',      # 배치 주기
    start_date=datetime(2023,4, 3)  # 배치 시작날짜 설정
)

# 함수 설정
def task1():
    
    print('Task 1 execute time ', datetime.now().astimezone(KST).strftime('%Y-%m-%D %H-%M-%S'))
    time.sleep(10)
    
def task2():
    
    print('Task 2 execute time ', datetime.now().astimezone(KST).strftime('%Y-%m-%D %H-%M-%S'))
    time.sleep(10)
    
def task3():
    
    print('Task 3 execute time ', datetime.now().astimezone(KST).strftime('%Y-%m-%D %H-%M-%S'))
    time.sleep(10)
    
def task4():
    
    print('Task 4 execute time ', datetime.now().astimezone(KST).strftime('%Y-%m-%D %H-%M-%S'))


# task 설정
t1 = PythonOperator( 
    task_id = 'task1', #task 이름 설정
    python_callable=task1, # 불러올 함수 설정
    dag=dag #dag 정보 
)
t2 = PythonOperator( 
    task_id = 'task2', #task 이름 설정
    python_callable=task2, # 불러올 함수 설정
    dag=dag #dag 정보 
)
t3 = PythonOperator( 
    task_id = 'task3', #task 이름 설정
    python_callable=task3, # 불러올 함수 설정
    dag=dag #dag 정보 
)
t4 = PythonOperator( 
    task_id = 'task4', #task 이름 설정
    python_callable=task4, # 불러올 함수 설정
    dag=dag #dag 정보 
)

# task 진행 
t1 >> t2 >> t3 >> t4