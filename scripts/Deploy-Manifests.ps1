# Deploy kubernetes manifest files

# Ensure any errors fail the build
$ErrorActionPreference = "Stop"

Push-Location ..\manifests

# Replace tokens
<#
    # local testing - manually add env vars
    $env:EMAIL_ADDRESS = "admin@domain.com"
    $env:DNS_DOMAIN_NAME = "aks.bakersfoundry.co.uk"
    $env:CERT_API_ENVIRONMENT = "staging"
#>
# ./scripts/Replace-Tokens.ps1 -targetFilePattern './manifests/*.yml'

# Setting k8s current context
$message = "Merging AKS credentials"
Write-Output "`nSTARTED: $message..."
az aks get-credentials --resource-group $env:TF_VAR_azure_resourcegroup_name --name $env:TF_VAR_azurerm_kubernetes_cluster_name --overwrite-existing
Write-Output "FINISHED: $message.`n"

# Testing kubectl
kubectl version --short

# Apply manifests
$message = "Applying Kubernetes manifests"
Write-Output "`nSTARTED: $message..."

# "ingress-tls" namespace created in Deploy-Ingress-Controller.ps1

# [OPTIONAL] apply whole folder
# kubectl apply -n ingress-tls -f ./manifests

# # ClusterIssuers
# Write-Output "`nAPPLYING: ClusterIssuers..."
# kubectl apply -f ./manifests/cluster-issuer-staging.yml
# kubectl apply -f ./manifests/cluster-issuer-prod.yml
# Applications
Write-Output "`nAPPLYING: Applications..."
# kubectl apply -n ingress-tls -f ./manifests/azure-vote.yml with customisations from kustomization.yaml
# Process a kustomization directory
kubectl apply --kustomize .
kubectl apply --namespace nodeapp --filename ./nodeapp.yml

# # Ingress
# Write-Output "`nAPPLYING: Ingress..."
# kubectl apply -n ingress-tls -f ./manifests/ingress.yml

<#
# DEBUG
kubectl delete -n ingress-tls -f ./manifests/ingress.yml
kubectl delete -n ingress-tls -f ./manifests/azure-vote.yml
#>
Write-Output "FINISHED: $message."

Pop-Location
