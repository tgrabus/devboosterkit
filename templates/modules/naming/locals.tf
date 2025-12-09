locals {
  instance = format("%02d", var.instance)

  stage_map = {
    development = "dv"
    qa          = "qa"
    staging     = "st"
    production  = "pd"
  }

  stage = lookup(local.stage_map, var.stage, var.stage)

  name_suffixes = compact([
    var.product,
    local.stage,
    module.azure_location.short_name,
    local.instance,
    var.short_description
  ])
}