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

variable "roles" {
  type = map(object({
    scope     = string
    role_name = string
  }))
  default     = {}
  description = <<DESCRIPTION
Map of role assignments to create for this Managed Identity.

Map key is an arbitrary identifier. Each object supports:

- `scope` - The Azure Resource ID of the scope where the role assignment applies (e.g., a subscription, resource group, or resource).
- `role_name` - The name of the built-in or custom role to assign (e.g., "Reader").
DESCRIPTION
}