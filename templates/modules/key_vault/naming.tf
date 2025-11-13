# Naming for a Key Vault
module "naming_kv" {
  source            = "../naming"
  resource_type     = "azurerm_key_vault"
  stage             = var.stage
  location          = var.location
  instance          = var.instance
  product           = var.product
  short_description = var.short_description
}

# Naming for a Private Endpoint
module "naming_pe" {
  for_each          = var.private_endpoints
  source            = "../naming"
  resource_type     = "azurerm_private_endpoint"
  stage             = var.stage
  location          = var.location
  instance          = var.instance
  product           = var.product
  short_description = each.key
}

# Naming for a Private Service Connection
module "naming_psc" {
  for_each          = var.private_endpoints
  source            = "../naming"
  resource_type     = "azurerm_private_service_connection"
  stage             = var.stage
  location          = var.location
  instance          = var.instance
  product           = var.product
  short_description = each.key
}

# Naming for a Network Interface
module "naming_nic" {
  for_each          = var.private_endpoints
  source            = "../naming"
  resource_type     = "azurerm_network_interface"
  stage             = var.stage
  location          = var.location
  instance          = var.instance
  product           = var.product
  short_description = each.key
}