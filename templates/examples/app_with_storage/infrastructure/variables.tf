variable "subscription_id" {
  type    = string
  default = null
}

variable "location" {
  type        = string
  description = "Azure region for environment resources"
}

variable "stage" {
  type        = string
  description = "Deployment stage (e.g., development, production)"

  validation {
    condition     = contains(["development", "qa", "staging", "production"], var.stage)
    error_message = "Invalid stage. Allowed values are: development, qa, staging, production."
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

variable "allow_access_from_my_ip" {
  type = bool
}

variable "vnet_address_space" {
  type        = string
  description = "The address space for the Virtual Network in CIDR notation (e.g., '10.0.0.0/16')"
}

variable "subnets_address_space" {
  type        = map(string)
  description = "The address space for the subnet in CIDR notation (e.g., '10.0.0.0/26')"
}

variable "sql_administrator_group" {
  type        = string
  description = "Azure Active Directory group that will be granted administrator privileges on the Azure SQL Server"
}

variable "email_receivers" {
  type        = map(string)
  description = "Email addresses for security alerts and notifications"
}

variable "public_network_access_enabled" {
  type    = bool
  default = false
}

variable "purge_protection_enabled" {
  type    = bool
  default = true
}