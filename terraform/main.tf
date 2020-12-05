resource "azurerm_resource_group" "aks" {
  name     = var.azure_resourcegroup_name
  location = var.location
}
