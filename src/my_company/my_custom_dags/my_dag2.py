# pyright: basic
from my_company.my_custom_dags.base_dag import BaseDAG
from my_company.common_package.common_module import concatenate_strings
from airflow.operators.python_operator import PythonOperator


class MyCustomDAG2(BaseDAG):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def build(self):
        self.add_task(
            PythonOperator(
                task_id="concatenate_strings_task",
                python_callable=concatenate_strings,
                op_kwargs={"string1": "Hello, ", "string2": "World!"},
            )
        )


my_custom_dag2 = MyCustomDAG2(dag_id="my_custom_dag2")
my_custom_dag2.build()
