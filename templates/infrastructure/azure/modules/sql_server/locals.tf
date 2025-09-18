locals {
  sql_server = {
    azuread_administrator = {
      azuread_authentication_only = var.azuread_administrator.azuread_authentication_only
      login_username              = var.azuread_administrator.login_username
      object_id                   = var.azuread_administrator.object_id
    }

    private_endpoints = { for key, endpoint in var.private_endpoints : key => {
      name                            = module.naming_pe[key].result
      private_service_connection_name = module.naming_psc[key].result
      network_interface_name          = module.naming_nic[key].result
      private_dns_zone_resource_ids   = [endpoint.private_dns_zone_resource_id]
      subnet_resource_id              = endpoint.subnet_resource_id
      subresource_name                = "sqlServer"
      resource_group_name             = endpoint.resource_group_name
      tags                            = var.tags
    } }

    firewall_rules = {
      for key, ip_address in var.allowed_ips : key =>
      {
        start_ip_address = cidrhost(ip_address, 0)
        end_ip_address   = cidrhost(ip_address, -1)
      }
    }

    managed_identities = {
      system_assigned = true
    }
  }

  audit_storage = {
    containers = {
      vulnerability_assessment = {
        name = "vulnerabilityassessment"
      }
    }
    roles = {
      sql_server_identity = {
        role_definition_id_or_name = "Storage Blob Data Contributor"
        principal_id               = module.server.resource.identity[0].principal_id
      }
    }
  }

  sql_server_reference = {
    resource_id = module.server.resource_id
  }

  elastic_pool = {
    alerts = {
      cpu = {
        frequency = "PT1M"
        window    = "PT5M"
        severity  = 3
        criterias = [
          {
            metric_name = "cpu_percent"
            aggregation = "Average"
            threshold   = 90
          }
        ]
      }
      io = {
        frequency = "PT1M"
        window    = "PT5M"
        severity  = 3
        criterias = [
          {
            metric_name = "physical_data_read_percent"
            aggregation = "Average"
            threshold   = 90
          },
          {
            metric_name = "storage_percent"
            aggregation = "Maximum"
            threshold   = 90
          },
          {
            metric_name = "xtp_storage_percent"
            aggregation = "Average"
            threshold   = 90
          },
          {
            metric_name = "log_write_percent"
            aggregation = "Average"
            threshold   = 90
          }
        ]
      }
      concurrency = {
        frequency = "PT1M"
        window    = "PT5M"
        severity  = 3
        criterias = [
          {
            metric_name = "sessions_percent"
            aggregation = "Maximum"
            threshold   = 90
          },
          {
            metric_name = "workers_percent"
            aggregation = "Maximum"
            threshold   = 90
          }
        ]
      }
    }
  }
}