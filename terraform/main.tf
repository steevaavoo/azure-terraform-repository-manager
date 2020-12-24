resource "azurerm_resource_group" "stvrg" {
  name     = var.azure_resourcegroup_name
  location = var.location
}

resource "azurerm_container_registry" "stvacr" {
  name                     = var.container_registry_name
  resource_group_name      = azurerm_resource_group.stvrg.name
  location                 = azurerm_resource_group.stvrg.location
  sku                      = var.acr_sku
  admin_enabled            = var.acr_admin_enabled
}

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
