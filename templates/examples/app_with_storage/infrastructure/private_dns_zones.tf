locals {
  pdz = {
    azure_app_service = "privatelink.azurewebsites.net"
    azure_sql_server = "privatelink.database.windows.net"
    azure_key_vault = "privatelink.vaultcore.azure.net"
    azure_storage_blob = "privatelink.blob.core.windows.net"
    azure_acr          = "privatelink.azurecr.io"
  }
}

resource "azurerm_private_dns_zone" "pdz" {
  for_each            = local.pdz
  name                = each.value
  resource_group_name = module.resource_groups["vnet"].name
  tags                = local.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "pdz_to_vnet" {
  for_each              = local.pdz
  name                  = module.vnet.vnet_name
  private_dns_zone_name = azurerm_private_dns_zone.pdz[each.key].name
  resource_group_name   = module.resource_groups["vnet"].name
  virtual_network_id    = module.vnet.vnet_id
  tags                  = local.tags
}