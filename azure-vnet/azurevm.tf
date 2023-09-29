resource "random_string" "vm_prefix" {
  length  = 6
  special = false
}

resource "azurerm_linux_virtual_machine" "myterraformvm" {
  name                  = "${random_string.vm_prefix.result}testVM"
  location              = var.location
  resource_group_name   = azurerm_resource_group.rgname.name
  network_interface_ids = [azurerm_network_interface.vmnic.id]

  size = "Standard_B2s"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_username = var.ssh_user
  admin_password = random_string.sshpassword.result
  disable_password_authentication = false
}


resource "random_string" "sshpassword" {
  length  = 20
  special = true
}