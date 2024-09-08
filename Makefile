VENV_DIR := venv
PYTHON := $(VENV_DIR)/bin/python
PIP := $(VENV_DIR)/bin/pip


.PHONY: all
all: install


$(VENV_DIR):
	python3 -m venv $(VENV_DIR)


install: $(VENV_DIR)
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt


run: $(VENV_DIR) install
	$(PYTHON) app.py


clean:
	rm -rf $(VENV_DIR)
	find . -name '__pycache__' -type d -exec rm -rf {} +


help:
	@echo "Makefile for Python app"
	@echo "Usage:"
	@echo "  make            - Default target, install dependencies and run the app"
	@echo "  make install    - Install the dependencies from requirements.txt"
	@echo "  make run        - Run the application"
	@echo "  make clean      - Clean the virtual environment and cache files"
	@echo "  make help       - Display this help message"
