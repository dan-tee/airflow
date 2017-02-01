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
RUN apk add --no-cache libffi-dev
RUN pip install --no-cache-dir "airflow[postgres, s3, crypto]"   	

ENV AIRFLOW_HOME=/airflow
ENV AIRFLOW__CORE__EXECUTOR=LocalExecutor
ENV AIRFLOW__CORE__SQL_ALCHEMY_CONN='postgresql+psycopg2://daniel:test2017@daniel-etl-test.cj47fhv1c2st.eu-west-1.rds.amazonaws.com:5432/airflowdb'
ENV AIRFLOW__CORE__LOAD_EXAMPLES=False

COPY dags/ /airflow/dags
COPY entrypoint.sh /
CMD ["/entrypoint.sh"]
