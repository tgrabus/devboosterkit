module "this" {
  source              = "Azure/avm-res-containerinstance-containergroup/azurerm"
  version             = "0.2.0"
  location            = var.location
  name                = module.naming.result
  os_type             = "Linux"
  resource_group_name = var.resource_group_name
  restart_policy      = "Always"
  zones               = var.zones
  subnet_ids          = [var.subnet_id]

  image_registry_credential = {
    for key, value in var.containers : key => {
      user_assigned_identity_id = module.managed_identity.resource_id
      server                    = value.server
    }
  }

  managed_identities = {
    user_assigned_resource_ids = [module.managed_identity.resource_id]
  }

  containers = {
    for key, value in var.containers : key => {
      image                        = "${value.server}/${value.image_name}:${value.image_tag}"
      cpu                          = value.cpu
      memory                       = value.memory
      ports                        = value.ports
      environment_variables        = var.environment_vars
      secure_environment_variables = var.secure_environment_vars
      volumes                      = {}
    }
  }

  tags = var.tags
  depends_on = [module.managed_identity]
}