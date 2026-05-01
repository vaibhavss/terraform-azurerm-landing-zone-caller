locals {
  config = yamldecode(file("${path.module}/../../../config/connectivity/dev.yaml"))
}

module "connectivity_core" {
  source = "../../../modules/connectivity-core"

  common_tags        = try(local.config.common_tags, {})
  resource_group     = local.config.resource_group
  virtual_network    = local.config.virtual_network
  inline_subnets     = try(local.config.inline_subnets, {})
  standalone_subnets = try(local.config.standalone_subnets, {})
  route_table        = local.config.route_table
  routes             = try(local.config.routes, {})
}
