# Common
variable "location" {}

variable "azure_resourcegroup_name" {}

variable "prefix" {}

# TODO: make sure variables are placed appropriately if scoped only to Terraform resource creation

variable "azurerm_kubernetes_cluster_name" {
  default = "steevaavoo-aks1"
}

# This should be in the env vars as will be used by az acr login in the Docker image build script
variable "container_registry_name" {
  default = "stvcontreg1"
}

variable "acr_admin_enabled" {
  default = false
}

variable "acr_sku" {
  default = "Basic"
}

variable "node_count" {
  default = 1
}

variable "node_profile_name" {
  default = "default"
}

variable "node_profile_vm_size" {
  default = "Standard_D2_v2"
}

variable "node_profile_os_type" {
  default = "Linux"
}

variable "node_profile_disk_size_gb" {
  default = 30
}

# variable "service_principal_client_id" {
#   default = "__clientid__"
# }

# variable "service_principal_client_secret" {
#   default = "__clientsecret__"
# }

