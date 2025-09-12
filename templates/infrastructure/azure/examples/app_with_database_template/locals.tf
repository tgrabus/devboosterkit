locals {
  tags = {
    environment = "${var.stage}_${var.location}_${var.instance}"
    product     = var.product
    managedBy   = "Terraform"
    version     = "1.0.0"
  }
  
  action_groups = {
    default = {
      name = "default"
      email_receivers = var.email_receivers
    }
  }

  sql = {
    azuread_administrator = {
      login_username = data.azuread_group.sql_administrator_group.display_name
      object_id      = data.azuread_group.sql_administrator_group.object_id
    }

    diagnostic_settings = {
      workspace_resource_id = module.observability.resource_id
    }

    private_endpoints = {
      sql = {
        private_dns_zone_resource_id = module.private_dns_zones.private_dns_zone_resource_ids["azure_sql_server"]
        subnet_resource_id           = module.vnet.subnets[local.subnets.database.name].id
      }
    }

    databases = {
      backend = {
        max_size_gb = 20
      }
    }
  }
}