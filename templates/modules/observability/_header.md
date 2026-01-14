# Azure Observability Module

This module creates an Azure Log Analytics workspace for monitoring, logging, and observability. Based on Azure Verified Modules (AVM), it provides the foundation for Azure Monitor and Application Insights with configurable retention policies and action groups.

## Usage

### Example - Log Analytics Workspace

```terraform
module "observability" {
  source = "./modules/observability"

  # Basic naming and location variables
  instance          = 1
  location          = "West Europe"
  stage             = "dev"
  product           = "dbk"
  short_description = "operational"
  
  # Resource group
  resource_group_name = "rg-dbk-dev-westeurope-01"

  # Log Analytics workspace configuration
  retention_in_days  = 90

  # Action groups configuration with email receivers
  action_groups = {
    "critical-alerts" = {
      email_receivers = {
        "devops-team"     = "devops@company.com"
        "platform-admin"  = "admin@company.com"
      }
    }
    "warning-alerts" = {
      email_receivers = {
        "dev-team"        = "developers@company.com"
        "support-team"    = "support@company.com"
      }
    }
  }

  # Tags
  tags = {
    environment = "dbk-dev-westeurope"
    project     = "digital-transformation"
  }
}
```