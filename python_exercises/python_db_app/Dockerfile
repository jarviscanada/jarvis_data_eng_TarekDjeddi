FROM python:3.8-slim-buster

WORKDIR /app

RUN pip install --upgrade pip
RUN pip install --upgrade wheel
RUN pip install --upgrade setuptools
RUN pip install psycopg2-binary
RUN pip install pandas

COPY ./python_db_app.py .
ENTRYPOINT [ "python3", "./python_db_app.py"]
