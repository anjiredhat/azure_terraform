resource "azurerm_virtual_network" "vnetname" {
    name = "${random_pet.anji.id}-vnet"
    location = var.location
    resource_group_name = azurerm_resource_group.rgname.name
    address_space       = ["10.0.0.0/16"]
  
}

resource "azurerm_subnet" "suname" {
    name = "${random_pet.anji.id}-subname"
    resource_group_name = azurerm_resource_group.rgname.name
    virtual_network_name = azurerm_virtual_network.vnetname.name
    address_prefixes = [ "10.0.2.0/24" ]

}