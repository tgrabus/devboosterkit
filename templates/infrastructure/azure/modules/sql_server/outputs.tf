output "sql_server" {
  value = {
    name = module.server.resource.name
    fqdn = module.server.resource.fully_qualified_domain_name
  }
}