resource "azurerm_network_security_group" "allow_access_to_vm" {
  name                = "allow-ssh"
  location            = azurerm_resource_group.demo_rg.location
  resource_group_name = azurerm_resource_group.demo_rg.name

  security_rule {
    name                       = "Allow-SSH-MyIP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "187.161.11.40"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_rule" "allow_http_lb" {
  name                        = "Allow-HTTP-LoadBalancer"
  priority                    = 110
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_port_range      = "80"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.demo_rg.name
  network_security_group_name = azurerm_network_security_group.allow_access_to_vm.name
}

resource "azurerm_network_interface_security_group_association" "nic_nsg" {
  network_interface_id      = azurerm_network_interface.demo_nic.id
  network_security_group_id = azurerm_network_security_group.allow_access_to_vm.id
}