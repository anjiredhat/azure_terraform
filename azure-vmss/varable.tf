variable "location" {
    default = "eastus"
  
}

variable "admin_user" {
    default = "polagoni"
  
}

variable "vmcount" {
    default = 3
  
}

variable "sku" {
    default = "Standard_F2"
  
}

variable "nicname" {
    default = "vmssnic"
  
}

variable "ipconf" {
    default = "vmssconf"
  
}

variable "application_port" {
   description = "Port that you want to expose to the external load balancer"
   default     = 80
}

variable "tags" {
   description = "Map of the tags to use for the resources that are deployed"
   type        = map(string)
   default = {
      environment = "prod"
   }
}

