data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}

data "azurerm_subscription" "all" {
  for_each        = local.target_subscriptions
  subscription_id = each.key
}

data "http" "ip" {
  count = var.allow_access_from_my_ip ? 1 : 0
  url   = "https://api.ipify.org/"
  retry {
    attempts     = 5
    max_delay_ms = 1000
    min_delay_ms = 500
  }
}