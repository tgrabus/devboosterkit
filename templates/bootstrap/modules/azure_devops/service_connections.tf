resource "azuredevops_serviceendpoint_azurerm" "alz" {
  for_each                               = var.environments
  project_id                             = local.project_id
  service_endpoint_name                  = each.value.environment_name
  description                            = "Managed by Terraform"
  service_endpoint_authentication_scheme = local.authentication_scheme_workload_identity_federation

  credentials {
    serviceprincipalid = var.managed_identity_client_ids[each.key]
  }

  azurerm_spn_tenantid      = var.azure_tenant_id
  azurerm_subscription_id   = var.azure_subscription_id
  azurerm_subscription_name = var.azure_subscription_name
}


