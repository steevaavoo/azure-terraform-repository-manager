#!/bin/bash

set -euo pipefail
trap "echo 'error: Script failed: see failed command above'" ERR

# https://www.terraform.io/docs/commands/plan.html
# Using -out=PATH to store plan
terraform plan -out=tfplan
