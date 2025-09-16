variable "subscription_ids" {
  type        = map(string)
  description = "Map of subscription IDs by environment"
}

variable "location" {
  type        = string
  default     = "West Europe"
  description = "Azure region for environment resources"
}

variable "stage" {
  type        = string
  default     = "dev"
  description = "Deployment stage (e.g., dev, test, prod)"

  validation {
    condition     = contains(["dev", "qa", "staging", "prod"], var.stage)
    error_message = "Invalid stage. Allowed values are: dev, qa, staging, prod."
  }
}

variable "instance" {
  type        = number
  default     = 1
  description = "Instance of environment"
}

variable "product" {
  type        = string
  description = "The product name this environment belongs to"
}

variable "allowed_ips" {
  type        = map(string)
  default     = {}
  description = "Map of whitelisted IPs in CIDR format"
}


variable "vnet_address_space" {
  type        = string
  description = "The address space for the Virtual Network in CIDR notation (e.g., '10.0.0.0/16')"
}

variable "sql_administrator_group" {
  type        = string
  description = "Azure Active Directory group that will be granted administrator privileges on the Azure SQL Server"
}

variable "email_receivers" {
  type        = map(string)
  default     = {}
  description = "Email addresses used in action group"
}

variable "public_network_access_enabled" {
  type    = bool
  default = false
}