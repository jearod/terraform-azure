# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.90.0"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
  skip_provider_registration = true
}

resource "azurerm_virtual_network" "my_virtual_network" {
  name                = "myVirtualNetwork"
  address_space       = ["10.0.0.0/16"]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "mySubnet" {
  name                   = "mySubnet"
  virtual_network_name    = azurerm_virtual_network.my_virtual_network.name
  address_prefixes       = ["10.0.17.0/24"]
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface" "myNic" {
  name                = "myNIC"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "myNicConfiguration"
    subnet_id                     = azurerm_subnet.mySubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}