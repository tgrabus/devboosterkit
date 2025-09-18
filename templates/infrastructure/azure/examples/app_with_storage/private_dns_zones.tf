module "private_dns_zones" {
  source                          = "Azure/avm-ptn-network-private-link-private-dns-zones/azurerm"
  version                         = "0.16.0"
  location                        = var.location
  resource_group_name             = module.resource_groups[local.resource_groups.private_dns_zones].name
  resource_group_creation_enabled = false

  private_link_private_dns_zones = {
    azure_app_service = {
      zone_name = "privatelink.azurewebsites.net"
    }
    azure_sql_server = {
      zone_name = "privatelink.database.windows.net"
    }
    azure_key_vault = {
      zone_name = "privatelink.vaultcore.azure.net"
    }
    azure_storage_blob : {
      "zone_name" : "privatelink.blob.core.windows.net"
    }
  }

  virtual_network_resource_ids_to_link_to = {
    (module.vnet.vnet_name) = {
      vnet_resource_id = module.vnet.vnet_id
    }
  }
  tags = local.tags
}