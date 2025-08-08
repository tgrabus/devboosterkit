locals {
  instance = format("%02d", var.instance)

  stage_map = {
    development   = "dv"
    qualification = "qa"
    sandbox       = "sb"
    production    = "pd"
  }

  stage   = lookup(local.stage_map, var.stage, var.stage)

  name_suffixes = compact([
    local.stage,
    module.azure_location.short_name,
    var.product,
    var.short_description,
    local.instance
  ])
}