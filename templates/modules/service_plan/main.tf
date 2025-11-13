module "this" {
  source                          = "Azure/avm-res-web-serverfarm/azurerm"
  version                         = "0.7.0"
  name                            = module.naming.result
  resource_group_name             = var.resource_group_name
  location                        = var.location
  os_type                         = var.os_type
  sku_name                        = var.sku_name
  per_site_scaling_enabled        = var.properties.per_site_scaling_enabled
  worker_count                    = var.properties.worker_count
  zone_balancing_enabled          = var.properties.zone_balancing_enabled
  maximum_elastic_worker_count    = var.properties.maximum_elastic_worker_count
  premium_plan_auto_scale_enabled = var.properties.premium_plan_auto_scale_enabled
  tags                            = var.tags
}