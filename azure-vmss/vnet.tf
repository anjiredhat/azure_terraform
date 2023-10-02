resource "azurerm_virtual_network" "vnetname" {
    name = "${random_pet.anji.id}-vnet"
    location = var.location
    resource_group_name = azurerm_resource_group.rgname.name
    address_space       = ["10.0.0.0/16"]
  
}

resource "azurerm_subnet" "subname" {
    name = "${random_pet.anji.id}-subname"
    resource_group_name = azurerm_resource_group.rgname.name
    virtual_network_name = azurerm_virtual_network.vnetname.name
    address_prefixes = [ "10.0.2.0/24" ]

}

resource "azurerm_public_ip" "vmss" {
 name                         = "vmss-public-ip"
 location                     = var.location
 resource_group_name          = azurerm_resource_group.vmss.name
 allocation_method            = "Static"
 domain_name_label            = random_string.fqdn.result
 tags                         = var.tags
}