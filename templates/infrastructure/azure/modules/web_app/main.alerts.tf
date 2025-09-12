locals {
  alerts = [
    {
      metric_name = "Http4xx"
      aggregation = "Average"
      alert_sensitivity = "Medium"
      operator = "GreaterThan"
    },
    {
      metric_name = "Http5xx"
      aggregation = "Average"
      alert_sensitivity = "Medium"
      operator = "GreaterThan"
    },
    {
      metric_name = "Requests"
      aggregation = "Average"
      alert_sensitivity = "Medium"
      operator = "GreaterThan"
    },
    {
      metric_name = "RequestsInApplicationQueue"
      aggregation = "Average"
      alert_sensitivity = "Medium"
      operator = "GreaterThan"
    },
    {
      metric_name = "HttpResponseTime"
      aggregation = "Average"
      alert_sensitivity = "Medium"
      operator = "GreaterThan"
    },
  ]
}

resource "azurerm_monitor_metric_alert" "alerts" {
  for_each            = { for alert in local.alerts : alert.metric_name => alert }
  name                = "${module.naming_app_service.result}-${each.key}"
  resource_group_name = var.resource_group_name
  scopes              = [module.this.resource_id]
  tags                = var.tags

  action {
    action_group_id = var.action_group_id
  }

  dynamic_criteria {

    metric_namespace  = "microsoft.web/sites"
    metric_name       = each.key
    operator          = each.value.operator
    aggregation       = each.value.aggregation
    alert_sensitivity = each.value.alert_sensitivity

    dimension {
      name     = "Instance"
      operator = "Include"
      values   = ["*"]
    }
  }
}
