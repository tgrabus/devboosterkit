output "resource_id" {
  value = module.this.resource_id
}

output "name" {
  value = module.this.name
}

output "identity" {
  value = {
    resource_id  = module.managed_identity.resource_id
    client_id    = module.managed_identity.client_id
    principal_id = module.managed_identity.principal_id
  }
}