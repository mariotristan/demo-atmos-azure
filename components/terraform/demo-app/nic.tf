resource "azurerm_network_interface" "demo_nic" {
  name                = "demo-nic"
  location            = azurerm_resource_group.demo_rg.location
  resource_group_name = azurerm_resource_group.demo_rg.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.demo_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.demo_vm_pip.id
  }
}

resource "azurerm_public_ip" "demo_vm_pip" {
  name                = "demo-vm-public-ip"
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = azurerm_resource_group.demo_rg.location
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = "demo"
  }
}