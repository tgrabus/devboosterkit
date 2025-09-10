# Create Log Analytics
module "this" {
  source                                             = "Azure/avm-res-operationalinsights-workspace/azurerm"
  version                                            = "0.4.2"
  name                                               = module.naming.result
  location                                           = var.location
  resource_group_name                                = module.resource_group.name
  log_analytics_workspace_internet_ingestion_enabled = true
  log_analytics_workspace_internet_query_enabled     = true
  log_analytics_workspace_retention_in_days          = var.retention_in_days
  log_analytics_workspace_sku                        = "PerGB2018"
}