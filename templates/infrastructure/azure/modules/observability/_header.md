# Azure Observability Module

This module creates an Azure Log Analytics workspace to provide comprehensive monitoring, logging, and observability capabilities for your Azure infrastructure and applications. 
The module serves as the foundation for Azure Monitor, Application Insights, and other observability services.

The module leverages Azure Verified Modules (AVM) to ensure best practices and provides configurable retention policies and action groups for alerting and notification scenarios.

## Features

This module provides observability functionality with the following capabilities:

- Creates Log Analytics workspace with standardized naming conventions
- Configurable data retention policies
- Internet ingestion and query capabilities for flexible access
- Support for action groups with email notifications

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables.

### Example - Basic Log Analytics Workspace

This example shows the most basic usage of the module for creating a Log Analytics workspace.
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