module "naming" {
  source            = "../naming"
  resource_type     = "azurerm_user_assigned_identity"
  stage             = var.stage
  location          = var.location
  instance          = var.instance
  product           = var.product
  short_description = var.short_description
}