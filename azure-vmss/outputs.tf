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
    value = random_string.pass.result
  
}


output "vmss_public_ip_fqdn" {
   value = azurerm_public_ip.vmss.fqdn
}

output "jumpbox_public_ip_fqdn" {
   value = azurerm_public_ip.jumpbox.fqdn
}

output "jumpbox_public_ip" {
   value = azurerm_public_ip.jumpbox.ip_address
}