output "petname" {
    value = random_pet.anji.id
  
}

output "vnetname" {
    value = azurerm_virtual_network.vnetname.name
  
}

output "rgname" {
    value = azurerm_resource_group.rgname.name
  
}

output "password" {
    value = random_string.id.result
  
}