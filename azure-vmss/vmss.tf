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

   network_profile {
      name    = "terraformnetworkprofile"
      primary = true

      ip_configuration {
        name      = var.ipconf
        primary   = "true"
        subnet_id = azurerm_subnet.subname.id
      }
   }

   storage_profile_os_disk {
   name              = ""
   caching           = "ReadWrite"
   create_option     = "FromImage"
   managed_disk_type = "Standard_LRS"
 }
}

resource "random_string" "id" {
    length = "10"
    special = "true"
  
}


