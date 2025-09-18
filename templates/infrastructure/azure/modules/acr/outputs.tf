output "resource_id" {
  value       = module.this.resource_id
  description = "Resource id"
}

output "registry_url" {
  value       = module.this.resource.login_server
  description = "Login server URL of the container registry"
}