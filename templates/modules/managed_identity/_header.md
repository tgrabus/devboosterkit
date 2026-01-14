# Azure Managed Identity Module

This module creates user-assigned managed identities in Azure with optional role assignments. Based on Azure Verified Modules (AVM), it provides secure identity management for applications to access Azure resources without storing credentials.

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables.

### Example - Managed Identity

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
      scope     = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-storage-dev/providers/Microsoft.Storage/storageAccounts/stdbkdev001"
    }
    keyvault_access = {
      role_name = "Key Vault Secrets User"
      scope     = "/subscriptions/12345678-1234-1234-1234-123456789012/resourceGroups/rg-keyvault-dev/providers/Microsoft.KeyVault/vaults/kv-dbk-dev-001"
    }
  }

  # Tags
  tags = {
    environment = "dbk-dev-westeurope"
    project     = "digital-transformation"
  }
}

```