module "naming" {
  source            = "../naming"
  resource_type     = "azurerm_app_service_plan"
  stage             = var.stage
  location          = var.location
  instance          = var.instance
  product           = var.product
  short_description = var.short_description
}