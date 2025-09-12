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

  enabled_metric {
    category = "Basic"
  }

  enabled_metric {
    category = "InstanceAndAppAdvanced"
  }
}

resource "azurerm_monitor_metric_alert" "elastic_pool" {
  for_each            = local.elastic_pool.alerts
  name                = "${module.naming_pool.result}-${each.key}"
  resource_group_name = module.resource_group.name
  scopes              = [module.elastic_pool.resource_id]
  frequency           = each.value.frequency
  window_size         = each.value.window
  severity            = each.value.severity
  tags                = var.tags

  action {
    action_group_id = var.action_group_id
  }

  dynamic "criteria" {
    for_each = each.value.criterias

    content {
      metric_namespace = "microsoft.sql/servers/elasticpools"
      operator         = "GreaterThan"
      metric_name      = criteria.value.metric_name
      aggregation      = criteria.value.aggregation
      threshold        = criteria.value.threshold
    }
  }
}