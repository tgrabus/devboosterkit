module "aci" {
  for_each            = var.agent_container_instances
  source              = "../../../modules/aci"
  instance            = var.instance
  location            = var.location
  stage               = var.stage
  product             = var.product
  short_description   = each.key
  resource_group_name = module.resource_groups[local.resource_groups.agents].name
  zones               = each.value.zones
  subnet_id           = module.cicd_vnet.subnets["container_instances"].id

  role_assignments = {
    acr = {
      scope     = module.acr.resource_id
      role_name = "AcrPull"
    }
  }

  containers = {
    (each.key) = {
      server     = module.acr.server
      image_name = var.container_registry_image_name
      image_tag  = var.container_registry_image_tag
      cpu        = each.value.cpu
      memory     = each.value.memory
      ports = [{
        port     = 80
        protocol = "TCP"
      }]
    }
  }

  environment_vars = {
    "AZP_URL"         = var.agent_organization_url
    "AZP_AGENT_NAME"  = each.key
    "AZP_POOL"        = var.agent_pool_name
    "ACR_TASKS_READY" = length(module.acr.tasks_completed) > 0 ? "true" : "false"
  }

  secure_environment_vars = {
    "AZP_TOKEN" = var.agent_token
  }

  tags = local.tags
}