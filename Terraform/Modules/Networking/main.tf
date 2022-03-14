resource "azurerm_virtual_network" "example" {
  name                = var.sub_name
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
  address_space       = [var.address_space]
}

resource "azurerm_subnet" "example" {
  name                 = "Subnet_1"
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = [var.address_space]
}

resource "azurerm_network_security_group" "example" {
  name                = "acceptanceTestSecurityGroup1"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}

resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.example.id
}

resource "azurerm_network_security_rule" "example" {
  name                        = "test123"
  priority                    = local.next_priority
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "subscription_1"
  network_security_group_name = azurerm_network_security_group.example.name
}

data "azurerm_network_security_group" "lookup_priority" {
  name                = azurerm_network_security_group.example.name
  resource_group_name = var.resource_group.name

  depends_on = [
    azurerm_network_security_group.example
  ]
}

resource "random_integer" "priority" {
  min = local.max_priority
  max = 4096
}

locals {
    used_priority = data.azurerm_network_security_group.lookup_priority.security_rule[*].priority
    max_priority = max(local.used_priority...) 
    next_priority = random_integer.priority.result
}

output "used_priority" {
    value = local.used_priority
}