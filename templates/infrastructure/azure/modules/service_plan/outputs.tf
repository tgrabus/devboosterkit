output "os_type" {
  value = var.os_type
}

output "resource_id" {
  value = module.this.resource_id
}

output "resource_group_name" {
  value = module.resource_group.name
}