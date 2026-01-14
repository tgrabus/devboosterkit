data "azurerm_client_config" "current" {}

data "azuread_group" "sql_administrator_group" {
  display_name     = var.sql_administrator_group
  security_enabled = true
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