ARG AIRFLOW_VERSION=2.9.3

# Use the latest official Apache Airflow image
FROM apache/airflow:${AIRFLOW_VERSION}
USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    libopenmpi-dev \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER airflow

ARG AIRFLOW_CUSTOM_LOC=/opt/airflow
# ARG AF_LOC_WHEELS=${AIRFLOW_CUSTOM_LOC}/wheels # Uncomment to use custom wheels
ARG AF_LOC_DAGS=${AIRFLOW_CUSTOM_LOC}/dags

COPY requirements.txt ${AIRFLOW_CUSTOM_LOC}/requirements.txt
# COPY requirements_whl.txt ${AIRFLOW_CUSTOM_LOC}/requirements_whl.txt # Uncomment to use custom wheels
RUN pip install --upgrade pip
RUN pip install --no-cache-dir "apache-airflow==${AIRFLOW_VERSION}" -r ${AIRFLOW_CUSTOM_LOC}/requirements.txt
# COPY --chown=airflow:root wheels ${AF_LOC_WHEELS} # Uncomment to use custom wheels
# RUN pip install --no-cache-dir -r ${AIRFLOW_CUSTOM_LOC}/requirements_whl.txt # Uncomment to use custom wheels
COPY --chown=airflow:root src/ ${AF_LOC_DAGS}
ENV AIRFLOW__CORE__DAGS_FOLDER=${AF_LOC_DAGS}
