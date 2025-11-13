locals {
  acr = {
    tasks = {
      agent_image_build = {
        name                             = "agent-image-build-task"
        dockerfile_repository_folder_url = var.container_registry_dockerfile_repository
        dockerfile_name                  = var.container_registry_dockerfile_name
        access_token                     = "default"
        image_name                       = var.container_registry_image_name
        image_tag                        = var.container_registry_image_tag
      }
    }

    private_endpoints = {
      acr = {
        private_dns_zone_resource_id = azurerm_private_dns_zone.pdz["azure_acr"].id
        subnet_resource_id           = module.cicd_vnet.subnets["private_endpoints"].id
      }
    }
  }
}

module "acr" {
  source                     = "../../../modules/acr"
  instance                   = var.instance
  location                   = var.location
  stage                      = var.stage
  product                    = var.product
  resource_group_name        = module.resource_groups["acr"].name
  private_networking_enabled = var.use_private_networking
  tasks                      = local.acr.tasks
  private_endpoints          = local.acr.private_endpoints
  tags                       = local.tags
}