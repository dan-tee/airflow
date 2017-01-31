# airflow
Samll Alpine image for running Apache Airflow using Numpy and Pandas

## Build
docker build -t airflow-img .

## Startup command
docker run -p 8080:8080 -it --name airflow airflow-img
