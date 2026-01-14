# Azure Key Vault Module

This module creates an Azure Key Vault for secure storage of secrets, keys, and certificates. Based on Azure Verified Modules (AVM), it provides enterprise-grade security with private endpoints, and network access controls.

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables.

### Example - Key Vault

```terraform
module "secret_storage" {
  source = "../../modules/key_vault"

  # Basic naming and location variables
  instance          = 1
  location          = "West Europe"
  stage             = "dev"
  product           = "dbk"
  short_description = "secrets"

  # Resource group
  resource_group_name = "rg-dbk-dev-westeurope-1"

  # Azure AD configuration
  tenant_id = "12345678-1234-1234-1234-123456789012"

  # Network access configuration
  public_network_access_enabled = true
  allowed_ip_ranges = {
    "office_network" = "203.0.113.0/24"
    "developer_home" = "198.51.100.50/32"
    "ci_cd_pipeline" = "192.0.2.100/32"
  }

  # Private endpoint configuration
  private_endpoints = {
    key_vault_pe = {
      private_dns_zone_resource_id = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-myapp-dev-westeurope-1-dns/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net"
      subnet_resource_id           = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-myapp-dev-westeurope-1-vnet/providers/Microsoft.Network/virtualNetworks/vnet-myapp-dev-westeurope-1/subnets/snet-private-endpoints"
      resource_group_name          = "rg-myapp-dev-westeurope-1-vnet"
    }
  }

  # Secrets configuration
  secrets = {
    api_key = {
      name                 = "third-party-api-key"
      value                = "sk-1234567890abcdef1234567890abcdef"
      ignore_value_changes = true
      content_type         = "application/x-api-key"
    }
    jwt_secret = {
      name                 = "jwt-signing-secret"
      value                = "my-super-secret-jwt-signing-key-that-should-be-random"
      ignore_value_changes = false
      content_type         = "text/plain"
    }
  }

  # Key Vault configuration
  sku_name                   = "standard"
  soft_delete_retention_days = 90
  purge_protection_enabled   = true

  # Tags
  tags = {
    environment = "dbk-dev-westeurope"
    project     = "digital-transformation"
  }
}

```