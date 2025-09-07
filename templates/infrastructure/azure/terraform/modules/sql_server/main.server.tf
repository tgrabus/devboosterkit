module "server" {
  source                        = "Azure/avm-res-sql-server/azurerm"
  version                       = "0.1.5"
  name                          = module.naming_server.result
  resource_group_name           = module.resource_group.name
  location                      = var.location
  server_version                = var.server_version
  public_network_access_enabled = var.public_network_access_enabled
  azuread_administrator         = local.azuread_administrator
  private_endpoints             = local.private_endpoints
  managed_identities            = local.managed_identities
  firewall_rules                = var.public_network_access_enabled ? local.firewall_rules : {}
  tags                          = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "sql_server" {
  name                       = "diag-la-${module.naming_server.result}"
  target_resource_id         = module.server.resource_id
  log_analytics_workspace_id = var.diagnostic_settings.workspace_resource_id

  enabled_metric {
    category = "AllMetrics"
  }
}