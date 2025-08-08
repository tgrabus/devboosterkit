# Naming for a Private Endpoint
module "pe_naming" {
  source            = "../naming"
  resource_type     = "azurerm_private_endpoint"
  stage             = var.stage
  location          = var.location
  instance          = var.instance
  product           = var.product
  short_description = var.short_description
}

# Naming for a Private Service Connection
module "psc_naming" {
  source            = "../naming"
  resource_type     = "azurerm_private_service_connection"
  stage             = var.stage
  location          = var.location
  instance          = var.instance
  product           = var.product
  short_description = var.short_description
}

# Naming for a Network Interface
module "nic_naming" {
  source            = "../naming"
  resource_type     = "azurerm_network_interface"
  stage             = var.stage
  location          = var.location
  instance          = var.instance
  product           = var.product
  short_description = var.short_description
}