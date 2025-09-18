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

variable "sku" {
  type        = string
  description = "SKU tier for the container registry"
  default     = "Basic"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is enabled"
  default     = true
}

variable "roles" {
  type = map(object({
    role_definition_id_or_name = string
    principal_id               = string
  }))
  default     = {}
  description = <<DESCRIPTION
Map of role assignments to create for the Container Registry.

Map key is an arbitrary identifier. Each object supports:

- `role_definition_id_or_name` - The role to assign. Can be a built-in role name (e.g., "AcrPull") or a role definition ID (GUID).
- `principal_id` - Object ID of the principal (user, group, or managed identity) that will receive the role assignment.
DESCRIPTION
}

variable "private_endpoints" {
  type = map(object({
    private_dns_zone_resource_id = string
    subnet_resource_id           = string
    resource_group_name          = optional(string)
  }))
  default     = {}
  description = <<DESCRIPTION
A map of Private Endpoints to create for the Container Registry.

Map key is an arbitrary identifier. Each object supports:

- `private_dns_zone_resource_id` - Resource ID of the Private DNS Zone to link (e.g. /subscriptions/<subId>/resourceGroups/<rg>/providers/Microsoft.Network/privateDnsZones/privatelink.azurecr.io).
- `subnet_resource_id` - Resource ID of the subnet where the Private Endpoint will be created.
- `resource_group_name` - Optional. Target resource group name for the Private Endpoint resource. If omitted, module defaults are used.
DESCRIPTION
}

variable "allowed_ip_ranges" {
  description = "Map of allowed IPs when firewall is enabled"
  type        = map(string)
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}