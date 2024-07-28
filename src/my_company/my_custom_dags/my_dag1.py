# pyright: basic
from my_company.my_custom_dags.base_dag import BaseDAG
from airflow.operators.bash import BashOperator


class MyCustomDAG1(BaseDAG):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

    def build(self):
        # Define your DAG tasks here
        self.add_task(BashOperator(task_id="task1", bash_command="echo 'Hello World'"))


my_custom_dag1 = MyCustomDAG1(dag_id="my_custom_dag1")
my_custom_dag1.build()
