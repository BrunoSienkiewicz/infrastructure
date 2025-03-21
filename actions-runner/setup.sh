#!/bin/bash

# Check if .env file exists
if [ -f .env ]; then
    # Source the .env file
    source .env
else
    echo "Error: .env file not found"
    exit 1
fi

# Check if arguments are provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <repository_name>"
    exit 1
fi

# Get repository name and deployment name from arguments
REPO_NAME=$1

# Check if the repository name and deployment name are provided
if [ -z "$REPO_NAME" ]; then
    echo "Error: Repository name name not provided"
    exit 1
fi

kubectl create ns github

# Create the secret
kubectl -n github create secret generic "$REPO_NAME-secret" \
  --from-literal=GITHUB_PERSONAL_TOKEN="$GITHUB_PERSONAL_TOKEN" \
  --from-literal=GITHUB_OWNER="$GITHUB_OWNER" \
  --from-literal=GITHUB_REPOSITORY="$REPO_NAME" 

sed -e "s/{ { SECRET_NAME } }/$REPO_NAME-secret/g" \
  -e "s/{ { RUNNER_NAME } }/$REPO_NAME-runner/g" \
  deployment.yaml > deployment_generated.yaml

# Apply the generated deployment YAML file
kubectl -n github apply -f deployment_generated.yaml

# Clean up generated files
rm deployment_generated.yaml

unset REPO_NAME GITHUB_PERSONAL_TOKEN GITHUB_OWNER GITHUB_REPOSITORY

