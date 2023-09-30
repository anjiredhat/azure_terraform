output "rgname" {
    value = azurerm_resource_group.rgname.name
  
}

output "petname" {
    value = random_pet.anji.id
  
}

output "clustername" {
    value = azurerm_kubernetes_cluster.azureaks.name
  
}