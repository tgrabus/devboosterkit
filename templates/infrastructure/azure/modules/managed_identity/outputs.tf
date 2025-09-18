output "resource_id" {
  value = azurerm_user_assigned_identity.this.id
  description = "Resource id"
}

output "principal_id" {
  value = azurerm_user_assigned_identity.this.principal_id
  description = "Principal id"
}

output "client_id" {
  value = azurerm_user_assigned_identity.this.client_id
  description = "Client (Application) Id"
}