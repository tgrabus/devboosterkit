locals {
  target_subscriptions = { for subscription_id in distinct([var.subscription_id_dev, var.subscription_id_production, var.bootstrap_subscription_id]) : subscription_id => subscription_id }
}

locals {
  agent_pool_configuration = "name: ${module.azure_devops.agent_pool_name}"
}

locals {
  environments = {
    dev = {
      environment_name = "development"
      subscription_id  = var.subscription_id_dev
    }
    prod = {
      environment_name = "production"
      subscription_id  = var.subscription_id_production
    }
  }
}

locals {
  user_assigned_managed_identities = { for key, value in local.environments : key => {
    role_assignments = merge(
      {
        subscription = {
          role_name = "Contributor"
          scope     = data.azurerm_subscription.all[value.subscription_id].id
        }
      },
      var.bootstrap_subscription_id != value.subscription_id ?
      {
        bootstrap = {
          role_name = "Reader"
          scope     = data.azurerm_subscription.all[var.bootstrap_subscription_id].id
        }
      } : {}
    )
  } }

  federated_credentials = { for key, value in local.environments : key => {
    federated_credential_subject = module.azure_devops.service_connections[key].subject
    federated_credential_issuer  = module.azure_devops.service_connections[key].issuer
  } }
}

locals {
  agent_container_instances = {
    agent01 = {
      cpu    = var.agent_container_cpu
      memory = var.agent_container_memory
      zones  = var.agent_container_zone_support ? ["1"] : []
    }
    agent02 = {
      cpu    = var.agent_container_cpu
      memory = var.agent_container_memory
      zones  = var.agent_container_zone_support ? ["2"] : []
    }
  }

  agent_container_instance_dockerfile_url = "${var.agent_container_image_repository}#${var.agent_container_image_tag}:${var.agent_container_image_folder}"
}

locals {
  modules_directory_path = "${path.module}/../../modules"
  modules_files = { for key, value in fileset(local.modules_directory_path, "**") : "modules/${key}" =>
    {
      content = file("${local.modules_directory_path}/${key}")
    } if !endswith(key, ".tfstate") && !endswith(key, ".auto.tfvars") &&
    !endswith(key, ".tfstate.backup") && !can(regex("\\.terraform/", key))
  }

  example_directory_path = "${path.module}/../../examples/app_with_storage"
  example_files = { for key, value in fileset(local.example_directory_path, "**") : "examples/app_with_storage/${key}" =>
    {
      content = file("${local.example_directory_path}/${key}")
    } if !endswith(key, ".tfstate") && !endswith(key, ".auto.tfvars") &&
    !endswith(key, ".tfstate.backup") && !can(regex("\\.terraform/", key))
  }

  repository_files = merge(local.modules_files, local.example_files)

  pipelines = {}
}
