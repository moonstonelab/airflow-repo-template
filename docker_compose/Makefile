AIRFLOW_VERSION ?= 2.9.3
CUSTOM_IMAGE_NAME = my-airflow

dn_docker_compose:
	@curl -LfO 'https://airflow.apache.org/docs/apache-airflow/2.9.3/docker-compose.yaml'

docker_compose_config:
	@chmod +x ./docker_compose_config.sh
	@./docker_compose_config.sh "$(CUSTOM_IMAGE_NAME):latest"

up:
	@chmod +x ./docker_compose_up.sh
	@./docker_compose_up.sh "$(CUSTOM_IMAGE_NAME):latest"

down:
	@docker compose down

clean:
	@docker compose down --volumes --remove-orphans
	@rm -rf ./dags ./logs ./plugins ./config