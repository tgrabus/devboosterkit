output "resource_id" {
  value = module.this.resource_id
}

output "name" {
  value = module.this.name
}

output "storage_containers" {
  description = "List of created storage container names"
  value = { for key, container in module.this.containers : key => {
    id   = container.id
    name = var.containers[key].name
  } }
}

output "queues" {
  value = { for key, queue in module.this.queues : key => {
    id   = queue.id
    name = key
  } }
}

output "primary_connection_string" {
  value = module.this.resource.primary_connection_string
}

output "primary_key" {
  value = module.this.resource.primary_access_key
}

output "storage_account_blob_fqdn" {
  value = split("/", module.this.resource.primary_blob_endpoint)[2]
}

output "primary_blob_endpoint" {
  value = module.this.resource.primary_blob_endpoint
}

output "primary_queue_endpoint" {
  value = module.this.resource.primary_queue_endpoint
}

output "primary_table_endpoint" {
  value = module.this.resource.primary_table_endpoint
}

output "primary_file_endpoint" {
  value = module.this.resource.primary_file_endpoint
}

output "primary_dfs_endpoint" {
  value = module.this.resource.primary_dfs_endpoint
}

output "sftp_admins" {
  value = { for key, user in azurerm_storage_account_local_user.admins : key => {
    username          = user.name
    password          = user.password
    connection_string = "${module.this.name}.{0}.${user.name}"
  } }
}