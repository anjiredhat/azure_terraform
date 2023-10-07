resource "azurerm_virtual_machine" "mdvm" {
    name = "${random_pet.mdvnet.id}-vm"
    location = var.location
    resource_group_name = azurerm_resource_group.mdrg.name
    network_interface_ids = [azurerm_network_interface.mdnic.id]
    vm_size = "Standard_F2"

    storage_image_reference {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts"
      version   = "latest"
    }

    storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
    }

    os_profile {
      computer_name        = "${random_pet.mdvnet.id}-vm"
      admin_username       = "polagoni"
      admin_password       = random_string.pass.result
    }
 
    os_profile_linux_config {
      disable_password_authentication = false
    }
}

resource "azurerm_managed_disk" "vmmd" {
    name = "${random_pet.mdvnet.id}-mdisk"
    location = var.location
    resource_group_name = azurerm_resource_group.mdrg.name
    storage_account_type = "Standard_LRS"
    create_option = "Empty"
    disk_size_gb = 10
  
}

resource "azurerm_virtual_machine_data_disk_attachment" "name" {
    managed_disk_id = azurerm_managed_disk.vmmd.id
    virtual_machine_id = azurerm_virtual_machine.mdvm.id
    lun = "10"
    caching = "ReadWrite"
  
}

resource "random_string" "pass" {
    length = "10"
    special = "true"
  
}

