module "databases" {
  for_each                            = var.databases
  source                              = "Azure/avm-res-sql-server/azurerm//modules/database"
  version                             = "0.1.5"
  sql_server                          = local.sql_server_reference
  name                                = module.naming_db[each.key].result
  create_mode                         = "Default"
  collation                           = each.value.collation
  elastic_pool_id                     = module.elastic_pool.resource_id
  license_type                        = "LicenseIncluded"
  max_size_gb                         = each.value.max_size_gb
  sku_name                            = "ElasticPool"
  transparent_data_encryption_enabled = true
  storage_account_type                = each.value.backup_storage_account_type
  short_term_retention_policy         = each.value.short_term_retention_policy
  long_term_retention_policy          = each.value.long_term_retention_policy
  zone_redundant                      = var.elastic_pool.zone_redundant
}