# Azure Key Vault Secret Module

This module creates and manages individual secrets within an Azure Key Vault. The module provides a standardized approach 
to secret lifecycle management with configurable value change handling and expiration policies.

The module supports both scenarios where Terraform manages the secret value completely and scenarios where the secret 
value is managed externally (e.g., rotated by applications or external systems) while Terraform manages the secret metadata.

## Features

This module provides Key Vault secret functionality with the following capabilities:

- Value change handling with ignore_changes lifecycle option
- Support for external secret value management
- Versionless secret URI generation for stable references

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables.

### Example - Basic Secret Management

This example shows the most basic usage of the module for creating secrets in a Key Vault.
```terraform
module "api_secret" {
  source = "./modules/key_vault/secret"

  # Secret configuration
  name         = "third-party-api-key"
  value        = "sk-1234567890abcdef1234567890abcdef"
  key_vault_id = "/subscriptions/sub-id/resourceGroups/rg-security/providers/Microsoft.KeyVault/vaults/kv-example"

  # Secret metadata
  content_type         = "application/x-api-key"
  ignore_value_changes = true
  expiration_date      = "2025-12-31T23:59:59Z"
}

module "database_connection" {
  source = "./modules/key_vault/secret"

  # Secret configuration
  name         = "sql-connection-string"
  value        = "Server=tcp:sql-server.database.windows.net,1433;Database=mydb;User ID=admin;Password=SecurePass123!;"
  key_vault_id = "/subscriptions/sub-id/resourceGroups/rg-security/providers/Microsoft.KeyVault/vaults/kv-example"

  # Secret metadata
  content_type         = "application/x-connection-string"
  ignore_value_changes = false
  expiration_date      = "2025-06-30T23:59:59Z"
}

```