FROM apache/airflow:2.5.2

USER root 
WORKDIR /usr/src
RUN apt-get update && apt-get install -y sudo wget
RUN apt install wget
RUN apt install unzip  
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt -y install ./google-chrome-stable_current_amd64.deb
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/` curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN mkdir chrome
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/src/chrome

USER airflow

WORKDIR /opt/airflow

RUN pip install --upgrade pip 

COPY requirements.txt ./

RUN pip install -r requirements.txt


# docker build . -t "airflow_server"