# Create Network Security Groups (NSGs) for subnets
resource "azurerm_network_security_group" "subnets" {
  for_each            = var.subnets
  name                = module.nsg_naming[each.key].result
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = lookup(each.value, "nsg_rules", [])
    content {
      name                       = security_rule.value.name
      priority                   = 100 + index(each.value.nsg_rules, security_rule.value)
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = security_rule.value.protocol
      source_address_prefix      = security_rule.value.source
      source_port_range          = "*"
      destination_address_prefix = "*"
      destination_port_ranges    = security_rule.value.destination_port_ranges
    }
  }

  tags = var.tags
}