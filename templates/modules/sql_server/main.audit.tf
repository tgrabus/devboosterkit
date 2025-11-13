module "audit_storage" {
  source                        = "../storage_account"
  instance                      = var.instance
  location                      = var.location
  product                       = var.product
  stage                         = var.stage
  short_description             = "dbaudit"
  resource_group_name           = var.resource_group_name
  roles                         = local.audit_storage.roles
  enable_firewall               = true
  public_network_access_enabled = true
  shared_access_key_enabled     = true
  allowed_ip_ranges             = var.allowed_ips
  network_bypass                = ["AzureServices", "Logging", "Metrics"]
  storage_tier                  = "Standard"
  replication_type              = "LRS"
  containers                    = local.audit_storage.containers
  tags                          = var.tags
}

resource "azurerm_mssql_server_extended_auditing_policy" "audit_policy" {
  server_id              = module.server.resource.id
  storage_endpoint       = module.audit_storage.primary_blob_endpoint
  retention_in_days      = var.vulnerability_assessment.retention_days
  log_monitoring_enabled = false
  depends_on             = [module.audit_storage]
}

resource "azurerm_mssql_server_security_alert_policy" "alert_policy" {
  server_name          = module.server.resource_name
  resource_group_name  = var.resource_group_name
  state                = var.vulnerability_assessment.enabled ? "Enabled" : "Disabled"
  retention_days       = var.vulnerability_assessment.retention_days
  email_addresses      = var.vulnerability_assessment.email_addresses
  email_account_admins = true
  depends_on           = [module.audit_storage]
}

resource "azurerm_mssql_server_vulnerability_assessment" "vulnerability_assessment" {
  server_security_alert_policy_id = azurerm_mssql_server_security_alert_policy.alert_policy.id
  storage_container_path          = "${module.audit_storage.primary_blob_endpoint}${local.audit_storage.containers.vulnerability_assessment.name}/"

  recurring_scans {
    enabled                   = var.vulnerability_assessment.enabled
    emails                    = var.vulnerability_assessment.email_addresses
    email_subscription_admins = true
  }
}