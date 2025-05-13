resource "azurerm_public_ip" "lb_pip" {
  name                = "lb-public-ip"
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = azurerm_resource_group.demo_rg.location
  allocation_method   = "Static"
}

resource "azurerm_lb" "demo_lb" {
  name                = "demo-lb"
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = azurerm_resource_group.demo_rg.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend_pool" {
  loadbalancer_id = azurerm_lb.demo_lb.id
  name            = "BackendPool"
}


resource "azurerm_network_interface_backend_address_pool_association" "lb_backend_pool_association" {
  network_interface_id    = azurerm_network_interface.demo_nic.id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pool.id
}

resource "azurerm_lb_rule" "demo_lb_rule" {
  loadbalancer_id                = azurerm_lb.demo_lb.id
  name                           = "HTTPRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "PublicIPAddress"
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.lb_backend_pool.id]
  probe_id                       = azurerm_lb_probe.lb_probe.id

}


resource "azurerm_lb_probe" "lb_probe" {
  loadbalancer_id = azurerm_lb.demo_lb.id
  name            = "http-running-probe"
  port            = 80
}