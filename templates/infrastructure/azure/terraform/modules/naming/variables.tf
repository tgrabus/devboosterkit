variable "location" {
  type        = string
  description = "Azure region"
}

variable "stage" {
  type        = string
  description = "Stage the resource is provisioned"

  validation {
    condition     = contains(["dev", "qa", "staging", "prod"], var.stage)
    error_message = "Only dev, qa, staging, prod are allowed."
  }
}

variable "instance" {
  type        = number
  description = "Environment instance for region"
}

variable "product" {
  type        = string
  description = "The product name this environment belongs to"
}

variable "short_description" {
  type        = string
  description = "Optional short description of the resource"
  default     = null
}

variable "resource_type" {
  type        = string
  description = "Azure resource type"
}
