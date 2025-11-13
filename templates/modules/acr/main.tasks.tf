
resource "azapi_update_resource" "network_rule_bypass_allowed_for_tasks" {
  count       = length(var.tasks) > 0 ? 1 : 0
  type        = "Microsoft.ContainerRegistry/registries@2025-05-01-preview"
  resource_id = module.this.resource_id
  body = {
    properties = {
      networkRuleBypassAllowedForTasks = true
    }
  }
}

resource "azurerm_container_registry_task" "tasks" {
  for_each              = var.tasks
  name                  = each.value.name
  container_registry_id = module.this.resource_id

  platform {
    os = "Linux"
  }

  docker_step {
    dockerfile_path      = each.value.dockerfile_name
    context_path         = each.value.dockerfile_repository_folder_url
    context_access_token = each.value.access_token
    image_names          = ["${each.value.image_name}:${each.value.image_tag}"]
  }

  identity {
    type = "SystemAssigned"
  }

  registry_credential {
    custom {
      login_server = module.this.resource.login_server
      identity     = "[system]"
    }
  }
}

resource "azurerm_container_registry_task_schedule_run_now" "tasks" {
  for_each = { for key, value in var.tasks : key => value if value.run_now }

  container_registry_task_id = azurerm_container_registry_task.tasks[each.key].id

  lifecycle {
    replace_triggered_by = [azurerm_container_registry_task.tasks[each.key]]
  }

  depends_on = [
    module.this,
    azapi_update_resource.network_rule_bypass_allowed_for_tasks
  ]
}