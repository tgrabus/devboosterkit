# Azure Web App Module

This module creates an Azure Web App (App Service) with comprehensive configuration options for hosting web applications, 
APIs, and containerized applications. The module provides standardized deployment patterns with built-in security, 
monitoring, and identity management.

The module leverages Azure Verified Modules (AVM) to ensure best practices and provides configurable 
application stacks, private endpoints, managed identities, and Application Insights integration.

## Features

This module provides Web App functionality with the following capabilities:

- Creates Azure Web App with standardized naming conventions
- Support for multiple application stacks (.NET, Docker, etc.)
- Managed identity integration (system and user-assigned)
- Virtual network integration and private endpoints
- IP restriction rules for enhanced security
- Application Insights integration with configurable retention
- Container registry integration with managed identity
- Always-on and auto-scaling capabilities
- Built-in monitoring and alerting
- Comprehensive tagging support

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables.

### Example - Basic Web App with Application Insights

This example shows the most basic usage of the module for creating a web app with monitoring.
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