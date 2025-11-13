locals {
  subnets_with_nat_gateway_enabled = { for key, subnet in var.subnets : key => subnet if subnet.nat_gateway_enabled }
}
