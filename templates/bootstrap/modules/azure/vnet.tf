locals {
  subnets = {
    container_instances = {
      address_prefix = var.virtual_network_subnet_address_prefix_container_instances
      delegations = [
        {
          name    = "aci-delegation"
          service = "Microsoft.ContainerInstance/containerGroups"
        }
      ]
      nat_gateway_enabled = true
    }
    private_endpoints = {
      address_prefix = var.virtual_network_subnet_address_prefix_private_endpoints
    }
  }
}

module "cicd_vnet" {
  source              = "../../../modules/network"
  instance            = var.instance
  location            = var.location
  stage               = var.stage
  product             = var.product
  short_description   = "cicd-agents"
  resource_group_name = module.resource_groups["vnet"].name
  address_space       = var.virtual_network_address_space
  subnets             = local.subnets
  tags                = local.tags
}