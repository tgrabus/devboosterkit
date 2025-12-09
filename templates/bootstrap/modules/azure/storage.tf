locals {
  state_storage = {
    containers = { for key, value in var.environments : key => {
      name = value.environment_name
    } }

    private_endpoints = {
      blob = {
        private_dns_zone_resource_id = azurerm_private_dns_zone.pdz["azure_storage_blob"].id
        subnet_resource_id           = module.cicd_vnet.subnets["private_endpoints"].id
        subresource_name             = "blob"
      }
    }
  }
}

module "state_storage" {
  source                          = "../../../modules/storage_account"
  instance                        = var.instance
  location                        = var.location
  stage                           = var.stage
  product                         = var.product
  resource_group_name             = module.resource_groups["state"].name
  short_description               = "state"
  allow_nested_items_to_be_public = false
  shared_access_key_enabled       = false
  public_network_access_enabled   = length(var.allowed_ips) > 0 ? true : false
  enable_firewall                 = length(var.allowed_ips) > 0 ? true : false
  allowed_ip_ranges               = var.allowed_ips
  containers                      = local.state_storage.containers
  replication_type                = "ZRS"
  private_endpoints               = local.state_storage.private_endpoints
  tags                            = local.tags
}