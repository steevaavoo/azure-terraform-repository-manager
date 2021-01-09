#!/bin/bash

set -euo pipefail
trap "echo 'error: Script failed: see failed command above'" ERR

cd ../manifests

# Update kustomization.yaml file
kustomize edit set image nodeapp="$CONTAINER_IMAGE_FQDN:$CONTAINER_IMAGE_TAG"

# Customisations are applied in deploy-manifests.ps1 with --kustomize argument
