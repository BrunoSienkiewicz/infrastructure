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
if [ "$#" -ne 2 ]; then
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

# Create the secret
kubectl create secret generic "$REPO_NAME-secret" \
  --from-literal=GITHUB_PERSONAL_TOKEN="$GITHUB_PERSONAL_TOKEN" \
  --from-literal=GITHUB_OWNER="$GITHUB_OWNER" \
  --from-literal=GITHUB_REPOSITORY="$REPO_NAME" 

# Update the deployment to use the secret
kubectl patch deployment "github-runner-$REPO_NAME" \
    --type='json' \
    -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/env/0/valueFrom/secretKeyRef/name", "value": "'"$REPO_NAME"'-secret"}]'

unset REPO_NAME GITHUB_PERSONAL_TOKEN GITHUB_OWNER GITHUB_REPOSITORY

