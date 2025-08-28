module "observability" {
  source = "../../modules/observability"
  instance = var.instance
  location = var.location
  stage = var.stage
  product = var.product
  short_description = "observability"
}