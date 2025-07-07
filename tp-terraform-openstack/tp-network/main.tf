provider "azurerm" {
  features {
  }
}

# resource group
resource "azurerm_resource_group" "network_resource_group" {
  name = var.resource_group_name
  location = "East US"
}

# virtual network
resource "azurerm_virtual_network" "vnet_example" {
  name = "example-vnet"
  address_space = ["10.0.0.0/16"]
  location = azurerm_resource_group.network_resource_group.location
  resource_group_name = azurerm_resource_group.network_resource_group.name
}

#subnet

locals {
  base_subnets = [for i in range(3) : {name = "example-subnet-${i+1}", prefix = ["10.0.${i+1}.0/24"]}]
  test_subnet = var.create_test_subnet ? [{name = "example-subnet-4", prefix = ["10.0.4.0/24"]}] : []
  all_subnets = concat(local.base_subnets, local.test_subnet)
}

resource "azurerm_subnet" "subnet_example" {
  for_each = {for subnet in local.all_subnets : subnet.name => subnet}
  name = each.value.name
  resource_group_name = azurerm_resource_group.network_resource_group.name
  virtual_network_name = azurerm_virtual_network.vnet_example.name
  address_prefixes =  each.value.prefix
}

# Security group

resource "azurerm_network_security_group" "nsg_example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.network_resource_group.location
  resource_group_name = azurerm_resource_group.network_resource_group.name

  security_rule {
    name                       = "allow_http"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_https"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "example_association" {
  for_each = {for subnet in local.all_subnets : subnet.name => subnet}
  subnet_id = azurerm_subnet.subnet_example[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg_example.id
}
