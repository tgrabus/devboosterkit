resource "azurerm_key_vault_secret" "with_value" {
  count           = var.ignore_value_changes ? 0 : 1
  name            = var.name
  value           = var.value
  key_vault_id    = var.key_vault_id
  content_type    = var.content_type
  expiration_date = var.expiration_date
}

resource "azurerm_key_vault_secret" "ignored_value" {
  count           = var.ignore_value_changes ? 1 : 0
  name            = var.name
  value           = var.value
  key_vault_id    = var.key_vault_id
  content_type    = var.content_type
  expiration_date = var.expiration_date

  lifecycle {
    ignore_changes = [value]
  }
}