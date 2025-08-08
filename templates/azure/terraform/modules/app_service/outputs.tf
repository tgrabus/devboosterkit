output "resource_id" {
  value = module.avm_res_web_site.resource_id
}

output "name" {
  value = module.avm_res_web_site.name
}

output "resource_group_name" {
  value = module.avm_res_web_site.resource.resource_group_name
}

output "location" {
  value = module.avm_res_web_site.location
}

output "uri" {
  value = "https://${module.avm_res_web_site.resource.default_hostname}"
}

output "default_hostname" {
  value = module.avm_res_web_site.resource_uri
}

output "private_endpoints" {
  value = module.avm_res_web_site.resource_private_endpoints
}