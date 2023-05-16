# 필요 모듈 import
from datetime import datetime
from airflow import DAG
from airflow.operators.docker_operator import DockerOperator

# DAG 정의
dag = DAG(
    'Docker_operator_test',         # DAG_Name
    default_args={                  
        'retries': 1,               # 실패시 재시도 횟수
        },
    schedule_interval='@once',      # 배치 주기
    start_date=datetime(2023,4, 3)  # 배치 시작날짜 설정
)

t1 = DockerOperator(

    task_id='docker_sample_task',
    image='hello-world',
    auto_remove=True,
    docker_url="unix://var/run/docker.sock",
    network_mode="bridge"
)

t1