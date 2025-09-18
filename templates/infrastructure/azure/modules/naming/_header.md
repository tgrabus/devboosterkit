# Azure Naming Module

This module is used to standardize Azure resource naming conventions and ensure compliance with organizational naming rules and Azure naming requirements.

The naming module provides consistent, predictable, and Azure-compliant naming for all resource types while allowing customization for specific organizational requirements.

## Features

This module supports standardized naming for Azure resources with the following capabilities:

- Generates consistent names following Azure naming conventions
- Supports region-based naming conventions
- Validates resource names against Azure length and character restrictions
- Provides environment-specific naming (dev, staging, prod)
- Handles resource type-specific naming requirements
- Validates against Azure reserved words and restrictions

Supported pattern is:
`resource_type_product_location_stage_instance_short_description`

## Supported Resource Types

The module supports naming for common Azure resources. 
The full list of resource types can be found [here](https://github.com/aztfmod/terraform-provider-azurecaf/blob/main/docs/index.md#supported-azure-resource-types).

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables.

### Example - Basic Resource Naming

This example shows the most basic usage of the module for generating standardized resource names.
```terraform
module "vnet_naming" {
  source              = "../naming"

  # Basic naming and location variables
  instance            = 1
  location            = "West Europe"
  stage               = "dev"
  product             = "dbk"
  short_description = "sample"

  # Resource type
  resource_type       = "azurerm_virtual_network"
}
```
