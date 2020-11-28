#!/bin/bash

set -euo pipefail
trap "echo 'error: Script failed: see failed command above'" ERR

message="Getting Storage Account Key"
echo "STARTED: $message..."
storage_key=$(az storage account keys list --resource-group "$TERRAFORM_STORAGE_RG" --account-name "$TERRAFORM_STORAGE_ACCOUNT" --query [0].value --output tsv)
echo "FINISHED: $message."

# Write-Verbose "Storage Key is: [$storage_key]"

# https://docs.github.com/en/free-pro-team@latest/actions/reference/workflow-commands-for-github-actions#setting-an-environment-variable
# Dynamically update GitHub Workflow Environment Variable
echo "STORAGE_KEY=$storage_key" >> "$GITHUB_ENV"
