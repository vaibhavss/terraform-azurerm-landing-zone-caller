output "resource_group_name" {
  description = "Management resource group name."
  value       = module.management_core.resource_group.name
}

output "public_dns_zone_ids" {
  description = "Public DNS zone IDs."
  value       = module.management_core.public_dns_zone_ids
}

output "private_dns_zone_ids" {
  description = "Private DNS zone IDs."
  value       = module.management_core.private_dns_zone_ids
}

output "private_dns_zone_link_ids" {
  description = "Private DNS zone virtual network link IDs."
  value       = module.management_core.private_dns_zone_link_ids
}
