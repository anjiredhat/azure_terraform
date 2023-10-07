resource "random_pet" "mdvnet" {}

resource "azurerm_resource_group" "mdrg" {
    name = "${random_pet.mdvnet.id}-rg"
    location = var.location
  
}

resource "azurerm_virtual_network" "mdvnet" {
    name = "${random_pet.mdvnet.id}-vnet"
    location = var.location
    resource_group_name = azurerm_resource_group.mdrg.name
    address_space = ["10.0.0.0/16"] 
}

resource "azurerm_subnet" "mdsub" {
    name = "${random_pet.mdvnet.id}-sub"
    resource_group_name = azurerm_resource_group.mdrg.name
    virtual_network_name = azurerm_virtual_network.mdvnet.name
    address_prefixes     = ["10.0.2.0/24"]
  
}

resource "azurerm_network_interface" "mdnic" {
    name = "${random_pet.mdvnet.id}-nic"
    location = var.location
    resource_group_name = azurerm_resource_group.mdrg.name

    ip_configuration {
      name = "${random_pet.mdvnet.id}-ipc"
      subnet_id = azurerm_subnet.mdsub.id
      private_ip_address_allocation = "Dynamic"
    }
  
}