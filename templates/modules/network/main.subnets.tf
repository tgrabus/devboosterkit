# Create Subnets
module "subnets" {
  source         = "Azure/avm-res-network-virtualnetwork/azurerm//modules/subnet"
  version        = "0.10.0"
  for_each       = var.subnets
  name           = module.subnet_naming[each.key].result
  address_prefix = each.value.address_prefix

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

  nat_gateway = each.value.nat_gateway_enabled ? {
    id = azurerm_nat_gateway.subnets[each.key].id
  } : null

  virtual_network = {
    resource_id = module.vnet.resource_id
  }
}

resource "azurerm_nat_gateway" "subnets" {
  for_each            = local.subnets_with_nat_gateway_enabled
  name                = "nat-${module.subnet_naming[each.key].result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "Standard"
  tags                = var.tags
}

resource "azurerm_public_ip" "subnets" {
  for_each            = local.subnets_with_nat_gateway_enabled
  name                = module.pip_naming[each.key].result
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}

resource "azurerm_nat_gateway_public_ip_association" "alz" {
  for_each             = local.subnets_with_nat_gateway_enabled
  nat_gateway_id       = azurerm_nat_gateway.subnets[each.key].id
  public_ip_address_id = azurerm_public_ip.subnets[each.key].id
}