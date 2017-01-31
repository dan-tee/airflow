#!/bin/sh
if [ ! -e /airflow/initialized ]; then
	> /airflow/initialized
	airflow initdb
fi
airflow webserver -p 8080
