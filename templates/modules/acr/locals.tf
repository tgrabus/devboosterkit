locals {
  network_rule_set = {
    default_action = "Deny"
    ip_rule = [for allowed_ip in var.allowed_ip_ranges : {
      action   = "Allow"
      ip_range = allowed_ip
    }]
  }
}

locals {
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

locals {
  task_push_roles = {
    for key, task in var.tasks : key =>
    {
      role_definition_id_or_name = "AcrPush"
      principal_id               = azurerm_container_registry_task.tasks[key].identity[0].principal_id
    }
  }

  role_assignments = local.task_push_roles
}

locals {
  managed_identities = {
    system_assigned = true
  }
}