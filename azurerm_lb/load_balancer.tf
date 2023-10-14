resource "random_pet" "lbname" {}

resource "azurerm_resource_group" "lbrg" {
    name = "${random_pet.lbname.id}lb"
    location = var.location
}

resource "azurerm_public_ip" "lbpi" {
    name = "${random_pet.lbname.id}pubip"
    resource_group_name = azurerm_resource_group.lbrg.name
    location = var.location
    allocation_method = "Dynamic"
  
}

resource "azurerm_lb" "lbname" {
    name = "${random_pet.lbname.id}alb"
    resource_group_name = azurerm_resource_group.lbrg.name
    location = var.location

    frontend_ip_configuration {
      name = "publicip"
      public_ip_address_id = azurerm_public_ip.lbpi.id

    }
  
}

resource "azurerm_lb_backend_address_pool" "example" {
  loadbalancer_id = azurerm_lb.lbname.id
  name            = "BackEndAddressPool"
}