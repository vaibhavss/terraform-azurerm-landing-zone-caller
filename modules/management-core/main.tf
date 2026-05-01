locals {
  resource_group_tags = merge(var.common_tags, try(var.resource_group.tags, {}))
}

module "resource_group" {
  source = "git::https://github.com/vaibhavss/terraform-azurerm-resource-group.git?ref=main"

  name       = var.resource_group.name
  location   = var.resource_group.location
  managed_by = try(var.resource_group.managed_by, null)
  tags       = local.resource_group_tags
  timeouts   = try(var.resource_group.timeouts, null)
}

module "public_dns_zones" {
  for_each = var.public_dns_zones
  source   = "git::https://github.com/vaibhavss/terraform-azurerm-dns-zone.git?ref=main"

  name                = each.value.name
  resource_group_name = module.resource_group.name
  soa_record          = try(each.value.soa_record, null)
  tags                = merge(var.common_tags, try(each.value.tags, {}))
  timeouts            = try(each.value.timeouts, null)
}

module "private_dns_zones" {
  for_each = var.private_dns_zones
  source   = "git::https://github.com/vaibhavss/terraform-azurerm-private-dns-zone.git?ref=main"

  name                = each.value.name
  resource_group_name = module.resource_group.name
  soa_record          = try(each.value.soa_record, null)
  tags                = merge(var.common_tags, try(each.value.tags, {}))
  virtual_network_links = {
    for link_key, zone_link in try(each.value.virtual_network_links, {}) : link_key => merge(zone_link, {
      tags = merge(var.common_tags, try(each.value.tags, {}), try(zone_link.tags, {}))
    })
  }
  timeouts = try(each.value.timeouts, null)
}
