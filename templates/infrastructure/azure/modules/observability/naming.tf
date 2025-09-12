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

# Naming for a Action Group
module "naming_action_groups" {
  for_each = var.action_groups
  source            = "../naming"
  resource_type     = "azurerm_monitor_action_group"
  stage             = var.stage
  location          = var.location
  instance          = var.instance
  product           = var.product
  short_description = each.key
}