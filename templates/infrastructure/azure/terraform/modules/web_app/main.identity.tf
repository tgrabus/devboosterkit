module "managed_identity" {
  source              = "../managed_identity"
  instance            = var.instance
  location            = var.location
  stage               = var.stage
  product = var.product
  short_description   = var.short_description
  resource_group_name = var.resource_group_name
}