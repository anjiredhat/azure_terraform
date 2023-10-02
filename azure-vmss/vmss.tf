resource "azurerm_resource_group" "rgname" {
    name = "${random_pet.anji.id}-rgvmss"
    location = var.location
}

resource "random_pet" "anji" {}

resource "azurerm_virtual_machine_scale_set" "vmss" {
  name                = "${random_pet.anji.id}-vmss"
  location            = var.location
  resource_group_name = azurerm_resource_group.rgname.name
  upgrade_policy_mode = "Manual"

  sku {
    name     = "Standard_F2"
    tier     = "Standard"
    capacity = 4
  }

   os_profile {
   computer_name_prefix = "vmlab"
   admin_username       = var.admin_user
   admin_password       = random_string.pass.result
   custom_data          = file("web.conf")
 }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  network_profile {
    name    = "TestNetworkProfile"
    primary = true

    ip_configuration {
      name      = "TestIPConfiguration"
      primary   = true
      subnet_id = azurerm_subnet.subname.id
    }
  }

  storage_profile_os_disk {
    name           = "osDiskProfile"
    caching        = "ReadWrite"
    create_option  = "FromImage"
    vhd_containers = ["${azurerm_storage_account.vmss-storage.primary_blob_endpoint}${azurerm_storage_container.vmsscont.name}"]
  }

  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}


resource "random_string" "pass" {
    length = 10
    special = "true"
  
}

