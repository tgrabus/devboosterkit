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

variable "private_networking_enabled" {
  type        = bool
  description = "Whether private networking is enabled"
  default     = false
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

variable "network_rule_bypass_allowed_for_tasks" {
  type        = bool
  default     = false
  description = "Whether to add network for tasks"
}