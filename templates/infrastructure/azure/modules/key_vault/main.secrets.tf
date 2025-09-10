module "secrets" {
  for_each        = var.secrets
  source          = "./secret"
  key_vault_id    = module.key_vault.resource_id
  name            = each.value.name
  value           = each.value.value
  content_type    = each.value.content_type
  expiration_date = each.value.expiration_date
}