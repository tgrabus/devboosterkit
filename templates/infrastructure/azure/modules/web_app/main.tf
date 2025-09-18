locals {
  ip_restrictions = { for key, item in var.allowed_ips : key => {
    name       = key
    action     = "Allow"
    ip_address = item
    priority   = index(keys(var.allowed_ips), key) + 100
  } }

  application_stack = {
    default = {
      docker_image_name   = var.app_stack.docker_image_name
      docker_registry_url = var.app_stack.docker_registry_url
      dotnet_version      = var.app_stack.dotnet_version
    }
  }

  site_config = {
    ip_restriction                                = local.ip_restrictions
    scm_ip_restriction                            = local.ip_restrictions
    always_on                                     = var.always_on
    container_registry_managed_identity_client_id = module.managed_identity.client_id
    container_registry_use_managed_identity       = true
    http2_enabled                                 = var.http2_enabled
    vnet_route_all_enabled                        = var.vnet_route_all_enabled
    websockets_enabled                            = var.websockets_enabled
    application_stack                             = local.application_stack
  }

  managed_identities = {
    system_assigned            = false
    user_assigned_resource_ids = [module.managed_identity.resource_id]
  }

  enable_application_insights = var.application_insights != null ? true : false

  app_insights = (var.application_insights != null ? {
    name                  = module.naming_app_insights.result
    application_type      = "web"
    resource_group_name   = var.application_insights.resource_group_name
    workspace_resource_id = var.application_insights.la_workspace_id
    retention_in_days     = var.application_insights.retention_in_days
    #tags                       = var.tags
    internet_ingestion_enabled = true
    internet_query_enabled     = true
  } : {})

  private_endpoints = { for key, endpoint in var.private_endpoints : key => {
    name                            = module.naming_pe[key].result
    private_service_connection_name = module.naming_psc[key].result
    network_interface_name          = module.naming_nic[key].result
    private_dns_zone_resource_ids   = [endpoint.private_dns_zone_resource_id]
    subnet_resource_id              = endpoint.subnet_resource_id
    resource_group_name             = endpoint.resource_group_name
    tags                            = var.tags
  } }

}

# Create App
module "this" {
  source                          = "Azure/avm-res-web-site/azurerm"
  version                         = "0.18.0"
  name                            = module.naming_app_service.result
  resource_group_name             = var.resource_group_name
  location                        = var.location
  kind                            = "webapp"
  os_type                         = var.os_type
  service_plan_resource_id        = var.service_plan_resource_id
  https_only                      = var.https_only
  public_network_access_enabled   = var.public_network_access_enabled
  virtual_network_subnet_id       = var.virtual_network_subnet_id
  key_vault_reference_identity_id = module.managed_identity.resource_id
  client_affinity_enabled         = var.client_affinity_enabled
  enable_application_insights     = local.enable_application_insights
  site_config                     = local.site_config
  managed_identities              = local.managed_identities
  application_insights            = local.app_insights
  private_endpoints               = local.private_endpoints
  app_settings                    = var.app_settings
  tags                            = var.tags
}