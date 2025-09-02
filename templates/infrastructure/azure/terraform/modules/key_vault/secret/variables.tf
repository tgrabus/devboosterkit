variable "name" {
  type = string
}

variable "value" {
  type    = string
  default = null
}

variable "key_vault_id" {
  type = string
}

variable "content_type" {
  type    = string
  default = "string"
}

variable "ignore_value_changes" {
  type    = bool
  default = false
}

variable "expiration_date" {
  type    = string
  default = null
}