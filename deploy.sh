#!/bin/bash

echo "Add our private helm repo"
helm repo add $HELM_PRIVATE_REPO_NAME $HELM_PRIVATE_REPO_URL

echo "Updating chart lists..."
helm repo update

echo "Installing release"
helm upgrade --set todoVersion=1.0.$TRAVIS_BUILD_NUMBER $HELM_TODO_RELEASE_NAME
