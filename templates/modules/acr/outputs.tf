output "resource_id" {
  value       = module.this.resource_id
  description = "Resource id"
}

output "server" {
  value       = module.this.resource.login_server
  description = "Login server of the container registry"
}

output "tasks_completed" {
  description = "Indicates that all ACR tasks have completed"
  value = {
    for k, v in azurerm_container_registry_task_schedule_run_now.tasks :
    k => v.id
  }
}