#!/usr/bin/env bash

export MY_AIRFLOW_PROJ_DIR="$(dirname $(pwd))"
export AIRFLOW_IMAGE_NAME=$1
docker compose up -d