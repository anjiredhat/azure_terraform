resource "azurerm_network_interface" "vmnic" {
    name = var.vmnic
    resource_group_name = azurerm_resource_group.rgname.name
    location = var.location

    ip_configuration {
      name = "myNicConfiguration"
      subnet_id = azurerm_subnet.subname.id
      private_ip_address_allocation = "Dynamic"
    }  
  
}

resource "azurerm_network_interface_security_group_association" "nsgas" {
        network_interface_id      = azurerm_network_interface.vmnic.id
        network_security_group_id = azurerm_network_security_group.vnetsg.id
}