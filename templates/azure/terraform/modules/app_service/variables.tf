variable "location" {
  type        = string
  description = "Azure region"
}

variable "stage" {
  type        = string
  description = "Deployment stage"
}

variable "instance" {
  type        = number
  description = "Instance number"
}

variable "product" {
  type        = string
  description = "Product name"
}

variable "short_description" {
  type        = string
  description = "Short description"
  default     = null
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "os_type" {
  type = string
}

variable "service_plan_resource_id" {
  type = string
}

variable "virtual_network_subnet_id" {
  type = string
}

variable "public_network_access_enabled" {
  type    = bool
  default = false
}

variable "app_settings" {
  type = map(string)
}

variable "enabled" {
  type    = bool
  default = true
}

variable "https_only" {
  type    = bool
  default = true
}

variable "client_affinity_enabled" {
  type    = bool
  default = false
}

variable "site_config" {
  type = object({
    always_on                         = optional(bool, true)
    app_scale_limit                   = optional(number)
    health_check_eviction_time_in_min = optional(number)
    health_check_path                 = optional(string)
    http2_enabled                     = optional(bool, true)
    minimum_tls_version               = optional(string, "1.3")
    pre_warmed_instance_count         = optional(number)
    runtime_scale_monitoring_enabled  = optional(bool)
    scm_minimum_tls_version           = optional(string, "1.2")
    vnet_route_all_enabled            = optional(bool, false)
    websockets_enabled                = optional(bool, false)
    worker_count                      = optional(number)
    cors = optional(map(object({
      allowed_origins     = optional(list(string))
      support_credentials = optional(bool, false)
    })), {})
  })
  default = {}
}

variable "managed_identities" {
  type = object({
    system_assigned            = optional(bool, false)
    user_assigned_resource_ids = optional(set(string), [])
  })
}

variable "application_stack" {
  type = object({
    dotnet_version              = string
    use_dotnet_isolated_runtime = optional(bool, false)
  })
}

variable "private_endpoints" {
  type = map(object({
    private_dns_zone_resource_id = string
    subnet_resource_id           = string
  }))
}

variable "storage_account_name" {
  type    = string
  default = null
}

variable "scm_ip_restriction_default_action" {
  type    = string
  default = "Deny"

  validation {
    condition     = contains(["Deny", "Allow"], var.scm_ip_restriction_default_action)
    error_message = "Deny or Allow only"
  }
}

variable "scm_ip_restrictions" {
  type = map(object({
    action                    = optional(string, "Allow")
    ip_address                = optional(string)
    service_tag               = optional(string)
    virtual_network_subnet_id = optional(string)
  }))

  default = {}
}

variable "ip_restrictions_default_action" {
  type    = string
  default = "Deny"

  validation {
    condition     = contains(["Deny", "Allow"], var.ip_restrictions_default_action)
    error_message = "Deny or Allow only"
  }
}

variable "ip_restrictions" {
  type = map(object({
    action                    = optional(string, "Allow")
    ip_address                = optional(string)
    service_tag               = optional(string)
    virtual_network_subnet_id = optional(string)
  }))

  default = {}
}

variable "application_insights_connection_string" {
  type    = string
  default = null
}

variable "application_insights_key" {
  type    = string
  default = null
}

variable "key_vault_reference_identity_id" {
  type    = string
  default = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the resource"
  default     = {}
}