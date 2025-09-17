locals {
  sample_app = {
    app_stack = {
      dotnet_version = "8.0"
    }

    private_endpoints = {
      sample_app = {
        private_dns_zone_resource_id = module.private_dns_zones.private_dns_zone_resource_ids["azure_app_service"]
        subnet_resource_id           = module.vnet.subnets["pe"].id
        resource_group_name          = module.resource_groups["vnet"].name
      }
    }

    application_insights = {
      la_workspace_id     = module.observability.resource_id
      resource_group_name = module.resource_groups["observability"].name
    }

    app_settings = {
      SqlDatabase__ConnectionString = module.sql_storage.databases["sample"].conn_string
      FileStorage__ConnectionString = module.file_storage.primary_blob_endpoint
      ThirdPartyApiKey              = module.secret_storage.secrets["third_party_api_key"].reference
    }
  }

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
        private_dns_zone_resource_id = module.private_dns_zones.private_dns_zone_resource_ids["azure_sql_server"]
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

  file_storage = {
    private_endpoints = {
      file_storage = {
        private_dns_zone_resource_id = module.private_dns_zones.private_dns_zone_resource_ids["azure_storage_blob"]
        subnet_resource_id           = module.vnet.subnets["pe"].id
        subresource_name             = "blob"
        resource_group_name          = module.resource_groups["vnet"].name
      }
    }

    roles = {
      sample_app_blob_contributor = {
        role_definition_id_or_name = "Storage Blob Data Contributor"
        principal_id               = module.sample_app.identity.principal_id
      }
    }
  }

  secret_storage = {
    private_endpoints = {
      secret_storage = {
        private_dns_zone_resource_id = module.private_dns_zones.private_dns_zone_resource_ids["azure_key_vault"]
        subnet_resource_id           = module.vnet.subnets["pe"].id
        resource_group_name          = module.resource_groups["vnet"].name
      }
    }

    roles = {
      sample_app_blob_contributor = {
        role_definition_id_or_name = "Key Vault Secrets User"
        principal_id               = module.sample_app.identity.principal_id
      }
    }

    secrets = {
      third_party_api_key = {
        name                 = "third-party-api-key"
        value                = "initial"
        ignore_value_changes = true
      }
    }
  }
}

module "service_plan" {
  source              = "../../modules/service_plan"
  instance            = var.instance
  location            = var.location
  stage               = var.stage
  product             = var.product
  short_description   = "sample"
  resource_group_name = module.resource_groups[local.resource_groups.apps].name
  os_type             = "Linux"
  sku_name            = "P0v3"
  action_group_id     = module.observability.action_groups["default"].id
  tags                = local.tags
}

module "sql_storage" {
  source                        = "../../modules/sql_server"
  instance                      = var.instance
  location                      = var.location
  stage                         = var.stage
  product                       = var.product
  resource_group_name           = module.resource_groups[local.resource_groups.data].name
  azuread_administrator         = local.sql.azuread_administrator
  diagnostic_settings           = local.sql.diagnostic_settings
  allowed_ips                   = var.allowed_ips
  private_endpoints             = local.sql.private_endpoints
  elastic_pool                  = local.sql.elastic_pool
  databases                     = local.sql.databases
  action_group_id               = module.observability.action_groups["default"].id
  public_network_access_enabled = var.public_network_access_enabled
  tags                          = local.tags
}

module "file_storage" {
  source                        = "../../modules/storage_account"
  instance                      = var.instance
  location                      = var.location
  stage                         = var.stage
  product                       = var.product
  short_description             = "file"
  resource_group_name           = module.resource_groups[local.resource_groups.data].name
  private_endpoints             = local.file_storage.private_endpoints
  allowed_ip_ranges             = var.allowed_ips
  public_network_access_enabled = var.public_network_access_enabled
  enable_firewall               = var.public_network_access_enabled
  roles                         = local.file_storage.roles
  tags                          = local.tags
}

module "secret_storage" {
  source                        = "../../modules/key_vault"
  instance                      = var.instance
  location                      = var.location
  stage                         = var.stage
  product                       = var.product
  short_description             = "secret"
  resource_group_name           = module.resource_groups[local.resource_groups.data].name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  private_endpoints             = local.secret_storage.private_endpoints
  secrets                       = local.secret_storage.secrets
  public_network_access_enabled = var.public_network_access_enabled
  allowed_ip_ranges             = var.allowed_ips
  tags                          = local.tags
}

module "sample_app" {
  source                        = "../../modules/web_app"
  instance                      = var.instance
  location                      = var.location
  stage                         = var.stage
  product                       = var.product
  short_description             = "sample"
  app_stack                     = local.sample_app.app_stack
  os_type                       = module.service_plan.os_type
  resource_group_name           = module.resource_groups[local.resource_groups.apps].name
  service_plan_resource_id      = module.service_plan.resource_id
  virtual_network_subnet_id     = module.vnet.subnets["webapps"].id
  vnet_route_all_enabled        = true
  private_endpoints             = local.sample_app.private_endpoints
  app_settings                  = local.sample_app.app_settings
  action_group_id               = module.observability.action_groups["default"].id
  application_insights          = local.sample_app.application_insights
  public_network_access_enabled = var.public_network_access_enabled
  allowed_ips                   = var.allowed_ips
  tags                          = local.tags
}