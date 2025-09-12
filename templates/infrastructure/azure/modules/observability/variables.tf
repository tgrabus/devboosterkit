variable "stage" {
  type        = string
  description = "Stage the resource is provisioned"

  validation {
    condition     = contains(["dev", "qa", "staging", "prod"], var.stage)
    error_message = "Invalid stage. Allowed values are: dev, qa, staging, prod."
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
}

variable "short_description" {
  type        = string
  description = "Optional Short description of the resource"
  default     = null
}

variable "retention_in_days" {
  type    = number
  default = 90
}

variable "action_groups" {
  type = map(object({
    email_receivers = optional(map(string), {})
  }))
  
  default = {}
}

variable "tags" {
  type = map(string)
  default = {}
}