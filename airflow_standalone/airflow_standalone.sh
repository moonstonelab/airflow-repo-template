#!/usr/bin/env bash

# Start the Airflow web server
export AIRFLOW_HOME="$(pwd)"
export AIRFLOW__CORE__DAGS_FOLDER="$(dirname $(pwd))/src/"
export AIRFLOW__CORE__LOAD_EXAMPLES=False
airflow standalone