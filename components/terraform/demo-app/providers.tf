terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.28.0"
    }
  }
}


variable "json_file_path" {
  type    = string
  default = "./backend.tf.json"
}

locals {
  backend_config = jsondecode(file(var.json_file_path))
}
provider "azurerm" {
  features {}

  subscription_id = local.backend_config["terraform"]["backend"]["azurerm"]["subscription_id"]
  tenant_id       = local.backend_config["terraform"]["backend"]["azurerm"]["tenant_id"]
  client_id       = local.backend_config["terraform"]["backend"]["azurerm"]["client_id"]
  client_secret   = local.backend_config["terraform"]["backend"]["azurerm"]["client_secret"]




}