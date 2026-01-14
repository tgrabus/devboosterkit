locals {
  acr = {
    private_endpoints = {
      acr = {
        private_dns_zone_resource_id = azurerm_private_dns_zone.pdz["azure_acr"].id
        subnet_resource_id           = module.cicd_vnet.subnets["private_endpoints"].id
      }
    }
  }
}

module "acr" {
  source                                = "../../../modules/acr"
  instance                              = var.instance
  location                              = var.location
  stage                                 = var.stage
  product                               = var.product
  resource_group_name                   = module.resource_groups["acr"].name
  private_networking_enabled            = var.use_private_networking
  network_rule_bypass_allowed_for_tasks = true
  private_endpoints                     = local.acr.private_endpoints
  tags                                  = local.tags
}

resource "azurerm_container_registry_task" "agent_image_build_task" {
  name                  = "agent-image-build-task"
  container_registry_id = module.acr.resource_id

  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = var.container_registry_dockerfile_name
    context_path         = var.container_registry_dockerfile_repository
    context_access_token = "default"
    image_names          = ["${var.container_registry_image_name}:${var.container_registry_image_tag}"]
  }

  identity {
    type = "SystemAssigned"
  }

  registry_credential {
    custom {
      login_server = module.acr.server
      identity     = "[system]"
    }
  }
}

resource "azurerm_role_assignment" "container_registry_push_for_task" {
  scope                = module.acr.resource_id
  role_definition_name = "AcrPush"
  principal_id         = azurerm_container_registry_task.agent_image_build_task.identity[0].principal_id
}

resource "azurerm_container_registry_task_schedule_run_now" "agent_image_build_task" {
  container_registry_task_id = azurerm_container_registry_task.agent_image_build_task.id

  lifecycle {
    replace_triggered_by = [azurerm_container_registry_task.agent_image_build_task]
  }

  depends_on = [
    module.acr,
    azurerm_role_assignment.container_registry_push_for_task
  ]
}