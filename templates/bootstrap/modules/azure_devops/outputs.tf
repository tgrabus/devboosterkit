output "organization_url" {
  value = local.organization_url
}

output "agent_pool_name" {
  value = azuredevops_agent_pool.this.name
}

output "service_connections" {
  value = { for key, value in var.environments : key => {
    name    = azuredevops_serviceendpoint_azurerm.alz[key].service_endpoint_name
    subject = azuredevops_serviceendpoint_azurerm.alz[key].workload_identity_federation_subject
    issuer  = azuredevops_serviceendpoint_azurerm.alz[key].workload_identity_federation_issuer
  } }
}

output "variable_groups" {
  value = { for key, value in azuredevops_variable_group.environments : key => {
    name = value.name
  } }
}

