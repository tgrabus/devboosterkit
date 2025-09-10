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

variable "resource_group" {
  type = object({
    name     = string
    location = string
  })
}

variable "sku" {
  type    = string
  default = "Basic"
}

variable "public_network_access_enabled" {
  type    = bool
  default = true
}

variable "roles" {
  type = map(object({
    role_definition_id_or_name = string
    principal_id               = string
  }))
}

variable "private_endpoints" {
  type = map(object({
    private_dns_zone_resource_id = string
    subnet_resource_id           = string
  }))
  description = "A map of private endpoints to create"
}

variable "allowed_ip_ranges" {
  description = "List of allowed IPs when firewall is enabled"
  type        = list(string)
  default     = []
}

variable "tags" {
  type    = map(string)
  default = {}
}