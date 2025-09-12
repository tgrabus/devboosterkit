output "resource_id" {
  value = module.this.resource_id
}

output "action_groups" {
  value = {
    for key, group in azurerm_monitor_action_group.action_groups : key => {
      id = group.id
    }
  }
}