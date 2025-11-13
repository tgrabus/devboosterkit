locals {
  pdz = {
    azure_sql_server   = "privatelink.database.windows.net"
    azure_key_vault    = "privatelink.vaultcore.azure.net"
    azure_storage_blob = "privatelink.blob.core.windows.net"
    azure_app_service  = "privatelink.azurewebsites.net"
    azure_acr          = "privatelink.azurecr.io"
  }
}

resource "azurerm_private_dns_zone" "pdz" {
  for_each            = local.pdz
  name                = each.value
  resource_group_name = module.resource_groups["pdz"].name
  tags                = local.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "pdz_to_cicd_vnet" {
  for_each              = local.pdz
  name                  = module.cicd_vnet.vnet_name
  private_dns_zone_name = azurerm_private_dns_zone.pdz[each.key].name
  resource_group_name   = module.resource_groups["pdz"].name
  virtual_network_id    = module.cicd_vnet.vnet_id
  tags                  = local.tags
}