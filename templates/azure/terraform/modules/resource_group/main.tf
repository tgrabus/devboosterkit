resource "azurerm_resource_group" "this" {
  name     = module.naming.result
  location = var.location
  tags = var.tags
}
