# Naming for a Log Analytics
module "naming" {
  source            = "../naming"
  resource_type     = "azurerm_log_analytics_workspace"
  stage             = var.stage
  location          = var.location
  instance          = var.instance
  product           = var.product
  short_description = var.short_description
}