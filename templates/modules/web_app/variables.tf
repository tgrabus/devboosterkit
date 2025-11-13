variable "location" {
  type        = string
  description = "Azure region"
}

variable "stage" {
  type        = string
  description = "Stage the resource is provisioned"
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
  description = "Optional short description of the resource"
  default     = null
}

variable "resource_group_name" {
  type        = string
  description = "Resource group name"
}

variable "os_type" {
  type        = string
  description = "The operating system for the Web App (Windows or Linux)"
}

variable "service_plan_resource_id" {
  type        = string
  description = "Resource ID of the App Service Plan to host this Web App"
}

variable "virtual_network_subnet_id" {
  type        = string
  description = "Subnet resource ID for VNet integration"
}

variable "app_settings" {
  type        = map(string)
  description = "Key-value application settings to apply to the Web App"
  default     = {}
}

variable "app_stack" {
  type = object({
    dotnet_version      = optional(string)
    docker_registry_url = optional(string)
    docker_image_name   = optional(string)
  })
  description = <<DESCRIPTION
Application runtime stack configuration.

Each object supports:

- `dotnet_version` - Optional. .NET runtime version (e.g., "v8.0").
- `docker_registry_url` - Optional. Docker registry server URL for containerized apps.
- `docker_image_name` - Optional. Docker image name (optionally including tag), used when deploying a container.
DESCRIPTION
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is enabled"
  default     = false
}

variable "always_on" {
  type    = bool
  default = false
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
  description = "A mapping of tags to assign to the resource"
  default     = {}
}

variable "private_endpoints" {
  type = map(object({
    private_dns_zone_resource_id = string
    subnet_resource_id           = string
    resource_group_name          = optional(string)
  }))
  default     = {}
  description = <<DESCRIPTION
A map of Private Endpoints to create for the Web App.

Map key is an arbitrary identifier. Each object supports:

- `private_dns_zone_resource_id` - Resource ID of the Private DNS Zone to link (e.g. /subscriptions/<subId>/resourceGroups/<rg>/providers/Microsoft.Network/privateDnsZones/privatelink.azurewebsites.net).
- `subnet_resource_id` - Resource ID of the subnet where the Private Endpoint will be created.
- `resource_group_name` - Optional. Target resource group name for the Private Endpoint resource. If omitted, module defaults are used.
DESCRIPTION
}

variable "allowed_ips" {
  type        = map(string)
  description = "Map of allowed IPs when firewall is enabled"
  default     = {}
}

variable "application_insights" {
  type = object({
    la_workspace_id     = string
    retention_in_days   = optional(number, 90)
    resource_group_name = optional(string)
  })
  default = null
}

variable "action_group_id" {
  type        = string
  description = "Action Group to use when alerts are raised"
}