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
      default = {
        private_dns_zone_resource_id = module.private_dns_zones.private_dns_zone_resource_ids["azure_sql_server"]
        subnet_resource_id           = module.vnet.subnets["database"].id
      }
    }

    databases = {
      sample = {
        max_size_gb = 20
      }
    }
  }
}

module "sql" {
  source                = "../../modules/sql_server"
  instance              = var.instance
  location              = var.location
  stage                 = var.stage
  product               = var.product
  azuread_administrator = local.sql.azuread_administrator
  diagnostic_settings   = local.sql.diagnostic_settings
  allowed_ips           = var.allowed_ips
  private_endpoints     = local.sql.private_endpoints
  databases             = local.sql.databases
}
