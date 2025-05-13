variable "location" {
  description = "Azure region where resources will be created"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "DemoRG"
}

variable "vm_name" {
  description = "Virtual Machine name"
  type        = string
  default     = "HelloWorldVM"
}

variable "vm_size" {
  description = "VM instance size"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "adminuser"
}

variable "public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "frontdoor_name" {
  description = "Name of Azure Front Door"
  type        = string
  default     = "hello-world-frontdoor"
}


variable "stage" {
  description = "Stage of the deployment (e.g., dev, prod)"
  type        = string
  default     = "dev"
}






