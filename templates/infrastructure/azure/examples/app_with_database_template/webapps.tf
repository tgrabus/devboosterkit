locals {
  backend_app = {
    app_stack = {
      dotnet_version = "8.0"
    }

    private_endpoints = {
      backend = {
        private_dns_zone_resource_id = module.private_dns_zones.private_dns_zone_resource_ids["azure_app_service"]
        subnet_resource_id           = module.vnet.subnets[local.subnets.webapps.name].id
      }
    }

    app_settings = {
      ConnectionString__DbConnection = module.sql.databases["backend"].conn_string
    }
  }
}

module "rg_app" {
  source = "../../modules/resource_group"
  instance          = var.instance
  location          = var.location
  stage             = var.stage
  product           = var.product
  short_description = "apps"
}

module "service_plan" {
  source            = "../../modules/service_plan"
  instance          = var.instance
  location          = var.location
  stage             = var.stage
  product           = var.product
  short_description = "backend"
  resource_group_name = module.rg_app.name
  os_type           = "Linux"
  sku_name          = "F1"
  action_group_id   = module.observability.action_groups[local.action_groups.default.name]
  tags = local.tags
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
  action_group_id   = module.observability.action_groups[local.action_groups.default.name]
  tags = local.tags
}

module "file_storage" {
  source = "../../modules/storage_account"
  instance          = var.instance
  location          = var.location
  stage             = var.stage
  product           = var.product
  short_description = "backend"
  resource_group_name = module.rg_app.name
}

module "backend_app" {
  source                    = "../../modules/web_app"
  instance                  = var.instance
  location                  = var.location
  stage                     = var.stage
  product                   = var.product
  short_description         = "backend"
  app_stack                 = local.backend_app.app_stack
  os_type                   = module.service_plan.os_type
  resource_group_name       = module.service_plan.resource_group_name
  service_plan_resource_id  = module.service_plan.resource_id
  virtual_network_subnet_id = module.vnet.subnets[local.subnets.webapps.name]
  private_endpoints         = local.backend_app.private_endpoints
  app_settings              = local.backend_app.app_settings
  action_group_id   = module.observability.action_groups[local.action_groups.default.name]
  log_analytics = {
    la_workspace_id = module.observability.resource_id
  }
  public_network_access_enabled = true
  allowed_ips = var.allowed_ips
  tags = local.tags
}