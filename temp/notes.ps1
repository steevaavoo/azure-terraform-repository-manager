# Notes

# Downloading latest credentials for AKS Cluster
az aks get-credentials --resource-group steevaavoo-rg-aks-dev-001 --name steevaavoo-aks1 --overwrite-existing

# Kustomize Notes

# https://github.com/kubernetes-sigs/kustomize/blob/master/examples/image.md

# change dir
cd manifests

kustomize edit set image -h

# configures kustomization.yaml to target/update image tag only
kustomize edit set image stvcontreg1.azurecr.io/nodeapp:2021-01-09

# configures kustomization.yaml to target/update image and tag
kustomize edit set image nodeapp=nodeappNEW:2020-12-24

# show new output
# Print a set of API resources generated from instructions in a kustomization.yaml file
kubectl kustomize .
kubectl get -k .

# build this kustomization
# Print configuration per contents of kustomization.yaml
kustomize build -h
kustomize build .
kustomize build ~/someApp | kubectl apply -f -

# Process a kustomization directory
kubectl apply -h
kubectl apply --kustomize .

# Helm Manual Install Testing
kubectl config current-context

kubectl create namespace test-gitlab

# upgrade / install - be sure you are in the correct folder
Set-Location charts\gitlab-omnibus
helm upgrade test-gitlab ./ -f values.yaml --install --atomic --namespace test-gitlab --debug --dry-run

# Do it for real
helm upgrade test-gitlab ./ -f values.yaml --install --atomic --namespace test-gitlab --debug

# cleanup
helm uninstall test-gitlab --namespace test-gitlab
kubectl delete namespace test-gitlab
