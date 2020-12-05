#!/bin/bash

set -euo pipefail
trap "echo 'error: Script failed: see failed command above'" ERR

# https://www.terraform.io/docs/commands/apply.html
terraform apply -auto-approve tfplan
