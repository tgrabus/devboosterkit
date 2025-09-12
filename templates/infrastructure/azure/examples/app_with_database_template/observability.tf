module "observability" {
  source            = "../../modules/observability"
  instance          = var.instance
  location          = var.location
  stage             = var.stage
  product           = var.product
  short_description = "observability"
  action_groups = local.action_groups
}