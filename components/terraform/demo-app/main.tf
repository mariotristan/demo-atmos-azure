resource "azurerm_resource_group" "demo_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "demo_vnet" {
  name                = "demo-vnet"
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = azurerm_resource_group.demo_rg.location
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "demo_subnet" {
  name                 = "demo-subnet"
  resource_group_name  = azurerm_resource_group.demo_rg.name
  virtual_network_name = azurerm_virtual_network.demo_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}