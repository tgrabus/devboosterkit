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

