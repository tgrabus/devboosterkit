output "resource_id" {
  value = module.storage_account.resource_id
}

output "name" {
  value = module.storage_account.name
}

output "storage_containers" {
  description = "List of created storage container names"
  value = { for key, container in module.storage_account.containers : key => {
    id   = container.id
    name = var.containers[key].name
  } }
}

output "queues" {
  value = { for key, queue in module.storage_account.queues : key => {
    id   = queue.id
    name = key
  } }
}

output "primary_connection_string" {
  value = module.storage_account.resource.primary_connection_string
}

output "primary_key" {
  value = module.storage_account.resource.primary_access_key
}

output "storage_account_blob_fqdn" {
  value = split("/", module.storage_account.resource.primary_blob_endpoint)[2]
}

output "primary_blob_endpoint" {
  value = module.storage_account.resource.primary_blob_endpoint
}

output "primary_queue_endpoint" {
  value = module.storage_account.resource.primary_queue_endpoint
}

output "primary_table_endpoint" {
  value = module.storage_account.resource.primary_table_endpoint
}

output "primary_file_endpoint" {
  value = module.storage_account.resource.primary_file_endpoint
}

output "primary_dfs_endpoint" {
  value = module.storage_account.resource.primary_dfs_endpoint
}

output "sftp_admins" {
  value = { for key, user in azurerm_storage_account_local_user.admins : key => {
    username          = user.name
    password          = user.password
    connection_string = "${module.storage_account.name}.{0}.${user.name}"
  } }
}