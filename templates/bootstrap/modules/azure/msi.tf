locals {
  audience = "api://AzureADTokenExchange"
  
  msi = {
    additional_role_assignments = {
      state_storage = {
        scope     = module.state_storage.resource_id
        role_name = "Reader"
      }
    }
    
    
  }
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
  role_assignments    = merge(
    each.value.role_assignments,
    {
      state_storage = {
        scope     = module.state_storage.resource_id
        role_name = "Reader"
      },
      state_storage_container = {
        scope     = module.state_storage.storage_containers[each.key].id
        role_name = "Storage Blob Data Owner"
      }
    }
  )
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