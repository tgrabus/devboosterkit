output "resource_id" {
  value       = module.this.resource_id
  description = "Resource id"
}

output "server" {
  value       = module.this.resource.login_server
  description = "Login server of the container registry"
}