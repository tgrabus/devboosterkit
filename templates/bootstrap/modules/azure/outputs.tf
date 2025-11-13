output "user_assigned_managed_identity_client_ids" {
  value = { for key, value in var.user_assigned_managed_identities : key => module.msi[key].client_id }
}

output "state_storage" {
  value = {
    resource_group_name = module.state_storage.resource_group_name
    name                = module.state_storage.name
    container_names     = { for key, value in module.state_storage.storage_containers : key => value.name }
  }
}