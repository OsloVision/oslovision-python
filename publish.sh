#!/bin/bash

# Get the directory of the script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Set the path to .pypirc in the same directory as the script
PYPIRC_PATH="$SCRIPT_DIR/.pypirc"

# Check if .pypirc exists in the script directory
if [ ! -f "$PYPIRC_PATH" ]; then
    echo "Error: .pypirc file not found in the script directory."
    echo "Please ensure .pypirc is in the same directory as this script."
    exit 1
fi

# Ensure we're on the main branch
git checkout main

# Pull the latest changes
git pull origin main

# Remove old distribution files
rm -rf dist build *.egg-info

# Install or upgrade build and twine
pip3 install --upgrade build twine

# Create new distribution files
python3 -m build

# Check the distribution files
twine check dist/*

# Upload to TestPyPI
twine upload --config-file "$PYPIRC_PATH" --repository testpypi dist/*

echo "Uploaded to TestPyPI. Please test the package."
echo "If everything looks good, run this script with the 'prod' argument to upload to PyPI."

# If 'prod' argument is provided, also upload to PyPI
if [ "$1" = "prod" ]; then
    twine upload --config-file "$PYPIRC_PATH" --repository pypi dist/*
    echo "Uploaded to PyPI."
fi