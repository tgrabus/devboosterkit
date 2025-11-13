output "os_type" {
  value       = var.os_type
  description = "The operating system type of the service plan"
}

output "resource_id" {
  value       = module.this.resource_id
  description = "Resource id"
}