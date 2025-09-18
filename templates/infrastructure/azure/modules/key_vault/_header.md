# Azure Key Vault Module

This module creates an Azure Key Vault with comprehensive security features, including private endpoints, network access controls, and role-based access management. 
Key Vault provides secure storage for secrets, keys, and certificates used by applications and services.

The module leverages Azure Verified Modules (AVM) to ensure best practices and provides flexible configuration options for different security and compliance requirements.

## Features

This module provides Key Vault functionality with the following capabilities:

- Creates Azure Key Vault with standardized naming conventions
- Supports private endpoints for secure network connectivity
- Configurable public network access with IP-based firewall rules
- Role-based access control (RBAC) instead of legacy access policies
- Soft delete and purge protection capabilities
- Support for both standard and premium SKUs
- Secret management with lifecycle configuration

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables.

### Example - Basic Key Vault

This example shows the most basic usage of the module for creating a Key Vault.
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

  # Role-based access control
  roles = {
    app_secrets_user = {
      role_definition_id_or_name = "Key Vault Secrets User"
      principal_id               = "87654321-4321-4321-4321-210987654321"
    }
    admin_secrets_officer = {
      role_definition_id_or_name = "Key Vault Secrets Officer"
      principal_id               = "11111111-2222-3333-4444-555555555555"
    }
    backup_operator = {
      role_definition_id_or_name = "Key Vault Reader"
      principal_id               = "66666666-7777-8888-9999-000000000000"
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

  # Diagnostic settings
  diagnostic_settings = {
    key_vault_logs = {
      workspace_resource_id = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-myapp-dev-westeurope-1-observability/providers/Microsoft.OperationalInsights/workspaces/law-myapp-dev-westeurope-1"
      log_categories = [
        "AuditEvent",
        "AzurePolicyEvaluationDetails"
      ]
      metric_categories = [
        "AllMetrics"
      ]
    }
  }

  # Resource tags
  tags = {
    environment = "dbk-dev-westeurope"
    project     = "digital-transformation"
  }
}

```