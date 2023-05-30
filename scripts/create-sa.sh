#!/bin/bash

# This script is used to create a long lived OCP token for use in GitHub Actions
# You must be logged in to the cluster as a user with cluster-admin privileges to run this script.

# First, name your Service Account (the Kubernetes shortname is "sa")
export SA=github-actions-sa
# and create it.
oc project default
oc create sa $SA

# Now, we have to find the name of the secret in which the Service Account's apiserver token is stored.
# The following command will output two secrets. 
export SECRETS=$(oc get sa $SA -o jsonpath='{.secrets[*].name}{"\n"}') && echo $SECRETS
# Select the one with "token" in the name - the other is for the container registry.
export SECRET_NAME=$(printf "%s\n" $SECRETS | grep "token") && echo $SECRET_NAME

# Get the token from the secret. 
export ENCODED_TOKEN=$(oc get secret $SECRET_NAME -o jsonpath='{.data.token}{"\n"}') && echo $ENCODED_TOKEN;
export TOKEN=$(echo $ENCODED_TOKEN | base64 -d) && echo $TOKEN