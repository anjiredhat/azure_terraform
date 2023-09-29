resource "azurerm_network_interface" "vmnic" {
    name = var.vmnic
    resource_group_name = azurerm_resource_group.rgname.name
    location = var.location

    ip_configuration {
      name = "myNicConfiguration"
      subnet_id = azurerm_subnet.subname.id
      private_ip_address = "Dynamic"
    }  
  
}