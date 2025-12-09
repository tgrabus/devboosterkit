variable "subscription_id_dev" {
  description = "The identifier of the dev Subscription"
  type        = string
  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.subscription_id_dev))
    error_message = "The dev subscription ID must be a valid GUID"
  }
}

variable "subscription_id_production" {
  description = "The identifier of the production Subscription"
  type        = string
  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.subscription_id_production))
    error_message = "The production subscription ID must be a valid GUID"
  }
}

variable "bootstrap_subscription_id" {
  description = "Azure Subscription ID for the bootstrap resources (e.g. storage account, identities, etc). Leave empty to use the az login subscription"
  type        = string
  default     = ""
  validation {
    condition     = var.bootstrap_subscription_id == "" ? true : can(regex("^[0-9a-fA-F-]{36}$", var.bootstrap_subscription_id))
    error_message = "The bootstrap subscription ID must be a valid GUID"
  }
}

variable "bootstrap_location" {
  description = "Azure Deployment location for the bootstrap resources (e.g. storage account, identities, etc)"
  type        = string
}

variable "azure_devops_organization_name" {
  description = "The name of your Azure DevOps organization."
  type        = string
}

variable "azure_devops_create_project" {
  description = "Create the Azure DevOps project if it does not exist"
  type        = bool
  default     = true
}

variable "azure_devops_project_name" {
  description = "The name of the Azure DevOps project"
  type        = string
}

variable "azure_devops_personal_access_token" {
  description = "The personal access token for Azure DevOps"
  type        = string
  sensitive   = true
}

variable "azure_devops_agents_personal_access_token" {
  description = "Personal access token for Azure DevOps self-hosted agents"
  type        = string
  sensitive   = true
  default     = ""
}

variable "use_private_networking" {
  description = "Controls whether to use private networking for the agent to storage account communication"
  type        = bool
  default     = true
}

variable "agent_container_image_repository" {
  description = "The container image repository to use for Azure DevOps Agents"
  type        = string
  default     = "https://github.com/Azure/avm-container-images-cicd-agents-and-runners"
}

variable "agent_container_image_folder" {
  description = "The folder containing the Dockerfile for the container image"
  type        = string
  default     = "azure-devops-agent-aci"
}

variable "agent_container_image_dockerfile" {
  description = "The Dockerfile to use for the container image"
  type        = string
  default     = "Dockerfile"
}

variable "agent_container_image_tag" {
  description = "The container image tag to use for Azure DevOps Agents"
  type        = string
  default     = "57a937f"
}

variable "agent_container_image_name" {
  description = "The container image name to use for Azure DevOps Agents"
  type        = string
  default     = "azure-devops-agent"
}

variable "agent_container_cpu" {
  description = "The container cpu default"
  type        = number
  default     = 2
}

variable "agent_container_memory" {
  description = "The container memory default"
  type        = number
  default     = 4
}

variable "agent_container_zone_support" {
  description = "The container zone support"
  type        = bool
  default     = true
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

variable "agent_pool_name" {
  type        = string
  description = "Agent pool name"
  default     = "Sample"
}

variable "version_control_repository_name" {
  type        = string
  description = "Repository name for holding project files"
  default     = "Sample"
}

variable "allow_access_from_my_ip" {
  type    = bool
  default = true
}