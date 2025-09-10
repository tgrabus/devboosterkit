variable "stage" {
  type        = string
  description = "Stage the resource is provisioned"

  validation {
    condition     = contains(["development", "qualification", "sandbox", "production"], var.stage)
    error_message = "Only development, qualification, sandbox, production are allowed."
  }
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
  description = "Optional Short description of the resource"
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
  default = {}
}