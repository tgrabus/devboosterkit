locals {
  alphabet = split("", "abcdefghijklmnopqrstuvwxyz")
  alphabet_subnet_map = { 
    for key, subnet in var.subnets : local.alphabet[subnet.idx] => key 
  }
  subnet_prefixes = { 
    for key, subnet in var.subnets : local.alphabet[subnet.idx] => subnet.cidr_range_size 
  }
  subnet_address_prefix_map = {
    for key, address_prefix in module.cidr_calculator.address_prefixes : local.alphabet_subnet_map[key] => address_prefix
  }
}

# Create Virtual Network
module "vnet" {
  source               = "Azure/avm-res-network-virtualnetwork/azurerm"
  version              = "0.10.0"
  resource_group_name  = module.resource_group.name
  location             = var.location
  name                 = module.vnet_naming.result
  address_space        = [var.address_space]
  enable_vm_protection = true
  tags                 = var.tags
}

# Calculate address prefixes for subnets
module "cidr_calculator" {
  source  = "Azure/avm-utl-network-ip-addresses/azurerm"
  version = "0.1.0"
  address_prefixes = local.subnet_prefixes
  address_space = var.address_space
  address_prefix_efficient_mode = false
}

# Create Subnets
module "subnets" {
  source           = "Azure/avm-res-network-virtualnetwork/azurerm//modules/subnet"
  version          = "0.10.0"
  for_each         = var.subnets
  name             = module.subnet_naming[each.key].result
  address_prefixes = [local.subnet_address_prefix_map[each.key]]

  delegation =  [
    for delegation in each.value.delegations : {
      name = delegation.name
      service_delegation = {
        name = delegation.service
      }
    }
  ]

  network_security_group = {
    id = azurerm_network_security_group.subnets[each.key].id
  }

  virtual_network = {
    resource_id = module.vnet.resource_id
  }
}

# Create Network Security Groups (NSGs) for subnets
resource "azurerm_network_security_group" "subnets" {
  for_each            = var.subnets
  name                = module.nsg_naming[each.key].result
  location            = var.location
  resource_group_name = module.resource_group.name
  
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