resource "azurerm_resource_group" "rgname" {
    name = "${random_pet.anji.id}-vmss"
    location = var.location
}

resource "random_pet" "anji" {}

resource "azurerm_virtual_machine_scale_set" "vmss" {
    name = "${random_pet.anji.id}-vmssname"
    location = var.location
    resource_group_name = azurerm_resource_group.rgname.name
    upgrade_policy_mode = "Manual"

    sku {
      name     = "Standard_DS1_v2"
      tier     = "Standard"
      capacity = 2
    }
    

    os_profile {
      computer_name_prefix = "vmss"
      admin_username       = var.ssh_user
      admin_password       = random_string.id.result
    }

    os_profile_linux_config {
      disable_password_authentication = false
      }

    source_image_reference {
      publisher = "Canonical"
      offer     = "0001-com-ubuntu-server-focal"
      sku       = "20_04-lts"
      version   = "latest"
    }

    os_disk {
      storage_account_type = "Standard_LRS"
      caching              = "ReadWrite"
    }

    network_interface {
      name    = var.nicname
      primary = "true"

      ip_configuration {
        name      = var.ipconf
        primary   = "true"
        subnet_id = azurerm_subnet.subname.id
      }
    }

   network_profile {
      name    = "terraformnetworkprofile"
      primary = true
   }
}

resource "random_string" "id" {
    length = "10"
    special = "true"
  
}


