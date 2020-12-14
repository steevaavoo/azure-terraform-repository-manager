# Build container image
# Uploads files to ACR and builds in Azure

# Ensure any errors fail the build
$ErrorActionPreference = "Stop"

# # This for local testing only.
# $container_registry_name = "stvcontreg1"
# $CONTAINER_IMAGE_NAME = "nodeapp"
# az acr login --name $container_registry_name
# $acrRepoTags = az acr repository show-tags --name $container_registry_name --repository $CONTAINER_IMAGE_NAME | ConvertFrom-Json

Push-Location ..\app

# Logging in to our container registry
az acr login --name $env:CONTAINER_REGISTRY_NAME

# Check if tag already exists in ACR
$acrRepoTags = az acr repository show-tags --name $env:CONTAINER_REGISTRY_NAME --repository $env:CONTAINER_IMAGE_NAME | ConvertFrom-Json

if ($env:CONTAINER_IMAGE_TAG -notin $acrRepoTags) {

    # Local build
    # Format: repo/image:tag
    # docker build . -t adamrushuk/nodeapp:latest

    # ACR build
    $message = "Building docker image via ACR"
    Write-Output "STARTED: $message..."
    az acr build --image $env:CONTAINER_IMAGE_TAG_FULL --registry $env:CONTAINER_REGISTRY_NAME .
    Write-Output "FINISHED: $message."
} else {
    Write-Output "SKIPPING: Building docker image via ACR...[CONTAINER_IMAGE_TAG '$env:CONTAINER_IMAGE_TAG'] already exists."
}

Pop-Location
