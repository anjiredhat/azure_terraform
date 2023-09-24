output "petname" {
    value = random_pet.name.id
  
}

output "rgname" {
    value = azurerm_resource_group.rgname.name
}

output "vsg" {
    value = azurerm_network_security_group.vnetsg.name
  
}

output "vnetname" {
    value = azurerm_virtual_network.vnetname.name
  
}
