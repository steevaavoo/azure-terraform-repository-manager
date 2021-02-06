# Providers (pin all versions)
# Terraform Remote State
terraform {
  required_version = ">= 0.12"
  backend "azurerm" {
    # storage_account_name = ""
    # container_name       = "terraform"
    key = "terraform.tfstate"
    # access_key           = ""
  }

  # providers (pin all versions)
  # versioning syntax: https://www.terraform.io/docs/configuration/modules.html#module-versions
  required_providers {
    # https://github.com/hashicorp/terraform-provider-helm/releases
    helm = "2.0.2"
    # https://github.com/hashicorp/terraform-provider-kubernetes/releases
    kubernetes = "2.0.2"
  }
}

# https://github.com/terraform-providers/terraform-provider-azurerm/releases
provider "azurerm" {
  version = "2.44.0"
  features {}
}

# Helm/K8s Connectors
# use statically defined credentials
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs#statically-defined-credentials
provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.stvaks.kube_config[0].host
  client_certificate     = base64decode(azurerm_kubernetes_cluster.stvaks.kube_config[0].client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.stvaks.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.stvaks.kube_config[0].cluster_ca_certificate)
}
provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.stvaks.kube_config[0].host
    client_certificate     = base64decode(azurerm_kubernetes_cluster.stvaks.kube_config[0].client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.stvaks.kube_config[0].client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.stvaks.kube_config[0].cluster_ca_certificate)
  }
}
