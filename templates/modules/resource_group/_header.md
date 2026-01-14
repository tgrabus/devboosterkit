# Azure Resource Group Module

This module creates Azure Resource Groups with standardized naming conventions and consistent tagging. Based on Azure Verified Modules (AVM), it provides logical containers for organizing and managing related Azure resources with support for lifecycle management, access control, and cost tracking.

## Usage

### Example - Resource Group
```terraform
module "resource_group" {
  source            = "../resource_group"

  # Basic naming and location variables
  stage             = "prod"
  location          = "East US"
  instance          = 1
  product           = "dbk"
  short_description = "core"

  # Tags for resource management
  tags = {
    environment = "dbk-dev-westeurope"
    project     = "digital-transformation"
  }
}
```
