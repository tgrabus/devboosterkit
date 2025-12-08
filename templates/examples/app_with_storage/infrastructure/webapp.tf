locals {
  sample_app = {
    app_stack = {
      dotnet_version = "8.0"
    }

    private_endpoints = {
      sample_app = {
        private_dns_zone_resource_id = azurerm_private_dns_zone.pdz["azure_app_service"].id
        subnet_resource_id           = module.vnet.subnets["pe"].id
        resource_group_name          = module.resource_groups["vnet"].name
      }
    }

    application_insights = {
      la_workspace_id = module.observability.resource_id
    }

    app_settings = {
      SqlDatabase__ConnectionString = module.sql_storage.databases["sample"].conn_string
      FileStorage__ConnectionString = module.file_storage.primary_blob_endpoint
      ThirdPartyApiKey              = module.secret_storage.secrets["third_party_api_key"].reference
    }

    roles = {
      file_storage = {
        role_name = "Storage Blob Data Contributor"
        scope     = module.file_storage.resource_id
      }
      secret_storage = {
        role_name = "Key Vault Secrets User"
        scope     = module.secret_storage.resource_id
      }
    }
  }
}

module "service_plan" {
  source              = "../../../modules/service_plan"
  instance            = var.instance
  location            = var.location
  stage               = var.stage
  product             = var.product
  short_description   = "sample"
  resource_group_name = module.resource_groups[local.resource_groups.app].name
  os_type             = "Linux"
  sku_name            = "P0v3"
  action_group_id     = module.observability.action_groups["default"].id
  tags                = local.tags
}

module "sample_app" {
  source                        = "../../../modules/web_app"
  instance                      = var.instance
  location                      = var.location
  stage                         = var.stage
  product                       = var.product
  short_description             = "sample"
  app_stack                     = local.sample_app.app_stack
  os_type                       = module.service_plan.os_type
  resource_group_name           = module.resource_groups[local.resource_groups.app].name
  service_plan_resource_id      = module.service_plan.resource_id
  virtual_network_subnet_id     = module.vnet.subnets["webapps"].id
  vnet_route_all_enabled        = true
  private_endpoints             = local.sample_app.private_endpoints
  app_settings                  = local.sample_app.app_settings
  action_group_id               = module.observability.action_groups["default"].id
  application_insights          = local.sample_app.application_insights
  public_network_access_enabled = var.public_network_access_enabled
  allowed_ips                   = var.allowed_ips
  role_assignments              = local.sample_app.roles
  tags                          = local.tags
}