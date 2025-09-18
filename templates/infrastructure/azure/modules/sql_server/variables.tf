variable "stage" {
  type        = string
  description = "Stage the resource is provisioned"
}

variable "location" {
  type        = string
  description = "Azure region"
}

variable "instance" {
  type        = number
  description = "Environment instance for region"
}

variable "product" {
  type        = string
  description = "The product name this resource belongs to"
  default     = "finzeo"
}

variable "short_description" {
  type        = string
  description = "Optional short description of the resource"
  default     = null
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "server_version" {
  type        = string
  description = "SQL Server version"
  default     = "12.0"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is enabled"
  default     = false
}

variable "azuread_administrator" {
  type = object({
    azuread_authentication_only = optional(bool, true)
    login_username              = string
    object_id                   = string
  })
  description = "Azure AD administrator settings for the SQL server"
}

variable "elastic_pool" {
  type = object({
    max_size_gb    = optional(number, 50)
    zone_redundant = optional(bool, false)
    sku = optional(object({
      name     = optional(string, "StandardPool")
      capacity = optional(number, 50)
      tier     = optional(string, "Standard")
      family   = optional(string, null)
    }), {})
    per_database_settings = optional(object({
      min_capacity = optional(number, 0)
      max_capacity = optional(number, 50)
    }), {})
  })
  description = "Elastic pool configuration for the SQL server"
  default     = {}
}

variable "diagnostic_settings" {
  type = object({
    workspace_resource_id = string
    enabled               = optional(bool, true)
  })
  description = "Diagnostic settings for sending logs to Log Analytics"
}

variable "databases" {
  type = map(object({
    collation                   = optional(string, "SQL_Latin1_General_CP1_CI_AS")
    max_size_gb                 = optional(number)
    backup_storage_account_type = optional(string, "Geo")

    short_term_retention_policy = optional(object({
      retention_days           = optional(number, 7)
      backup_interval_in_hours = optional(number, 12)
    }), {})

    long_term_retention_policy = optional(object({
      weekly_retention  = optional(string, "PT0S")
      monthly_retention = optional(string, "PT0S")
      yearly_retention  = optional(string, "PT0S")
      week_of_year      = optional(number, 1)
    }), {})
  }))
  description = "Map of databases to create with retention policies and settings"
  default     = {}
}

variable "vulnerability_assessment" {
  type = object({
    enabled         = optional(bool, true)
    retention_days  = optional(number, 90)
    email_addresses = optional(list(string), [])
  })

  default = {}
}

variable "private_endpoints" {
  type = map(object({
    private_dns_zone_resource_id = string
    subnet_resource_id           = string
    resource_group_name          = optional(string)
  }))
  default = {}
}

variable "allowed_ips" {
  type        = map(string)
  default     = {}
  description = "Map of IPs in CIDR format"
}

variable "action_group_id" {
  type        = string
  description = "Action Group to use when alerts are raised"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the resource"
  default     = {}
}