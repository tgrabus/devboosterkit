# Naming for Virtual Network
module "vnet_naming" {
  source            = "../naming"
  resource_type     = "azurerm_virtual_network"
  stage             = var.stage
  location          = var.location
  instance          = var.instance
  product           = var.product
  short_description = null
}

# Naming for Subnets
module "subnet_naming" {
  source            = "../naming"
  for_each          = var.subnets
  resource_type     = "azurerm_subnet"
  stage             = var.stage
  location          = var.location
  instance          = var.instance
  product           = var.product
  short_description = each.key
}

# Naming for NSGs
module "nsg_naming" {
  source            = "../naming"
  for_each          = var.subnets
  resource_type     = "azurerm_network_security_group"
  stage             = var.stage
  location          = var.location
  instance          = var.instance
  product           = var.product
  short_description = each.key
}