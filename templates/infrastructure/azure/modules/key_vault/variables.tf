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
}

variable "short_description" {
  type        = string
  description = "Optional Short description of the resource"
  default     = null
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "tenant_id" {
  type        = string
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
}

variable "purge_protection_enabled" {
  type    = bool
  default = false
}

variable "sku_name" {
  type    = string
  default = "standard"

  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "Only standard or premium"
  }
}

variable "private_endpoints" {
  type = map(object({
    private_dns_zone_resource_id = string
    subnet_resource_id           = string
    resource_group_name          = optional(string)
  }))
  description = "A map of private endpoints to create"
  default     = {}
}

variable "public_network_access_enabled" {
  description = "Enable firewall and restrict access to trusted networks"
  type        = bool
  default     = true
}

variable "allowed_ip_ranges" {
  description = "List of allowed IPs when firewall is enabled"
  type        = map(string)
  default     = {}
}

variable "soft_delete_retention_days" {
  type        = number
  default     = null
  description = "The number of days that items should be retained for once soft-deleted"
}

variable "roles" {
  type = map(object({
    role_definition_id_or_name = string
    principal_id               = string
  }))
  default = {}
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "secrets" {
  type = map(object({
    name                 = string
    value                = string
    content_type         = optional(string, "string")
    expiration_date      = optional(string)
    ignore_value_changes = optional(bool, false)
  }))
  default = {}
}