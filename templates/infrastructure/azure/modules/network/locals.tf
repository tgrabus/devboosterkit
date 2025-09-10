locals {
  alphabet = split("", "abcdefghijklmnopqrstuvwxyz")
  alphabet_subnet_map = {
    for key, subnet in var.subnets : local.alphabet[subnet.idx] => key
  }
  subnet_prefixes = {
    for key, subnet in var.subnets : local.alphabet[subnet.idx] => subnet.cidr_range_size
  }
  subnet_address_prefix_map = {
    for key, address_prefix in module.cidr_calculator.address_prefixes : local.alphabet_subnet_map[key] => address_prefix
  }
}
