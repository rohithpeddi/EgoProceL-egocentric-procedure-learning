#!/bin/bash

path="/data/egoproceldata/"

# Find and delete all folders named "log_tests"
find "$path" -type d -name "logs_test" -exec sudo rm -rf {} +

echo "Deletion complete."
