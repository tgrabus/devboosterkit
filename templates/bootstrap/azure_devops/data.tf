data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}

data "azurerm_subscription" "all" {
  for_each        = local.target_subscriptions
  subscription_id = each.key
}