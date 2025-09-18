output "resource_id" {
  value = azurerm_resource_group.this.id
  description = "Resource id"
}

output "name" {
  value = azurerm_resource_group.this.name
  description = "Resource group name"
}
