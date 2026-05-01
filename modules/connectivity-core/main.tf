locals {
  resource_group_tags  = merge(var.common_tags, try(var.resource_group.tags, {}))
  virtual_network_tags = merge(var.common_tags, try(var.virtual_network.tags, {}))
  route_table_tags     = merge(var.common_tags, try(var.route_table.tags, {}))

  inline_subnet_values = [
    for subnet in values(var.inline_subnets) : {
      name                                          = subnet.name
      address_prefixes                              = subnet.address_prefixes
      security_group                                = try(subnet.security_group, null)
      default_outbound_access_enabled               = try(subnet.default_outbound_access_enabled, null)
      private_endpoint_network_policies             = try(subnet.private_endpoint_network_policies, null)
      private_link_service_network_policies_enabled = try(subnet.private_link_service_network_policies_enabled, null)
      route_table_id                                = try(subnet.route_table_id, null) != null ? subnet.route_table_id : try(subnet.attach_route_table, false) ? module.route_table.id : null
      service_endpoints                             = try(subnet.service_endpoints, null)
      service_endpoint_policy_ids                   = try(subnet.service_endpoint_policy_ids, null)
      delegation                                    = try(subnet.delegation, null)
    }
  ]
}

module "resource_group" {
  source = "git::https://github.com/vaibhavss/terraform-azurerm-resource-group.git?ref=main"

  name       = var.resource_group.name
  location   = var.resource_group.location
  managed_by = try(var.resource_group.managed_by, null)
  tags       = local.resource_group_tags
  timeouts   = try(var.resource_group.timeouts, null)
}

module "route_table" {
  source = "git::https://github.com/vaibhavss/terraform-azurerm-route-table.git?ref=main"

  name                          = var.route_table.name
  location                      = try(var.route_table.location, null) != null ? var.route_table.location : module.resource_group.location
  resource_group_name           = module.resource_group.name
  bgp_route_propagation_enabled = try(var.route_table.bgp_route_propagation_enabled, null)
  tags                          = local.route_table_tags
  timeouts                      = try(var.route_table.timeouts, null)
}

module "virtual_network" {
  source = "git::https://github.com/vaibhavss/terraform-azurerm-virtual-network.git?ref=main"

  name                           = var.virtual_network.name
  resource_group_name            = module.resource_group.name
  location                       = try(var.virtual_network.location, null) != null ? var.virtual_network.location : module.resource_group.location
  address_space                  = try(var.virtual_network.address_space, null)
  bgp_community                  = try(var.virtual_network.bgp_community, null)
  ddos_protection_plan           = try(var.virtual_network.ddos_protection_plan, null)
  dns_servers                    = try(var.virtual_network.dns_servers, null)
  edge_zone                      = try(var.virtual_network.edge_zone, null)
  encryption                     = try(var.virtual_network.encryption, null)
  flow_timeout_in_minutes        = try(var.virtual_network.flow_timeout_in_minutes, null)
  ip_address_pools               = try(var.virtual_network.ip_address_pools, [])
  private_endpoint_vnet_policies = try(var.virtual_network.private_endpoint_vnet_policies, null)
  subnets                        = local.inline_subnet_values
  tags                           = local.virtual_network_tags
  timeouts                       = try(var.virtual_network.timeouts, null)
}

module "standalone_subnets" {
  for_each = var.standalone_subnets
  source   = "git::https://github.com/vaibhavss/terraform-azurerm-subnet.git?ref=main"

  name                                          = each.value.name
  resource_group_name                           = module.resource_group.name
  virtual_network_name                          = module.virtual_network.name
  address_prefixes                              = try(each.value.address_prefixes, null)
  default_outbound_access_enabled               = try(each.value.default_outbound_access_enabled, null)
  delegations                                   = try(each.value.delegations, [])
  ip_address_pool                               = try(each.value.ip_address_pool, null)
  private_endpoint_network_policies             = try(each.value.private_endpoint_network_policies, null)
  private_link_service_network_policies_enabled = try(each.value.private_link_service_network_policies_enabled, null)
  service_endpoints                             = try(each.value.service_endpoints, null)
  service_endpoint_policy_ids                   = try(each.value.service_endpoint_policy_ids, null)
  sharing_scope                                 = try(each.value.sharing_scope, null)
  timeouts                                      = try(each.value.timeouts, null)
}

module "routes" {
  for_each = var.routes
  source   = "git::https://github.com/vaibhavss/terraform-azurerm-route.git?ref=main"

  name                   = each.value.name
  resource_group_name    = module.resource_group.name
  route_table_name       = module.route_table.name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = try(each.value.next_hop_in_ip_address, null)
  timeouts               = try(each.value.timeouts, null)
}
