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
  description = "Map of subnets to create and their settings"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be applied to the resource"
  default     = {}
}