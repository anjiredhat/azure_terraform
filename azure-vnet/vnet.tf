resource "azurerm_resource_group" "rgname" {
    name = "random_pet.name-anji"
    location = var.location
}

resource "random_pet" "name" {}

resource "azurerm_network_security_group" "vnetsg" {
    name = var.vnetsg
    location = var.location
    resource_group_name = azurerm_resource_group.rgname.name
  
}

resource "azurerm_virtual_network" "vnetname" {
    name = var.vnetname
    location = var.location
    resource_group_name = azurerm_resource_group.rgname.name
    address_space = ["10.0.0.0/16"]
  


    subnet {
      name = var.subnet1
      address_prefix = "10.0.2.0/24"
      security_group = azurerm_network_security_group.vnetsg.id
    }

    tags = {
      env = var.env
    }
}

