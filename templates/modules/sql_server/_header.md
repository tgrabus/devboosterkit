# Azure SQL Server Module

This module creates an Azure SQL Server with databases, elastic pools, and comprehensive security configurations. Based on Azure Verified Modules (AVM), it provides enterprise-grade database capabilities with Azure Active Directory integration, private endpoints, and audit logging.

## Usage

### Example - Basic SQL Server with Database

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