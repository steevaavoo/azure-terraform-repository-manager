resource "azurerm_resource_group" "stvrg" {
  name     = var.azure_resourcegroup_name
  location = var.location
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry
resource "azurerm_container_registry" "stvacr" {
  name                = var.container_registry_name
  resource_group_name = azurerm_resource_group.stvrg.name
  location            = azurerm_resource_group.stvrg.location
  sku                 = var.acr_sku
  admin_enabled       = var.acr_admin_enabled
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster
resource "azurerm_kubernetes_cluster" "stvaks" {
  name                = var.azurerm_kubernetes_cluster_name
  resource_group_name = azurerm_resource_group.stvrg.name
  location            = azurerm_resource_group.stvrg.location
  dns_prefix          = var.prefix

  default_node_pool {
    name       = var.node_profile_name
    node_count = var.node_count
    vm_size    = var.node_profile_vm_size
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }
}

# Create Role Assignment for AKS to Pull from Container Registry
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment
# ! A custom role needs to be created and assigned to the Subscription in order that terraform
# ! has sufficient permissions to create this Role Assignment
# ! https://github.com/adamrushuk/devops-lab/tree/develop/scripts
# depends_on not required here because dependency is implicit thanks to using resource ids rather than
# env variables or hard-coded values - terraform will wait until "azurerm_container_registry.stvacr.id" and
# the "azurerm_kubernetes_cluster....." exists
resource "azurerm_role_assignment" "stvacr" {
  scope                = azurerm_container_registry.stvacr.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.stvaks.kubelet_identity[0].object_id
}

resource "helm_release" "gitlab" {
  name             = "gitlab-omnibus"
  chart            = "../charts/gitlab-omnibus"
  namespace        = "gitlab"
  create_namespace = true
  atomic           = true
  values           = ["values.yaml"]
  depends_on = [ azurerm_kubernetes_cluster.stvaks ]
}
