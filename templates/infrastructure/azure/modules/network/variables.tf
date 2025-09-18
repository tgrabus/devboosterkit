variable "stage" {
  type        = string
  description = "Stage the resource is provisioned"
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

variable "address_space" {

  type        = string
  description = "Address space in CIDR format"
}

variable "subnets" {
  type = map(object({
    cidr_range_size = number
    idx             = number
    nsg_rules = optional(list(object({
      name                    = string
      protocol                = string
      source                  = string
      destination_port_ranges = list(string)
    })), [])
    delegations = optional(list(object({
      name    = string
      service = string
    })), [])
  }))
  description = <<DESCRIPTION
Map of subnets to create and their settings.

Map key is an arbitrary identifier. Each subnet object supports:

- `cidr_range_size` - The size (mask bits) used to derive the subnet CIDR from the VNet address space.
- `idx` - Index used to generate the subnet address prefix within the VNet address space.
- `nsg_rules` - Optional list of NSG rules to attach to this subnet. Each rule supports:
  - `name` - Rule name.
  - `protocol` - Network protocol (e.g., Tcp, Udp, or "*").
  - `source` - Source address prefix or tag (e.g., AzureLoadBalancer, Internet, 10.0.0.0/24).
  - `destination_port_ranges` - List of destination port ranges (e.g., ["80", "443"]).
- `delegations` - Optional list of service delegations for this subnet. Each delegation supports:
  - `name` - Delegation name.
  - `service` - Service to delegate to (e.g., Microsoft.Web/serverFarms).
DESCRIPTION
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
  default     = {}
}