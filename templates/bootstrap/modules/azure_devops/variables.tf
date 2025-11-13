variable "organization_name" {
  type = string
}

variable "create_project" {
  type = bool
}

variable "project_name" {
  type = string
}

variable "environments" {
  type = map(object({
    environment_name = string
  }))
}

variable "pipelines" {
  type = map(object({
    pipeline_name           = string
    pipeline_file_name      = string
    environment_keys        = list(string)
    service_connection_keys = list(string)
  }))
}

variable "managed_identity_client_ids" {
  type = map(string)
}

variable "repository_name" {
  type = string
}

variable "repository_files" {
  type = map(object({
    content = string
  }))
}

variable "azure_tenant_id" {
  type = string
}

variable "azure_subscription_id" {
  type = string
}

variable "azure_subscription_name" {
  type = string
}

variable "backend_azure_resource_group_name" {
  type = string
}

variable "backend_azure_storage_account_name" {
  type = string
}

variable "agent_pool_name" {
  type = string
}