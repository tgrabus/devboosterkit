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

variable "tags" {
  type        = map(string)
  description = "Map of tags to apply"
  default     = {}
}