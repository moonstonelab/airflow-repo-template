# Makefile for Python project

# Variables
PYTHON = python3
PIP = pip
VENV = .venv
SRC_DIR = src
TEST_DIR = tests
CUSTOM_IMAGE_NAME = my-airflow
AIRFLOW_VERSION=2.9.3

dev_dep: $(VENV)/bin/activate
	$(PIP) install -r requirements-dev.txt

dep_sync: dev_dep
	@pip install --upgrade pip
	@pip-compile --output-file requirements.txt
	@pip-sync requirements.txt

requirements.txt: dep_sync
	@echo "Created requirements.txt..."

dev_build: Dockerfile requirements.txt
	@echo "Building docker image..."
	docker rmi $(CUSTOM_IMAGE_NAME) || true
	docker build --build-arg AIRFLOW_VERSION=$(AIRFLOW_VERSION) -t $(CUSTOM_IMAGE_NAME) .


test:
	$(PYTHON) -m pytest $(TEST_DIR)

# Clean up
clean:
	rm -rf $(VENV)
	find . -type f -name '*.pyc' -delete
	find . -type d -name '__pycache__' -delete

# Lint the code
lint: dev_dep
	$(VENV)/bin/flake8 $(SRC_DIR) $(TEST_DIR)

# Format the code
format: dev_dep
	$(VENV)/bin/black $(SRC_DIR) $(TEST_DIR)

.PHONY: dep_sync test run clean lint format

