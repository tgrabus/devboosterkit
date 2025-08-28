variable "location" {
  type        = string
  description = "Azure region"
}

variable "stage" {
  type        = string
  description = "Deployment stage"
}

variable "instance" {
  type        = number
  description = "Instance number"
}

variable "product" {
  type        = string
  description = "Product name"
}

variable "short_description" {
  type        = string
  description = "Short description"
  default     = null
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "os_type" {
  type = string

  validation {
    condition     = contains(["Windows", "Linux"], var.os_type)
    error_message = "Windows or Linux is only supported"
  }
}

variable "sku_name" {
  type = string
}

variable "properties" {
  type = object({
    per_site_scaling_enabled        = optional(bool, false)
    zone_balancing_enabled          = optional(bool, false)
    premium_plan_auto_scale_enabled = optional(bool, false)
    maximum_elastic_worker_count    = optional(number)
    worker_count                    = optional(number)
  })
  default = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the resource"
  default     = {}
}