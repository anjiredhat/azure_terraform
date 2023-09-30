resource "azurerm_public_ip" "polagoni-public" {
    name = var.pubipname
    resource_group_name = azurerm_resource_group.rgname.name
    location = var.location
    allocation_method = "Dynamic"
  
}