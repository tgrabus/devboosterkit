resource "azurerm_storage_account_local_user" "admins" {
  for_each             = var.sftp_enabled ? var.sftp_admins : {}
  name                 = each.key
  storage_account_id   = module.this.resource_id
  ssh_password_enabled = true

  dynamic "permission_scope" {
    for_each = { for container in each.value.containers : container => {
      name = var.containers[container].name
    } }
    content {
      service       = "blob"
      resource_name = permission_scope.value.name

      permissions {
        create = true
        delete = true
        list   = true
        read   = true
        write  = true
      }
    }
  }

  depends_on = [module.this]
}