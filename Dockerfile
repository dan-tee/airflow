FROM python:3.6-alpine

# install numpy and pandas
RUN apk add --no-cache g++ && \
	ln -s /usr/include/locale.h /usr/include/xlocale.h && \
	pip install cython numpy pandas

# install psycopg2	      	
RUN apk update \
  && apk add --virtual build-deps gcc python3-dev musl-dev \
  && apk add postgresql-dev \
  && pip install psycopg2 \
  && apk del build-deps

# install airflow
RUN pip install --no-cache-dir "airflow[postgres, s3]"   	
VOLUME /airflow

ENV AIRFLOW__CORE__AIRFLOW_HOME=/airflow
ENV AIRFLOW__CORE__DAGS_FOLDER=/airflow/dags
ENV AIRFLOW__CORE__BASE_LOG_FOLDER=/airflow/logs
ENV AIRFLOW__CORE__PLUGINS_FOLDER=/airflow/plugins
ENV AIRFLOW__CORE__EXECUTOR=SequentialExecutor
ENV AIRFLOW__CORE__SQL_ALCHEMY_CONN=sqlite:////airflow/airflow.db
ENV AIRFLOW__CORE__LOAD_EXAMPLES=False

COPY dags/ /airflow/dags
COPY entrypoint.sh /
CMD ["/entrypoint.sh"]
