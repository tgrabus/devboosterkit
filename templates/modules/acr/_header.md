# Azure Container Registry Module

This module creates an Azure Container Registry (ACR) with standardized naming conventions and security best practices. Based on Azure Verified Modules (AVM), it provides enterprise-grade container registry capabilities with support for multiple SKU tiers and network isolation.

## Usage

### Example - Container Registry
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