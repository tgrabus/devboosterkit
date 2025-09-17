locals {
  network_rules = {
    default_action = var.enable_firewall ? "Deny" : null
    bypass         = var.enable_firewall ? var.network_bypass : []
    ip_rules       = var.enable_firewall ? [for key, ip_range in var.allowed_ip_ranges : (strcontains(ip_range, "/32") ? cidrhost(ip_range, 0) : ip_range)] : []
  }

  private_endpoints = { for key, endpoint in var.private_endpoints : key => {
    name                            = module.naming_pe[key].result
    private_service_connection_name = module.naming_psc[key].result
    network_interface_name          = module.naming_nic[key].result
    private_dns_zone_resource_ids   = [endpoint.private_dns_zone_resource_id]
    subnet_resource_id              = endpoint.subnet_resource_id
    subresource_name                = endpoint.subresource_name
    resource_group_name             = endpoint.resource_group_name
    tags                            = var.tags
  } }
}

module "this" {
  source                          = "Azure/avm-res-storage-storageaccount/azurerm"
  version                         = "0.6.4"
  location                        = var.location
  resource_group_name             = var.resource_group_name
  name                            = module.naming.result
  account_replication_type        = var.replication_type
  account_tier                    = var.storage_tier
  account_kind                    = "StorageV2"
  access_tier                     = var.storage_access_tier
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled       = var.shared_access_key_enabled
  public_network_access_enabled   = var.public_network_access_enabled
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  sftp_enabled                    = var.sftp_enabled
  is_hns_enabled                  = var.sftp_enabled
  default_to_oauth_authentication = var.default_to_oauth_authentication
  allowed_copy_scope              = var.allowed_copy_scope
  network_rules                   = local.network_rules
  containers                      = var.containers
  queues                          = var.queues
  private_endpoints               = local.private_endpoints
  role_assignments                = var.roles
  tags                            = var.tags
}