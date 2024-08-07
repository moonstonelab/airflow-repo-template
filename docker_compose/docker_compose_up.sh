#!/usr/bin/env bash

export MY_AIRFLOW_PROJ_DIR="$(dirname $(pwd))"
export AIRFLOW_IMAGE_NAME=$1
export AIRFLOW_UID=$2
docker compose up -d