locals {
  sql = {
    azuread_administrator = {
      login_username = data.azuread_group.sql_administrator_group.display_name
      object_id      = data.azuread_group.sql_administrator_group.object_id
    }

    diagnostic_settings = {
      workspace_resource_id = module.observability.resource_id
    }

    private_endpoints = {
      sql = {
        private_dns_zone_resource_id = azurerm_private_dns_zone.pdz["azure_sql_server"].id
        subnet_resource_id           = module.vnet.subnets["database"].id
        resource_group_name          = module.resource_groups["vnet"].name
      }
    }

    elastic_pool = {
      zone_redundant = false
      sku = {
        name = "StandardPool"
      }
    }

    databases = {
      sample = {
        max_size_gb                 = 20
        backup_storage_account_type = "Zone"
      }
    }
  }
}

module "sql_storage" {
  source                        = "../../../modules/sql_server"
  instance                      = var.instance
  location                      = var.location
  stage                         = var.stage
  product                       = var.product
  resource_group_name           = module.resource_groups[local.resource_groups.sql].name
  azuread_administrator         = local.sql.azuread_administrator
  diagnostic_settings           = local.sql.diagnostic_settings
  allowed_ips                   = local.allowed_ips
  private_endpoints             = local.sql.private_endpoints
  elastic_pool                  = local.sql.elastic_pool
  databases                     = local.sql.databases
  action_group_id               = module.observability.action_groups["default"].id
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = local.tags
}
