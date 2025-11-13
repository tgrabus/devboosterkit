# Azure Resource Group Module

This module creates Azure Resource Groups with standardized naming conventions and consistent tagging. Resource Groups serve as logical containers for organizing and managing related Azure resources, providing a foundation for resource lifecycle management, access control, and cost management.

The module ensures consistent resource organization across different environments and stages while supporting flexible tagging strategies for governance and compliance requirements.

## Features

This module provides resource group functionality with the following capabilities:

- Creates Azure Resource Groups with standardized naming conventions
- Integrates with naming module for predictable resource names
- Supports multiple deployment stages (dev, qa, staging, prod)
- Foundation for implementing access control and policies
- Enables cost tracking and budgeting at the resource group level

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables.

### Example - Basic Resource Group
This example shows how to create a resource group with comprehensive tagging.
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
