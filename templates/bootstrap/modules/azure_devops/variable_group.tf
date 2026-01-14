resource "azuredevops_variable_group" "environments" {
  for_each = var.environments

  project_id   = local.project_id
  name         = each.value.environment_name
  description  = "Var groups for ${each.value.environment_name} environment"
  allow_access = true

  variable {
    name  = "BACKEND_AZURE_RESOURCE_GROUP_NAME"
    value = var.backend_azure_resource_group_name
  }

  variable {
    name  = "BACKEND_AZURE_STORAGE_ACCOUNT_NAME"
    value = var.backend_azure_storage_account_name
  }

  variable {
    name  = "BACKEND_AZURE_STORAGE_ACCOUNT_CONTAINER_NAME"
    value = each.value.environment_name
  }

  variable {
    name  = "BACKEND_AZURE_STORAGE_ACCOUNT_CONTAINER_KEY_NAME"
    value = "terraform.tfstate"
  }
}

