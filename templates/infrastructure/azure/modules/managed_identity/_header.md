# Azure Managed Identity Module

This module creates user-assigned managed identities in Azure with optional role assignments. 
Managed identities provide an identity for applications to use when connecting to resources that support Azure Active Directory authentication.

The module simplifies the creation and configuration of user-assigned managed identities while providing flexible role assignment capabilities for secure access to Azure resources.

## Features

This module provides managed identity functionality with the following capabilities:

- Creates user-assigned managed identities with consistent naming
- Integrates with Azure naming conventions for consistent resource naming
- Provides essential identity outputs (resource ID, principal ID, client ID)
- Supports flexible role-based access control (RBAC) configuration

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables.

### Example - Basic Managed Identity

This example shows the most basic usage of the module for creating a user-assigned managed identity.
```terraform
module "managed_identity" {
  source = "./modules/managed_identity"

  # Basic naming and location variables
  stage               = "dev"
  location            = "West Europe"
  instance            = 1
  product             = "dbk"
  short_description   = "api-backend"

  # Resource group
  resource_group_name = "rg-dbk-dev-westeurope-1"

  # Optional role assignments
  roles = {
    storage_access = {
      role_name = "Storage Blob Data Contributor"
      scope     = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-storage-dev/providers/Microsoft.Storage/storageAccounts/stfinzeodev001"
    }
    keyvault_access = {
      role_name = "Key Vault Secrets User"
      scope     = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-keyvault-dev/providers/Microsoft.KeyVault/vaults/kv-finzeo-dev-001"
    }
  }

  # Tags
  tags = {
    environment = "dbk-dev-westeurope"
    project     = "digital-transformation"
  }
}

```