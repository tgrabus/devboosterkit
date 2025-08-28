variable "subscription_ids" {
  description = "Map of subscription IDs by environment"
  type        = map(string)
}

variable "location" {
  description = "Azure region for environment resources"
  type        = string
  default     = "West Europe"
}

variable "stage" {
  description = "Deployment stage (e.g., dev, test, prod)"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "qa", "staging", "prod"], var.stage)
    error_message = "Invalid stage. Allowed values are: dev, qa, staging, prod."
  }
}

variable "instance" {
  description = "Instance of environment"
  type        = number
  default     = 1
}

variable "product" {
  type        = string
  description = "The product name this environment belongs to"
}

variable "vnet_address_space" {
  type = string
}

variable "ip_whitelist" {
  type = map(object({
    ip_address = string
  }))
  default = {}
  description = "Map of IPs in CIDR format"
}