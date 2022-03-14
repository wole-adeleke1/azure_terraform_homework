locals {
  sub_name      = "subscription_1"
  address_space = "10.0.2.0/24"
}

provider "azurerm" {
  features {}
  subscription_id = "1e3204d8-6b7b-4f3c-a22e-7b4b17703b33"
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
output "used_priority" {
    value = module.Networking.used_priority
}