# Providers (pin all versions)
# Terraform Remote State
terraform {
  required_version = ">= 0.12"
  backend "azurerm" {
    # storage_account_name = ""
    # container_name       = "terraform"
    key                  = "terraform.tfstate"
    # access_key           = ""
  }
}

# https://github.com/terraform-providers/terraform-provider-azurerm/releases
provider "azurerm" {
  version = "=2.38.0"
}
