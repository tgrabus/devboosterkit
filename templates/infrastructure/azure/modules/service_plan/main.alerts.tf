locals {
  alert_criteria = [
    {
      metric_name = "CpuPercentage"
      aggregation = "Average"
      threshold   = 90
    },
    {
      metric_name = "MemoryPercentage",
      aggregation = "Average"
      threshold   = 90
    },
    {
      metric_name = "DiskQueueLength"
      aggregation = "Average"
      threshold   = 10
    },
    {
      metric_name = "HttpQueueLength"
      aggregation = "Maximum"
      threshold   = 5
    },
    {
      metric_name = "TcpTimeWait"
      aggregation = "Maximum"
      threshold   = 10000
    }
  ]
}

resource "azurerm_monitor_metric_alert" "alerts" {
  for_each            = { for criteria in local.alert_criteria : criteria.metric_name => criteria }
  name                = "${module.naming.result}-${each.key}"
  resource_group_name = var.resource_group_name
  scopes              = [module.this.resource_id]
  tags                = var.tags

  action {
    action_group_id = var.action_group_id
  }

  criteria {
    metric_namespace = "microsoft.web/serverfarms"
    operator         = "GreaterThan"
    metric_name      = each.value.metric_name
    aggregation      = each.value.aggregation
    threshold        = each.value.threshold

    dimension {
      name     = "Instance"
      operator = "Include"
      values   = ["*"]
    }
  }
}
