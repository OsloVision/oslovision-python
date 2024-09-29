# Makefile for OsloVision

# Python interpreter
PYTHON = python3

# Directories
TEST_DIR = tests

# Default target
all: test

# Test target
test:
	cd $(TEST_DIR) && $(PYTHON) test_client.py

# Clean target (optional, for removing compiled Python files)
clean:
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete

.PHONY: all test clean