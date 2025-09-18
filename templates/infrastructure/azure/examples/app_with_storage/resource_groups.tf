locals {
  resource_groups = {
    observability     = "observability"
    vnet              = "vnet"
    sql               = "sql"
    app               = "app"
    private_dns_zones = "private_dns_zones"
  }
}

module "resource_groups" {
  for_each          = local.resource_groups
  source            = "../../modules/resource_group"
  instance          = var.instance
  location          = var.location
  stage             = var.stage
  product           = var.product
  short_description = each.key
  tags              = local.tags
}
