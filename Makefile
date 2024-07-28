# Makefile for Python project

# Variables
PYTHON = python3
PIP = pip
VENV = .venv
SRC_DIR = src
TEST_DIR = tests

dev_dep:
	$(PIP) install -r requirements-dev.txt

dep_sync: dev_dep
	@pip-compile --output-file requirements.txt
	@pip-sync requirements.txt requirements-dev.txt

# Virtual environment
$(VENV)/bin/activate: requirements.txt
	$(PYTHON) -m venv $(VENV)
	$(VENV)/bin/pip install -r requirements.txt

# Install dependencies
install: $(VENV)/bin/activate

# Run tests
test: install
	$(VENV)/bin/pytest $(TEST_DIR)

# Run the main application
run: install
	$(VENV)/bin/python $(SRC_DIR)/main.py

# Clean up
clean:
	rm -rf $(VENV)
	find . -type f -name '*.pyc' -delete
	find . -type d -name '__pycache__' -delete

# Lint the code
lint: install
	$(VENV)/bin/flake8 $(SRC_DIR) $(TEST_DIR)

# Format the code
format: install
	$(VENV)/bin/black $(SRC_DIR) $(TEST_DIR)

.PHONY: install test run clean lint format
