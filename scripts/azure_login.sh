#!/bin/bash

# Error catching
# -e  Exit immediately if a command exits with a non-zero status.
# -u  Treat unset variables as an error when substituting. (script will fail if unset variables are found)
# -o option-name
#       pipefail     the return value of a pipeline is the status of
#                    the last command to exit with a non-zero status,
#                    or zero if no command exited with a non-zero status

set -euo pipefail
trap "echo 'error: Script failed: see failed command above'" ERR

# https://docs.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest#az_login
# Log in with a service principal using client secret.
az login --service-principal --username "$ARM_CLIENT_ID" --password "$ARM_CLIENT_SECRET" --tenant "$ARM_TENANT_ID"
