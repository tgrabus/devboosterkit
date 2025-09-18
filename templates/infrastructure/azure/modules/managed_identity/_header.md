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
  source              = "../managed_identity"
  instance            = 1
  location            = "West Europe"
  stage               = "dev"
  product             = "dbk"
  short_description   = "sample"
  resource_group_name = "sample-rg"
  roles = {
    backend_storage = {
      role_name = "Storage Blob Data Contributor"
      scope     = "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/myResourceGroup/providers/Microsoft.Storage/storageAccounts/mystorageaccount"
    }
  }
}
```