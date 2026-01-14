module "this" {
  source                        = "Azure/avm-res-containerregistry-registry/azurerm"
  version                       = "0.4.0"
  name                          = module.naming.result
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.private_networking_enabled ? "Premium" : "Basic"
  admin_enabled                 = false
  public_network_access_enabled = !var.private_networking_enabled
  network_rule_bypass_option    = var.private_networking_enabled ? "AzureServices" : "None"
  zone_redundancy_enabled       = var.private_networking_enabled ? true : false
  private_endpoints             = var.private_networking_enabled ? local.private_endpoints : {}
  network_rule_set              = var.private_networking_enabled ? local.network_rule_set : null
  tags                          = var.tags
  managed_identities            = local.managed_identities
}

resource "azapi_update_resource" "network_rule_bypass_allowed_for_tasks" {
  count       = var.network_rule_bypass_allowed_for_tasks ? 1 : 0
  type        = "Microsoft.ContainerRegistry/registries@2025-05-01-preview"
  resource_id = module.this.resource_id
  body = {
    properties = {
      networkRuleBypassAllowedForTasks = true
    }
  }
}