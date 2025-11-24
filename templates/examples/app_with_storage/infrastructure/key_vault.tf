locals {
  secret_storage = {
    private_endpoints = {
      secret_storage = {
        private_dns_zone_resource_id = azurerm_private_dns_zone.pdz["azure_key_vault"].id
        subnet_resource_id           = module.vnet.subnets["pe"].id
        resource_group_name          = module.resource_groups["vnet"].name
      }
    }

    secrets = {
      third_party_api_key = {
        name                 = "third-party-api-key"
        value                = "initial"
        ignore_value_changes = true
      }
    }
  }
}

module "secret_storage" {
  source                        = "../../../modules/key_vault"
  instance                      = var.instance
  location                      = var.location
  stage                         = var.stage
  product                       = var.product
  short_description             = "secret"
  resource_group_name           = module.resource_groups[local.resource_groups.app].name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  private_endpoints             = local.secret_storage.private_endpoints
  secrets                       = local.secret_storage.secrets
  public_network_access_enabled = var.public_network_access_enabled
  allowed_ip_ranges             = var.allowed_ips
  tags                          = local.tags
}
