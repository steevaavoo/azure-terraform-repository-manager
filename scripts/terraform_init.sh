#!/bin/bash

set -euo pipefail
trap "echo 'error: Script failed: see failed command above'" ERR

# Passing env vars via -backend-config args since they don't work when called
# referenced inside the providers.tf file
# https://github.com/hashicorp/terraform/issues/13022
terraform init -backend-config="storage_account_name=$TERRAFORM_STORAGE_ACCOUNT" \
               -backend-config="access_key=$STORAGE_KEY" \
               -backend-config="container_name=$TERRAFORM_STORAGE_CONTAINER_NAME"
