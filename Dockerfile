FROM python:3.9.4-buster

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update

RUN apt-get install -yqq unzip
RUN apt-get install -y google-chrome-stable
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

COPY requirements.txt requirements.txt
RUN ["python3", "-m", "pip", "install", "-r", "requirements.txt"]

COPY main.py main.py

CMD python main.py 1>>logs/logs.txt 2>>logs/logs.txt
