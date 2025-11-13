data "azurerm_client_config" "current" {}

data "azuread_group" "sql_administrator_group" {
  display_name     = var.sql_administrator_group
  security_enabled = true
}