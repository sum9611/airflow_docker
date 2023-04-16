FROM apache/airflow:2.5.2

USER airflow

RUN pip install --upgrade pip 

COPY requirements.txt ./

RUN pip install -r requirements.txt


# docker build . -t "airflow_server"