locals {
  network_acl = {
    ip_rules = var.public_network_access_enabled ? values(var.allowed_ip_ranges) : []
  }

  private_endpoints = { for key, endpoint in var.private_endpoints : key => {
    name                            = module.naming_pe[key].result
    private_service_connection_name = module.naming_psc[key].result
    network_interface_name          = module.naming_nic[key].result
    private_dns_zone_resource_ids   = [endpoint.private_dns_zone_resource_id]
    subnet_resource_id              = endpoint.subnet_resource_id
  } }
}

module "this" {
  source                         = "Azure/avm-res-keyvault-vault/azurerm"
  version                        = "0.10.1"
  name                           = module.naming_kv.result
  location                       = var.location
  resource_group_name            = var.resource_group_name
  tenant_id                      = var.tenant_id
  legacy_access_policies_enabled = false
  public_network_access_enabled  = var.public_network_access_enabled
  purge_protection_enabled       = var.purge_protection_enabled
  sku_name                       = var.sku_name
  soft_delete_retention_days     = var.soft_delete_retention_days
  private_endpoints              = local.private_endpoints
  network_acls                   = local.network_acl
  role_assignments               = var.roles
  tags                           = var.tags
}