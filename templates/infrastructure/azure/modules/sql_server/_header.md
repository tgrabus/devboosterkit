# Azure SQL Server Module

This module creates an Azure SQL Server with databases, elastic pools, and comprehensive security configurations. 
The module provides a standardized approach to deploying SQL Server instances with Azure Active Directory integration, 
firewall rules, and audit logging capabilities.

The module leverages Azure Verified Modules (AVM) to ensure best practices and provides configurable 
database configurations, backup policies, and private endpoint support for enhanced security.

## Features

This module provides SQL Server functionality with the following capabilities:

- Creates Azure SQL Server with standardized naming conventions
- Azure Active Directory administrator configuration
- Managed identity integration
- Firewall rules and network access control
- Private endpoint support for secure connectivity
- Elastic pool configuration for cost optimization
- Database creation with configurable service tiers
- Audit logging to storage account or Log Analytics
- Threat detection and vulnerability assessment
- Diagnostic settings integration
- Comprehensive tagging support

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables.

### Example - Basic SQL Server with Database

This example shows the most basic usage of the module for creating a SQL Server with a database.
```terraform
module "sql_server" {
  source = "./modules/sql_server"

  # Basic naming and location variables
  instance          = 1
  location          = "West Europe"
  stage             = "dev"
  product           = "dbk"
  short_description = "main"

  # Network access configuration
  public_network_access_enabled = false
  
  # Azure AD administrator configuration
  azuread_administrator = {
    azuread_authentication_only = true
    login_username              = "sql-admin@company.com"
    object_id                   = "12345678-1234-1234-1234-123456789012"
  }

  # Elastic pool configuration
  elastic_pool = {
    max_size_gb    = 100
    zone_redundant = true
    sku = {
      name     = "StandardPool"
      capacity = 100
      tier     = "Standard"
      family   = null
    }
    per_database_settings = {
      min_capacity = 0
      max_capacity = 100
    }
  }

  # Diagnostic settings for monitoring
  diagnostic_settings = {
    workspace_resource_id = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-monitoring/providers/Microsoft.OperationalInsights/workspaces/law-dbk-dev"
    enabled               = true
  }

  # Database configurations
  databases = {
    "app-primary" = {
      collation                   = "SQL_Latin1_General_CP1_CI_AS"
      max_size_gb                 = 50
      backup_storage_account_type = "Geo"
      
      short_term_retention_policy = {
        retention_days           = 14
        backup_interval_in_hours = 12
      }
      
      long_term_retention_policy = {
        weekly_retention  = "P1W"
        monthly_retention = "P1M"
        yearly_retention  = "P1Y"
        week_of_year      = 1
      }
    }
  }

  # Vulnerability assessment configuration
  vulnerability_assessment = {
    enabled         = true
    retention_days  = 90
    email_addresses = ["security@company.com", "dba@company.com"]
  }

  # Private endpoint configuration
  private_endpoints = {
    "sql-pe-001" = {
      private_dns_zone_resource_id = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-dns/providers/Microsoft.Network/privateDnsZones/privatelink.database.windows.net"
      subnet_resource_id           = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-dbk-dev/subnets/snet-database"
      resource_group_name          = "rg-dbk-dev-westeurope-001"
    }
  }

  # Firewall rules for specific IP addresses
  allowed_ips = {
    "office-network"     = "203.0.113.0/24"
    "backup-datacenter"  = "198.51.100.50/32"
    "admin-workstation"  = "192.0.2.100/32"
  }

  # Action group for monitoring alerts
  action_group_id = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-monitoring/providers/Microsoft.Insights/actionGroups/ag-sql-alerts"

  # Resource tags
  tags = {
    environment = "dbk-dev-westeurope"
    project     = "digital-transformation"
  }
}

```