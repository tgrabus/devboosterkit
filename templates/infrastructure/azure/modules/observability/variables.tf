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
  type = string
  description = "Resource group name"
}

variable "retention_in_days" {
  type    = number
  default = 90
  description = "How long to store logs in days"
}

variable "action_groups" {
  type = map(object({
    email_receivers = optional(map(string), {})
  }))

  default = {}
  description = "Map of action groups to create"
}

variable "tags" {
  type    = map(string)
  default = {}
  description = "Map of tags to assign"
}