module "elastic_pool" {
  source                = "Azure/avm-res-sql-server/azurerm//modules/elasticpool"
  version               = "0.1.5"
  name                  = module.naming_pool.result
  location              = var.location
  sql_server            = local.sql_server
  sku                   = var.elastic_pool.sku
  per_database_settings = var.elastic_pool.per_database_settings
  max_size_gb           = var.elastic_pool.max_size_gb
  zone_redundant        = var.elastic_pool.zone_redundant
  tags                  = var.tags
}

resource "azurerm_monitor_diagnostic_setting" "elastic_pool" {
  name                       = "diag-la-${module.naming_pool.result}"
  target_resource_id         = module.elastic_pool.resource_id
  log_analytics_workspace_id = var.diagnostic_settings.workspace_resource_id

  metric {
    category = "Basic"
    enabled  = var.diagnostic_settings.enabled
  }

  metric {
    category = "InstanceAndAppAdvanced"
    enabled  = var.diagnostic_settings.enabled
  }
}