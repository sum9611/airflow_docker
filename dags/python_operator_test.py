import datetime

from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.decorators import dag
with DAG(
    dag_id="python_operator_test",
    start_date=datetime.datetime(2023, 4, 3),
    schedule="@daily",
) as dag:



    @dag.task(task_id="print_the_context")
    def print_context():

        print('Hello World')
        
run_this = print_context()