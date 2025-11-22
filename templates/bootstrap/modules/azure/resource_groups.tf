locals {
  resource_groups = {
    state    = "state"
    agents   = "agents"
    identity = "identity"
    vnet     = "cicd"
    acr      = "acr"
  }
}


module "resource_groups" {
  for_each          = local.resource_groups
  source            = "../../../modules/resource_group"
  instance          = var.instance
  location          = var.location
  stage             = var.stage
  product           = var.product
  short_description = each.key
  tags              = local.tags
}