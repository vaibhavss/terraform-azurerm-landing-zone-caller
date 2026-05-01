output "resource_group" {
  description = "Resource group outputs."
  value = {
    id       = module.resource_group.id
    name     = module.resource_group.name
    location = module.resource_group.location
  }
}

output "virtual_network" {
  description = "Virtual network outputs."
  value = {
    id            = module.virtual_network.id
    name          = module.virtual_network.name
    address_space = module.virtual_network.address_space
    subnets       = module.virtual_network.subnets
  }
}

output "route_table" {
  description = "Route table outputs."
  value = {
    id   = module.route_table.id
    name = module.route_table.name
  }
}

output "standalone_subnet_ids" {
  description = "Standalone subnet IDs keyed by subnet map key."
  value = {
    for key, subnet in module.standalone_subnets : key => subnet.id
  }
}

output "route_ids" {
  description = "Route IDs keyed by route map key."
  value = {
    for key, route in module.routes : key => route.id
  }
}
