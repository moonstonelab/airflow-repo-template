from airflow import DAG
from datetime import datetime, timedelta


class BaseDAG(DAG):
    def __init__(
        self,
        dag_id,
        schedule_interval=None,
        start_date=datetime(2023, 1, 1),
        catchup=False,
        tags=None,
        default_args=None,
        *args,
        **kwargs
    ):
        if default_args is None:
            default_args = {
                "owner": "airflow",
                "depends_on_past": False,
                "email_on_failure": False,
                "email_on_retry": False,
                "retries": 1,
                "retry_delay": timedelta(minutes=5),
            }

        if tags is None:
            tags = []

        super().__init__(
            dag_id=dag_id,
            schedule_interval=schedule_interval,
            start_date=start_date,
            catchup=catchup,
            tags=tags,
            default_args=default_args,
            *args,
            **kwargs
        )
