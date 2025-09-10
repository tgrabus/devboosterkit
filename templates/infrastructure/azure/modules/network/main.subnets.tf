# Calculate address prefixes for subnets
module "cidr_calculator" {
  source                        = "Azure/avm-utl-network-ip-addresses/azurerm"
  version                       = "0.1.0"
  address_prefixes              = local.subnet_prefixes
  address_space                 = var.address_space
  address_prefix_efficient_mode = false
}

# Create Subnets
module "subnets" {
  source           = "Azure/avm-res-network-virtualnetwork/azurerm//modules/subnet"
  version          = "0.10.0"
  for_each         = var.subnets
  name             = module.subnet_naming[each.key].result
  address_prefixes = [local.subnet_address_prefix_map[each.key]]

  delegation = [
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