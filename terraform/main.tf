resource "azurerm_resource_group" "aks" {
  name     = var.azure_resourcegroup_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "steevaavoo-aks1"
  location            = azurerm_resource_group.aks.location
  resource_group_name = azurerm_resource_group.aks.name
  dns_prefix          = var.prefix

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Dev"
  }
}

