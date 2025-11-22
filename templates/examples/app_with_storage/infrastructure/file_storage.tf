
locals {
  file_storage = {
    private_endpoints = {
      file_storage = {
        private_dns_zone_resource_id = azurerm_private_dns_zone.pdz["azure_storage_blob"].id
        subnet_resource_id           = module.vnet.subnets["pe"].id
        subresource_name             = "blob"
        resource_group_name          = module.resource_groups["vnet"].name
      }
    }
  }
}

module "file_storage" {
  source                        = "../../../modules/storage_account"
  instance                      = var.instance
  location                      = var.location
  stage                         = var.stage
  product                       = var.product
  short_description             = "file"
  resource_group_name           = module.resource_groups[local.resource_groups.app].name
  private_endpoints             = local.file_storage.private_endpoints
  allowed_ip_ranges             = var.allowed_ips
  public_network_access_enabled = var.public_network_access_enabled
  enable_firewall               = var.public_network_access_enabled
  tags                          = local.tags
}
