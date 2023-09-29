resource "azurerm_resource_group" "rgname" {
    name = "${random_pet.name.id}-rg"
    location = var.location
}

resource "random_pet" "name" {}

resource "azurerm_network_security_group" "vnetsg" {
    name = var.vnetsg
    location = var.location
    resource_group_name = azurerm_resource_group.rgname.name
    security_rule {
        name                       = "Web"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "22"
        destination_port_range     = "8080"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
  
}

resource "azurerm_virtual_network" "vnetname" {
    name = var.vnetname
    location = var.location
    resource_group_name = azurerm_resource_group.rgname.name
    address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subname" {
  name                 = var.subnet1
  resource_group_name  = azurerm_resource_group.rgname.name
  virtual_network_name = azurerm_virtual_network.vnetname.name
  address_prefixes     = ["10.0.2.0/24"]
}

