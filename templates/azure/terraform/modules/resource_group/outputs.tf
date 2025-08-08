output "resource_group_names" {
  value = { for key, rg in azurerm_resource_group.this : key => rg.name }
}

output "resource_group_ids" {
  value = { for key, rg in azurerm_resource_group.this : key => rg.id }
}
