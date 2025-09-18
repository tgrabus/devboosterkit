# Azure Container Registry Module

This module creates an Azure Container Registry (ACR) with standardized naming conventions and security best practices. 
The module supports multiple SKU tiers (Basic, Standard, Premium) and provides configurable network access controls, 
private endpoints, and role-based access control (RBAC) for secure container image management.

The module leverages Azure Verified Modules (AVM) to ensure best practices and provides enterprise-grade features.

## Features

This module provides container registry functionality with the following capabilities:

- Creates Azure Container Registry with standardized naming conventions
- Support for Basic, Standard, and Premium SKU tiers
- Configurable public/private network access
- Private endpoint support for Premium SKU
- Network firewall rules with IP allowlisting
- Zone redundancy for Premium SKU
- Role-based access control (RBAC) assignments
- Integration with managed identities and service principals

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables.

### Example - Basic Container Registry

This example shows the most basic usage of the module for creating a container registry.
```terraform
module "acr" {
  source = "./modules/acr"

  # Basic naming and location variables
  instance          = 1
  location          = "West Europe"
  stage             = "dev"
  product           = "dbk"
  short_description = "main"
  
  # Resource group
  resource_group_name = "rg-dbk-dev-westeurope-01"

  # Container Registry configuration
  sku                           = "Premium"
  public_network_access_enabled = false

  # Network firewall rules
  allowed_ip_ranges = {
    "office"     = "203.0.113.0/24"
    "build-agent" = "198.51.100.1/32"
  }

  # Role assignments
  roles = {
    "devops-team" = {
      role_definition_id_or_name = "AcrPush"
      principal_id               = "12345678-1234-1234-1234-123456789012"
    }
    "app-identity" = {
      role_definition_id_or_name = "AcrPull"
      principal_id               = "87654321-4321-4321-4321-210987654321"
    }
  }

  # Private endpoints for Premium SKU
  private_endpoints = {
    "main" = {
      private_dns_zone_resource_id = "/subscriptions/sub-id/resourceGroups/rg-dns/providers/Microsoft.Network/privateDnsZones/privatelink.azurecr.io"
      subnet_resource_id           = "/subscriptions/sub-id/resourceGroups/rg-network/providers/Microsoft.Network/virtualNetworks/vnet-main/subnets/snet-pe"
      resource_group_name          = "rg-dbk-dev-westeurope-01"
    }
  }

  # Tags
  tags = {
    environment = "dbk-dev-westeurope"
    project     = "digital-transformation"
  }
}
```