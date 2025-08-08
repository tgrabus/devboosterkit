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

variable "private_connection_resource_id" {
  type        = string
  description = "Resource ID of the resource to connect to"
}

variable "subnet_resource_id" {
  type        = string
  description = "Resource ID of the subnet where the private endpoint will be created"
}

variable "subresource_name" {
  type        = string
  description = "Name of the subresource to connect to"
}

variable "private_dns_zone_resource_id" {
  type        = string
  description = "Resource ID of the private DNS zone to link with the private endpoint"
  default     = null
  
}