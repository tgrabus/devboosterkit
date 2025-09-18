module "secrets" {
  for_each             = var.secrets
  source               = "./secret"
  key_vault_id         = module.this.resource_id
  name                 = each.value.name
  value                = each.value.value
  content_type         = each.value.content_type
  expiration_date      = each.value.expiration_date
  ignore_value_changes = each.value.ignore_value_changes
}