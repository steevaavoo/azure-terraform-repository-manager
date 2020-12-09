#!/bin/bash

# Storage Container
echo "STARTED: Deleting Storage Container..."
az storage container delete --name "$TERRAFORM_STORAGE_CONTAINER_NAME" --account-name "$TERRAFORM_STORAGE_ACCOUNT"
echo "FINISHED: Deleting Storage Container."

# Storage Account
echo "STARTED: Deleting Storage Account..."
az storage account delete --name "$TERRAFORM_STORAGE_ACCOUNT" --resource-group "$TERRAFORM_STORAGE_RG" --yes
echo "FINISHED: Deleting Storage Account."

# Resource Group
echo "STARTED: Deleting Resource Group..."
az group delete --name "$TERRAFORM_STORAGE_RG" --yes
echo "FINISHED: Deleting Resource Group."
