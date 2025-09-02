output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = module.vnet.resource_id
}

output "vnet_name" {
  value = module.vnet.name
}

output "resource_group_name" {
  value = module.resource_group.name
}

output "subnets" {
  description = "Information about the subnets created"
  value = { for key, subnet in module.subnets : key => {
    id   = subnet.resource_id
    name = subnet.name
  } }
}