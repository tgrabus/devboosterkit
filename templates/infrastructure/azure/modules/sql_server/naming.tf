# Naming for a Sql Server
module "naming_server" {
  source        = "../naming"
  stage         = var.stage
  location      = var.location
  instance      = var.instance
  product       = var.product
  resource_type = "azurerm_mssql_server"
}

# Naming for a Sql Elastic Pool
module "naming_pool" {
  source        = "../naming"
  stage         = var.stage
  location      = var.location
  instance      = var.instance
  product       = var.product
  resource_type = "azurerm_mssql_elasticpool"
}

# Naming for a Sql Database
module "naming_db" {
  for_each          = var.databases
  source            = "../naming"
  stage             = var.stage
  location          = var.location
  instance          = var.instance
  product           = var.product
  resource_type     = "azurerm_mssql_database"
  short_description = each.key
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