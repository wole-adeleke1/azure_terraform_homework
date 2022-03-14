locals {
  sub_name      = "subscription_1"
  address_space = "10.0.3.0/24"
}

provider "azurerm" {
  features {}
  subscription_id = "de31869a-66d5-4aa5-ba2e-7ddfb0326f1b"
}

resource "azurerm_resource_group" "example" {
  name     = local.sub_name
  location = "West Europe"
}

module "Networking" {
  source         = "../../Modules/Networking"
  sub_name       = local.sub_name
  resource_group = azurerm_resource_group.example
  address_space  = local.address_space
}
