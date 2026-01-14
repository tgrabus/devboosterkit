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

variable "containers" {
  type = map(object({
    server     = string
    image_name = string
    image_tag  = string
    cpu        = optional(number, 4)
    memory     = optional(number, 16)
    ports = optional(list(object({
      port     = string
      protocol = optional(string, "TCP")
    })))
  }))
  default = {}
}

variable "subnet_id" {
  type = string
}

variable "zones" {
  type    = list(string)
  default = []
}

variable "environment_vars" {
  type    = map(string)
  default = {}
}

variable "secure_environment_vars" {
  type    = map(string)
  default = {}
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "role_assignments" {
  type = map(object({
    scope     = string
    role_name = string
  }))
  default     = {}
  description = <<DESCRIPTION
- `scope` - The Azure Resource ID of the scope where the role assignment applies.
- `role_name` - The name of the built-in or custom role to assign.
DESCRIPTION
}