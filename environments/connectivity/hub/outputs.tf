output "resource_group_name" {
  description = "Connectivity resource group name."
  value       = module.connectivity_core.resource_group.name
}

output "virtual_network_id" {
  description = "Connectivity virtual network ID."
  value       = module.connectivity_core.virtual_network.id
}

output "route_table_id" {
  description = "Connectivity route table ID."
  value       = module.connectivity_core.route_table.id
}

output "standalone_subnet_ids" {
  description = "Standalone subnet IDs."
  value       = module.connectivity_core.standalone_subnet_ids
}
