# Azure App Service Plan Module

This module creates an Azure App Service Plan for hosting web applications, APIs, and mobile backends. Based on Azure Verified Modules (AVM), it provides configurable SKU tiers, operating system support, auto-scaling capabilities, and zone balancing for high availability.

## Usage

### Example - Basic App Service Plan

```terraform
module "service_plan" {
  source = "./modules/service_plan"

  # Basic naming and location variables
  instance          = 1
  location          = "West Europe"
  stage             = "dev"
  product           = "dbk"
  short_description = "web"
  
  # Resource group
  resource_group_name = "rg-dbk-dev-westeurope-01"

  # App Service Plan configuration
  os_type  = "Linux"
  sku_name = "P1v3"

  # Scaling and availability properties
  properties = {
    per_site_scaling_enabled        = true
    worker_count                    = 2
    zone_balancing_enabled          = true
    maximum_elastic_worker_count    = 10
    premium_plan_auto_scale_enabled = true
  }

  # Action group for alerts
  action_group_id = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-monitoring/providers/Microsoft.Insights/actionGroups/ag-dbk-webapp-alerts"

  # Tags
  tags = {
    environment = "dbk-dev-westeurope"
    project     = "digital-transformation"
  }
}
```