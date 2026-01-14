
module "azure" {
  source                                                    = "../modules/azure"
  location                                                  = var.bootstrap_location
  environments                                              = local.environments
  user_assigned_managed_identities                          = local.user_assigned_managed_identities
  federated_credentials                                     = local.federated_credentials
  agent_container_instances                                 = local.agent_container_instances
  agent_organization_url                                    = module.azure_devops.organization_url
  agent_token                                               = var.azure_devops_agents_personal_access_token
  agent_pool_name                                           = module.azure_devops.agent_pool_name
  use_private_networking                                    = var.use_private_networking
  virtual_network_address_space                             = var.virtual_network_address_space
  virtual_network_subnet_address_prefix_container_instances = var.virtual_network_subnet_address_prefix_container_instances
  virtual_network_subnet_address_prefix_private_endpoints   = var.virtual_network_subnet_address_prefix_private_endpoints
  container_registry_image_name                             = var.agent_container_image_name
  container_registry_image_tag                              = var.agent_container_image_tag
  container_registry_dockerfile_name                        = var.agent_container_image_dockerfile
  container_registry_dockerfile_repository                  = local.agent_container_instance_dockerfile_url
  target_subscriptions                                      = local.target_subscriptions
  allowed_ips                                               = local.allowed_ips
}

module "azure_devops" {
  source                             = "../modules/azure_devops"
  organization_name                  = var.azure_devops_organization_name
  create_project                     = var.azure_devops_create_project
  project_name                       = var.azure_devops_project_name
  environments                       = local.environments
  managed_identity_client_ids        = module.azure.user_assigned_managed_identity_client_ids
  repository_name                    = var.version_control_repository_name
  repository_files                   = local.repository_files
  azure_tenant_id                    = data.azurerm_client_config.current.tenant_id
  azure_subscription_id              = data.azurerm_client_config.current.subscription_id
  azure_subscription_name            = data.azurerm_subscription.current.display_name
  pipelines                          = local.pipelines
  backend_azure_resource_group_name  = module.azure.state_storage.resource_group_name
  backend_azure_storage_account_name = module.azure.state_storage.name
  agent_pool_name                    = var.agent_pool_name
  target_subscriptions               = local.subscriptions_data
}
