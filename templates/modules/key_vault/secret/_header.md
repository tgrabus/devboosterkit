# Azure Key Vault Secret Module

This module creates and manages individual secrets within an Azure Key Vault. Based on Azure Verified Modules (AVM), it provides standardized secret lifecycle management with support for both Terraform-managed and externally-managed secret values.

## Usage

To use this module in your Terraform configuration, you'll need to provide values for the required variables.

### Example - Ignore value changes

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
```

### Example - Track value changes
```terraform
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