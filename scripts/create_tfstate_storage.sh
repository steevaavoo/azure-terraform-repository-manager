#!/bin/bash

# Resource Group
echo "STARTED: Creating Resource Group..."
az group create --location "$LOCATION" --name "$TERRAFORM_STORAGE_RG"
echo "FINISHED: Creating Resource Group."

# Storage Account
echo "STARTED: Creating Storage Account..."
az storage account create --name "$TERRAFORM_STORAGE_ACCOUNT" --resource-group "$TERRAFORM_STORAGE_RG" --location "$LOCATION" --sku Standard_LRS
echo "FINISHED: Creating Storage Account."

# Storage Container
echo "STARTED: Creating Storage Container..."
az storage container create --name "$TERRAFORM_STORAGE_CONTAINER_NAME" --account-name "$TERRAFORM_STORAGE_ACCOUNT"
echo "FINISHED: Creating Storage Container."
