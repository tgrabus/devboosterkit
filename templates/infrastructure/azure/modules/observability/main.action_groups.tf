resource "azurerm_monitor_action_group" "action_groups" {
  for_each = var.action_groups
  name                = module.naming_action_groups[each.key].result
  short_name          = each.key
  resource_group_name = module.resource_group.name
  tags                = var.tags

  dynamic "email_receiver" {
    for_each = each.value.email_receivers

    content {
      name          = email_receiver.key
      email_address = email_receiver.value
    }
  }
}