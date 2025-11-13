locals {
  audience = "api://AzureADTokenExchange"
}

module "msi" {
  for_each            = var.user_assigned_managed_identities
  source              = "../../../modules/managed_identity"
  instance            = var.instance
  location            = var.location
  stage               = var.stage
  product             = var.product
  short_description   = each.key
  resource_group_name = module.resource_groups[local.resource_groups.identity].name
  role_assignments    = each.value.role_assignments
  tags                = local.tags
}

resource "azurerm_federated_identity_credential" "msi" {
  for_each            = var.federated_credentials
  name                = "fedcred-${module.msi[each.key].name}"
  resource_group_name = module.resource_groups[local.resource_groups.identity].name
  audience            = [local.audience]
  issuer              = each.value.federated_credential_issuer
  parent_id           = module.msi[each.key].resource_id
  subject             = each.value.federated_credential_subject
}