resource "random_password" "password" {
  length           = 16
  special          = true
  upper            = true
  lower            = true
  
  # override_special = "!#$%&*()-_=+[]{}<>:?"
}

locals {
  generated_password = random_password.password.result
}
resource "azurerm_linux_virtual_machine" "demo_vm" {
  name                = var.vm_name
  resource_group_name = azurerm_resource_group.demo_rg.name
  location            = azurerm_resource_group.demo_rg.location
  size                = var.vm_size

  admin_username        = var.admin_username
  admin_password        = local.generated_password
  network_interface_ids = [azurerm_network_interface.demo_nic.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  disable_password_authentication = false

  #   admin_ssh_key {
  #     username   = var.admin_username
  #     public_key = file(var.public_key_path)
  #   }


  connection {
    type     = "ssh"
    user     = var.admin_username
    password = local.generated_password
    host     = azurerm_public_ip.demo_vm_pip.ip_address
  }


  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install -y nginx",
      "echo '<h1>Hello, World!</h1>' | sudo tee /var/www/html/index.html",
      "sudo systemctl restart nginx"
    ]
  }
}