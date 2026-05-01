output "resource_group" {
  description = "Management resource group outputs."
  value = {
    id       = module.resource_group.id
    name     = module.resource_group.name
    location = module.resource_group.location
  }
}

output "public_dns_zone_ids" {
  description = "Public DNS zone IDs keyed by zone map key."
  value = {
    for key, zone in module.public_dns_zones : key => zone.id
  }
}

output "private_dns_zone_ids" {
  description = "Private DNS zone IDs keyed by zone map key."
  value = {
    for key, zone in module.private_dns_zones : key => zone.id
  }
}

output "private_dns_zone_link_ids" {
  description = "Private DNS zone virtual network link IDs keyed by zone/link map key."
  value = {
    for zone_key, zone in module.private_dns_zones :
    zone_key => zone.virtual_network_link_ids
  }
}
