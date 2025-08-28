module "azure_location" {
  source   = "azurerm/locations/azure"
  version  = "0.2.6"
  location = var.location
}

data "azurecaf_name" "this" {
  resource_type = var.resource_type
  suffixes      = local.name_suffixes
  clean_input   = true
}