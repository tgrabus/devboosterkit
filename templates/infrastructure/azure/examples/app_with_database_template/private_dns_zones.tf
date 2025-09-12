module "rg_private_dns_zones" {
  source            = "../../modules/resource_group"
  instance          = var.instance
  location          = var.location
  stage             = var.stage
  product           = var.product
  short_description = "private_dns_zones"
}

module "private_dns_zones" {
  source                          = "Azure/avm-ptn-network-private-link-private-dns-zones/azurerm"
  version                         = "0.16.0"
  location                        = var.location
  resource_group_name             = module.rg_private_dns_zones.name
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
}