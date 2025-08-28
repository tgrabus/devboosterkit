locals {
  resource_id    = var.ignore_value_changes ? azurerm_key_vault_secret.ignored_value[0].id : azurerm_key_vault_secret.with_value[0].id
  versionless_id = var.ignore_value_changes ? azurerm_key_vault_secret.ignored_value[0].versionless_id : azurerm_key_vault_secret.with_value[0].versionless_id
}

output "resource_id" {
  value = local.resource_id
}

output "reference" {
  value = "@Microsoft.KeyVault(SecretUri=${local.versionless_id})"
}