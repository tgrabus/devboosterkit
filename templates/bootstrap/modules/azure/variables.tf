variable "location" {
  type        = string
  description = "Azure region for environment resources"
}

variable "stage" {
  type        = string
  description = "Deployment stage"
  default     = "mgmt"
}

variable "instance" {
  type        = number
  default     = 1
  description = "Instance of environment"
}

variable "product" {
  type        = string
  description = "alz"
  default     = "alz"
}

variable "environments" {
  type = map(object({
    environment_name = string
  }))
}

variable "user_assigned_managed_identities" {
  type = map(object({
    role_assignments = optional(map(object({
      role_name = string
      scope     = string
    })))
  }))
}

variable "federated_credentials" {
  type = map(object({
    federated_credential_subject = string
    federated_credential_issuer  = string
  }))
  default = {}
}

variable "agent_container_instances" {
  type = map(object({
    cpu    = optional(number, 4)
    memory = optional(number, 16)
    zones  = optional(set(string), [])
  }))
  default = {}
}

variable "agent_organization_url" {
  type    = string
  default = ""
}

variable "agent_token" {
  type      = string
  sensitive = true
  default   = ""
}

variable "agent_pool_name" {
  type    = string
  default = ""
}

variable "virtual_network_address_space" {
  type        = string
  description = "The address space for the virtual network"
  default     = "10.0.0.0/24"
}

variable "virtual_network_subnet_address_prefix_container_instances" {
  type        = string
  description = "Address prefix for the virtual network subnet"
  default     = "10.0.0.0/26"
}

variable "virtual_network_subnet_address_prefix_private_endpoints" {
  type        = string
  description = "Address prefix for the virtual network subnet"
  default     = "10.0.0.64/26"
}

variable "use_private_networking" {
  description = "Controls whether to use private networking for the runner to storage account and runner to container registry communication"
  type        = bool
  default     = true
}

variable "container_registry_dockerfile_repository" {
  type        = string
  description = "The branch and folder of the repository containing the Dockerfile"
  default     = ""
}

variable "container_registry_dockerfile_name" {
  type        = string
  description = "The dockerfile to build"
  default     = "dockerfile"
}

variable "container_registry_image_name" {
  type        = string
  description = "The name of the image to build"
  default     = ""
}

variable "container_registry_image_tag" {
  type        = string
  description = "The pattern for the image tag"
  default     = "{{.Run.ID}}"
}

variable "resource_providers" {
  type        = set(string)
  description = "The resource providers to register"
  nullable    = false
  default = [
    "Microsoft.Authorization",
    "Microsoft.Automation",
    "Microsoft.Compute",
    "Microsoft.ContainerInstance",
    "Microsoft.ContainerRegistry",
    "Microsoft.ContainerService",
    "Microsoft.CostManagement",
    "Microsoft.CustomProviders",
    "Microsoft.DataProtection",
    "microsoft.insights",
    "Microsoft.Maintenance",
    "Microsoft.ManagedIdentity",
    "Microsoft.ManagedServices",
    "Microsoft.Management",
    "Microsoft.Network",
    "Microsoft.OperationalInsights",
    "Microsoft.OperationsManagement",
    "Microsoft.PolicyInsights",
    "Microsoft.RecoveryServices",
    "Microsoft.Resources",
    "Microsoft.Security",
    "Microsoft.SecurityInsights",
    "Microsoft.Storage",
    "Microsoft.StreamAnalytics"
  ]
}

variable "target_subscriptions" {
  type = map(string)
}

variable "allowed_ips" {
  type    = map(string)
  default = {}
}