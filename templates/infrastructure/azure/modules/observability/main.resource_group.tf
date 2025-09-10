module "resource_group" {
  source            = "../resource_group"
  instance          = var.instance
  location          = var.location
  stage             = var.stage
  product           = var.product
  short_description = var.short_description
}