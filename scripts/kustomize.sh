#!/bin/bash

set -euo pipefail
trap "echo 'error: Script failed: see failed command above'" ERR

cd ../manifests

# Update kustomization.yaml file
kustomize edit set image "$CONTAINER_IMAGE_TAG_FULL"

# Customisations are applied in deploy-manifests.ps1 with --kustomize argument
