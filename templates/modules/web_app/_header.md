# Azure Web App Module

This module creates an Azure Web App for hosting web applications, APIs, and containerized applications. Based on Azure Verified Modules (AVM), it provides enterprise-grade hosting with managed identities, private endpoints, and Application Insights integration.

## Usage

### Example - Basic Web App with Application Insights

```terraform
module "web_app" {
  source = "./modules/web_app"

  # Basic naming and location variables
  instance          = 1
  location          = "West Europe"
  stage             = "dev"
  product           = "dbk"
  short_description = "api"

  # Resource group
  resource_group_name = "rg-dbk-dev-westeurope-01"

  
  # Operating system and service plan configuration
  os_type                   = "Linux"
  service_plan_resource_id  = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-dbk-dev-westeurope-001/providers/Microsoft.Web/serverfarms/asp-dbk-dev-westeurope-001"
  
  
  # Virtual network integration
  virtual_network_subnet_id = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-network-dev/providers/Microsoft.Network/virtualNetworks/vnet-dbk-dev/subnets/snet-webapp"
  
  
  # Application settings
  app_settings = {
    "ASPNETCORE_ENVIRONMENT" = "Development"
  }
  
  
  # Application stack configuration (.NET 9)
  app_stack = {
    dotnet_version      = "v9.0"
    docker_registry_url = null
    docker_image_name   = null
  }
  
  
  # Security and access settings
  public_network_access_enabled = false
  always_on                    = true
  https_only                   = true
  http2_enabled               = true
  vnet_route_all_enabled      = true
  websockets_enabled          = false
  client_affinity_enabled     = false
  
  
  # Private endpoints configuration
  private_endpoints = {
    "webapp-pe-001" = {
      private_dns_zone_resource_id = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-dns/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net"
      subnet_resource_id           = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-network-dev/providers/Microsoft.Network/virtualNetworks/vnet-dbk-dev/subnets/snet-private-endpoints"
      resource_group_name          = "rg-dbk-dev-westeurope-001"
    }
  }
  
  
  # Allowed IP addresses (for administrators and CI/CD systems)
  allowed_ips = {
    "office-network"     = "203.0.113.0/24"
    "azure-devops-pool"  = "20.190.128.0/18"
  }
  
  
  # Application Insights for monitoring
  application_insights = {
    la_workspace_id     = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-monitoring/providers/Microsoft.OperationalInsights/workspaces/law-dbk-dev"
    retention_in_days   = 90
    resource_group_name = "rg-dbk-dev-westeurope-001"
  }
  
  
  # Action group for alerts
  action_group_id = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-monitoring/providers/Microsoft.Insights/actionGroups/ag-dbk-webapp-alerts"
  
  
  # Resource tags
  tags = {
    environment = "dbk-dev-westeurope"
    project     = "digital-transformation"
  }
}

```