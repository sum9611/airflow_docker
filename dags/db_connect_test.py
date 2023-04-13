# import datetime

# from airflow import DAG
# from airflow.operators.python import PythonOperator
# from airflow.decorators import dag
# import pymysql


# conn = pymysql.connect(host='127.0.0.1', user = 'root', password = 'root', db = 'mysql', charset='utf8', port = 3307)

# cur = conn.cursor()
# with DAG(
#     dag_id="db_connect_test",
#     start_date=datetime.datetime(2023, 4, 3),
#     schedule="@once",
# ) as dag:

#     @dag.task(task_id="mariadb connect")
#     def print_context():
#         sql = 'show talbes'
#         cur.execute(sql)
#         conn.close()