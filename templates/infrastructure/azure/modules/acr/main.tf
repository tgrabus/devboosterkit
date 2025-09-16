locals {
  sku = {
    Premium = "Premium"
  }

  private_endpoints = { for key, endpoint in var.private_endpoints : key => {
    name                            = module.naming_pe[key].result
    private_service_connection_name = module.naming_psc[key].result
    network_interface_name          = module.naming_nic[key].result
    private_dns_zone_resource_ids   = [endpoint.private_dns_zone_resource_id]
    subnet_resource_id              = endpoint.subnet_resource_id
  } }

  network_rule_set = {
    default_action = "Deny"
    ip_rule = [for allowed_ip in var.allowed_ip_ranges : {
      action   = "Allow"
      ip_range = allowed_ip
    }]
  }
}

module "this" {
  source                        = "Azure/avm-res-containerregistry-registry/azurerm"
  version                       = "0.4.0"
  name                          = module.naming.result
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  admin_enabled                 = false
  public_network_access_enabled = var.public_network_access_enabled
  network_rule_bypass_option    = var.public_network_access_enabled ? "AzureServices" : "None"
  role_assignments              = var.roles
  zone_redundancy_enabled       = var.sku == local.sku.Premium ? true : false
  private_endpoints             = var.sku == local.sku.Premium ? local.private_endpoints : {}
  network_rule_set              = var.sku == local.sku.Premium ? local.network_rule_set : null
  tags                          = var.tags
}