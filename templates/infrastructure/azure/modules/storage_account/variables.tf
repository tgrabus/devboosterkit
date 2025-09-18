
variable "stage" {
  type        = string
  description = "Stage the resource is provisioned"
}

variable "product" {
  type        = string
  description = "The product name this resource belongs to"
}

variable "instance" {
  type        = number
  description = "Environment instance for region"
}

variable "short_description" {
  description = "Optional short description of the resource"
  type        = string
  default     = null
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "storage_tier" {
  description = "Storage Account Tier (Standard, Premium)"
  type        = string
  default     = "Standard"
}

variable "replication_type" {
  description = "Storage Replication Type (LRS, GRS, ZRS, etc.)"
  type        = string
  default     = "LRS"
}

variable "storage_access_tier" {
  description = "Storage Access Tier (Hot, Cool)"
  type        = string
  default     = "Hot"
}

variable "enable_firewall" {
  description = "Enable firewall and restrict access to trusted networks"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is enabled"
  default     = false
}

variable "allow_nested_items_to_be_public" {
  type        = bool
  description = "Allow nested items (e.g., blobs) to be public"
  default     = false
}

variable "sftp_enabled" {
  type        = bool
  description = "Enable SFTP support on the Storage Account"
  default     = false
}

variable "allowed_ip_ranges" {
  description = "Map of allowed IPs when firewall is enabled"
  type        = map(string)
  default     = {}
}

variable "network_bypass" {
  type        = set(string)
  description = "Services that can bypass the network rules (e.g., AzureServices)"
  default     = ["AzureServices"]
}

variable "containers" {
  type = map(object({
    name          = string
    public_access = optional(string, "None")
  }))
  default     = {}
  description = <<DESCRIPTION
Map of storage containers to create within the Storage Account.

Map key is an arbitrary identifier. Each object supports:

- `name` - Name of the container to create.
- `public_access` - Optional. Public access level for the container. One of: "None", "Blob", or "Container". Defaults to "None".
DESCRIPTION
}

variable "private_endpoints" {
  type = map(object({
    private_dns_zone_resource_id = string
    subnet_resource_id           = string
    subresource_name             = string
    resource_group_name          = optional(string)
  }))
  default     = {}
  description = <<DESCRIPTION
A map of Private Endpoints to create for the Storage Account.

Map key is an arbitrary identifier. Each object supports:

- `private_dns_zone_resource_id` - Resource ID of the Private DNS Zone to link (e.g. .../privateDnsZones/privatelink.blob.core.windows.net). Use a zone appropriate for the subresource.
- `subnet_resource_id` - Resource ID of the subnet where the Private Endpoint will be created.
- `subresource_name` - The subresource to connect (e.g., "blob", "file", "queue", "table", or "dfs" for ADLS Gen2).
- `resource_group_name` - Optional. Target resource group name for the Private Endpoint resource. If omitted, module defaults are used.
DESCRIPTION
}

variable "roles" {
  type = map(object({
    role_definition_id_or_name = string
    principal_id               = string
  }))
  default     = {}
  description = <<DESCRIPTION
Map of role assignments to create for the Storage Account.

Map key is an arbitrary identifier. Each object supports:

- `role_definition_id_or_name` - The role to assign. Can be a built-in role name (e.g., "Storage Blob Data Contributor") or a role definition ID (GUID).
- `principal_id` - Object ID of the principal (user, group, or managed identity) that will receive the role assignment.
DESCRIPTION
}

variable "queues" {
  type = map(object({
    name = string
  }))
  default     = {}
  description = <<DESCRIPTION
Map of Storage Queues to create.

Map key is an arbitrary identifier. Each object supports:

- `name` - The name of the queue to create.
DESCRIPTION
}

variable "sftp_admins" {
  type = map(object({
    name       = string
    containers = list(string)
  }))
  default     = {}
  description = <<DESCRIPTION
Map of SFTP local users to create and grant container permissions.

Map key is an arbitrary identifier. Each object supports:

- `name` - The username for the local user.
- `containers` - List of container names the user should have access to.
DESCRIPTION
}

variable "allowed_copy_scope" {
  type        = string
  description = "Restrict copy operations to a specific scope (e.g., resource group or subscription)"
  default     = null
}

variable "default_to_oauth_authentication" {
  type        = bool
  description = "Default to OAuth (Azure AD) authentication when connecting to Storage resources"
  default     = true
}

variable "shared_access_key_enabled" {
  type        = bool
  description = "Enable Shared Key (Access Key) authentication for the Storage Account"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}