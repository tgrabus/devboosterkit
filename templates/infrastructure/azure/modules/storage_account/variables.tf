
variable "stage" {
  description = "Stage of the environment"
  type        = string
}

variable "product" {
  description = "Name of the product"
  type        = string
}

variable "instance" {
  description = "Number of the instance"
  type        = number
}

variable "short_description" {
  description = "Short description of the resource"
  type        = string
  default     = null
}

variable "location" {
  description = "Location of the resource group in which to create the storage account"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group in which to create the storage account"
  type        = string
}

variable "storage_tier" {
  description = "Storage Account Tier (Standard, Premium)"
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "Storage Replication Type (LRS, GRS, ZRS, etc.)"
  type        = string
  default     = "LRS"
}

variable "storage_access_tier" {
  description = "Storage Access Tier (Hot, Cool)"
  type        = string
  default     = "Hot"
}

variable "enable_firewall" {
  description = "Enable firewall and restrict access to trusted networks"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  type    = bool
  default = false
}

variable "allow_nested_items_to_be_public" {
  type    = bool
  default = false
}

variable "sftp_enabled" {
  type    = bool
  default = false
}

variable "allowed_ip_ranges" {
  description = "List of allowed IPs when firewall is enabled"
  type        = map(string)
  default     = {}
}

variable "network_bypass" {
  type    = set(string)
  default = ["AzureServices"]
}

variable "containers" {
  description = "Map of storage containers to create within the storage account"
  type = map(object({
    name          = string
    public_access = optional(string, "None")
  }))
  default = {}
}

variable "private_endpoints" {
  description = "Map of private endpoints configuration"
  type = map(object({
    private_dns_zone_resource_id = string
    subnet_resource_id           = string
    subresource_name             = string
  }))
  default = {}
}

variable "roles" {
  type = map(object({
    role_definition_id_or_name = string
    principal_id               = string
  }))
  default = {}
}

variable "queues" {
  type = map(object({
    name = string
  }))
  default = {}
}

variable "sftp_admins" {
  type = map(object({
    name       = string
    containers = list(string)
  }))
  default = {}
}

variable "allowed_copy_scope" {
  type    = string
  default = null
}

variable "default_to_oauth_authentication" {
  type    = bool
  default = true
}

variable "shared_access_key_enabled" {
  type    = bool
  default = false
}

variable "tags" {
  description = "Tags to apply to the storage account"
  type        = map(string)
  default     = {}
}