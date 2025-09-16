locals {
  action_groups = {
    default = {
      email_receivers = var.email_receivers
    }
  }
}

module "observability" {
  source              = "../../modules/observability"
  instance            = var.instance
  location            = var.location
  stage               = var.stage
  product             = var.product
  short_description   = "observability"
  resource_group_name = module.resource_groups[local.resource_groups.observability].name
  action_groups       = local.action_groups
  tags                = local.tags
}