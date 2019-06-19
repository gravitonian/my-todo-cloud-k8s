#!/bin/bash

# Setting -e and -v as pert https://docs.travis-ci.com/user/customizing-the-build/#Implementing-Complex-Build-Steps
# -e: immediately exit if any command has a non-zero exit status
# -v: print all lines in the script before executing them
# -o: prevents errors in a pipeline from being masked
set -euo pipefail

# IFS new value is less likely to cause confusing bugs when looping arrays or arguments (e.g. $@)
IFS=$'\n\t'

# Set up AWS credentials to use
export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION

echo "Add our private helm repo"
helm repo add $HELM_PRIVATE_REPO_NAME

echo "Updating chart lists..."
helm repo update

echo "Installing release"
helm upgrade --set todoVersion=1.0.$TRAVIS_BUILD_NUMBER $HELM_TODO_RELEASE_NAME
