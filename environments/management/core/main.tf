locals {
  config = yamldecode(file("${path.module}/../../../config/management/core.yaml"))
}

module "management_core" {
  source = "../../../modules/management-core"

  common_tags       = try(local.config.common_tags, {})
  resource_group    = local.config.resource_group
  public_dns_zones  = try(local.config.public_dns_zones, {})
  private_dns_zones = try(local.config.private_dns_zones, {})
}
