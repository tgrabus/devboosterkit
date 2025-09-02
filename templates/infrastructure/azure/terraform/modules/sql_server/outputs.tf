output "pools" {
  value = module.elastic_pool
}

output "sql_server" {
  value = {
    name = module.sql_server.resource.name
    fqdn = module.sql_server.resource.fully_qualified_domain_name
  }
}