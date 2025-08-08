locals {
  resource_groups = {
   networking = {}
   apps = {}
  }
}

module "resource_groups" {
  source = "../../../../../../templates/azure/terraform/modules"

}