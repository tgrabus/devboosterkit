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
}

variable "service_plan_resource_id" {
  type = string
}

variable "virtual_network_subnet_id" {
  type = string
}

variable "app_settings" {
  type    = map(string)
  default = {}
}

variable "app_stack" {
  type = object({
    dotnet_version      = optional(string)
    docker_registry_url = optional(string)
    docker_image_name   = optional(string)
  })
}

variable "public_network_access_enabled" {
  type    = bool
  default = false
}

variable "always_on" {
  type    = bool
  default = true
}

variable "https_only" {
  type    = bool
  default = true
}

variable "http2_enabled" {
  type    = bool
  default = true
}

variable "vnet_route_all_enabled" {
  type    = bool
  default = true
}

variable "websockets_enabled" {
  type    = bool
  default = false
}

variable "client_affinity_enabled" {
  type    = bool
  default = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the resource"
  default     = {}
}

variable "private_endpoints" {
  type = map(object({
    private_dns_zone_resource_id = string
    subnet_resource_id           = string
  }))
  description = "A map of private endpoints to create"
  default     = {}
}

variable "allowed_ips" {
  type    = map(string)
  default = {}
}

variable "log_analytics" {
  type = object({
    la_workspace_id   = string
    retention_in_days = optional(number, 90)
  })
  default = null
}

variable "action_group_id" {
  type        = string
  description = "Action Group to use when alerts are raised"
}