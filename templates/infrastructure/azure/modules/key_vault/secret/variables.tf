variable "name" {
  type = string
  description = "Secret name"
}

variable "value" {
  type    = string
  default = null
  description = "Secret value"
}

variable "key_vault_id" {
  type = string
  description = "Key Vault Id this secret belongs to"
}

variable "content_type" {
  type    = string
  default = "string"
  description = "Value type"
}

variable "ignore_value_changes" {
  type    = bool
  default = false
  description = "Whether to ignore value changes - useful when the value changes outside of terraform"
}

variable "expiration_date" {
  type    = string
  default = null
  description = "Secret expiration date"
}