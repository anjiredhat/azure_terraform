resource "azurerm_storage_account" "vmss-storage" {
    name = "${random_pet.anji.id}vmss-storage"
    location = var.location
    resource_group_name = azurerm_resource_group.rgname.name
    account_tier = "Standard"
    account_replication_type = "LRS"

    tags = {
        env = var.tags
    }
  
}

resource "azurerm_storage_container" "vmsscont" {
    name = "${random_pet.anji.id}vmss-cont"
    storage_account_name = azurerm_storage_account.vmss-storage.name
    container_access_type = "private"
}

