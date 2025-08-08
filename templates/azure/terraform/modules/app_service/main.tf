locals {
  ip_restrictions = { for key, item in var.ip_restrictions : key => {
    name        = key
    action      = "Allow"
    ip_address  = lookup(item, "ip_address", null)
    service_tag = lookup(item, "service_tag", null)
    priority    = index(keys(var.ip_restrictions), key) + 100
  } }

  scm_ip_restrictions = { for key, item in var.scm_ip_restrictions : key => {
    name        = key
    action      = "Allow"
    ip_address  = lookup(item, "ip_address", null)
    service_tag = lookup(item, "service_tag", null)
    priority    = index(keys(var.scm_ip_restrictions), key) + 100
  } }

  site_config_overrides = {
    ip_restriction_default_action = var.ip_restrictions_default_action
    ip_restriction                = local.ip_restrictions
    scm_ip_restriction_default_action = var.scm_ip_restriction_default_action
    scm_ip_restriction                = local.scm_ip_restrictions
    
    application_stack = {
      dotnet = {
        dotnet_version              = var.application_stack.dotnet_version
        use_custom_runtime          = false
        use_dotnet_isolated_runtime = var.application_stack.use_dotnet_isolated_runtime
        current_stack               = "dotnet"
      }
    }
  }
}

# Create App
module "this" {
  source = "Azure/avm-res-web-site/azurerm"
  name                            = module.naming.result
  resource_group_name             = var.resource_group_name
  location                        = var.location
  kind                            = "webapp"
  os_type                         = var.os_type
  service_plan_resource_id        = var.service_plan_resource_id
  enabled                         = var.enabled
  https_only                      = var.https_only
  public_network_access_enabled   = var.public_network_access_enabled
  virtual_network_subnet_id       = var.virtual_network_subnet_id
  key_vault_reference_identity_id = var.key_vault_reference_identity_id
  client_affinity_enabled         = var.client_affinity_enabled
  enable_application_insights   = false # disable auto creation
  site_config = merge(var.site_config, local.site_config_overrides)
  managed_identities = var.managed_identities
  private_endpoints             = local.private_endpoints
  app_settings = var.app_settings
  tags = var.tags
}