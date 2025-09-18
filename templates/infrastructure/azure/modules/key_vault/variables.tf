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
  description = "Optional short description of the resource"
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
  default     = {}
  description = <<DESCRIPTION
A map of Private Endpoints to create for the Key Vault.

Map key is an arbitrary identifier. Each object supports:

- `private_dns_zone_resource_id` - Resource ID of the Private DNS Zone to link (e.g. /subscriptions/<subId>/resourceGroups/<rg>/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net).
- `subnet_resource_id` - Resource ID of the subnet where the Private Endpoint will be created.
- `resource_group_name` - Optional. Target resource group name for the Private Endpoint resource. If omitted, module defaults are used.
DESCRIPTION
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled"
  type        = bool
  default     = true
}

variable "allowed_ip_ranges" {
  description = "Map of allowed IPs when firewall is enabled"
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
  default     = {}
  description = <<DESCRIPTION
Map of role assignments to create for this Key Vault.

Map key is an arbitrary identifier. Each object supports:

- `role_definition_id_or_name` - The role to assign. Can be a built-in role name (e.g., "Key Vault Secrets Officer") or a role definition ID (GUID).
- `principal_id` - Object ID of the principal (user, group, or managed identity) that will receive the role assignment.
DESCRIPTION
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
  default     = {}
  description = <<DESCRIPTION
Map of Key Vault secrets to create.

Map key is a logical identifier. Each object supports:

- `name` - Name of the secret as it will appear in Key Vault.
- `value` - Secret value (ensure you handle sensitive values securely).
- `content_type` - Optional. Content type metadata for the secret. Defaults to "string".
- `expiration_date` - Optional. Expiration timestamp in ISO 8601/RFC3339 format, e.g. 2030-12-31T00:00:00Z.
- `ignore_value_changes` - Optional. Defaults to false. If true, changes to the secret value will be ignored by Terraform to avoid unnecessary updates.
DESCRIPTION
}