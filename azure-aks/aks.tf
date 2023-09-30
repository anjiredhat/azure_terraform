resource "random_pet" "anji" {}

resource "azurerm_resource_group" "rgname" {
    name = "${random_pet.anji.id}-aks"
    location = var.location  
}

resource "azurerm_kubernetes_cluster" "azureaks" {
    name = "${random_pet.anji.id}-azureaks"
    location = var.location
    resource_group_name = azurerm_resource_group.rgname.name
    dns_prefix = var.aksdns
    
    default_node_pool {
      name = "polagoni"
      node_count = var.nodecount
      vm_size    = "Standard_D2_v2"
      os_disk_size_gb = 30
    }

    service_principal {
      client_id = var.app_id
      client_secret = var.app_password
    }

    role_based_access_control_enabled = true
    tags = {
        environment = var.env
    }
  
}