output "resource_id" {
  value = module.this.resource_id
  description = "Resource id"
}

output "secrets" {
  value = module.secrets
  description = "List of secrets"
}