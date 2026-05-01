variable "common_tags" {
  description = "Tags applied across the connectivity composition."
  type        = map(string)
  default     = {}
}

variable "resource_group" {
  description = "Resource group configuration."
  type = object({
    name       = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  })
}

variable "virtual_network" {
  description = "Virtual network configuration."
  type = object({
    name          = string
    location      = optional(string)
    address_space = optional(list(string))
    bgp_community = optional(string)
    ddos_protection_plan = optional(object({
      id     = string
      enable = bool
    }))
    dns_servers = optional(list(string))
    edge_zone   = optional(string)
    encryption = optional(object({
      enforcement = string
    }))
    flow_timeout_in_minutes = optional(number)
    ip_address_pools = optional(list(object({
      id                     = string
      number_of_ip_addresses = string
    })))
    private_endpoint_vnet_policies = optional(string)
    tags                           = optional(map(string))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  })
}

variable "inline_subnets" {
  description = "Inline subnets that intentionally share lifecycle with the VNet. Set attach_route_table to true to bind them to the composed route table."
  type = map(object({
    name                                          = string
    address_prefixes                              = list(string)
    attach_route_table                            = optional(bool)
    route_table_id                                = optional(string)
    security_group                                = optional(string)
    default_outbound_access_enabled               = optional(bool)
    private_endpoint_network_policies             = optional(string)
    private_link_service_network_policies_enabled = optional(bool)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))
    delegation = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string))
      })
    })))
  }))
  default = {}
}

variable "standalone_subnets" {
  description = "Standalone subnets managed outside the VNet lifecycle."
  type = map(object({
    name                            = string
    address_prefixes                = optional(list(string))
    default_outbound_access_enabled = optional(bool)
    delegations = optional(list(object({
      name = string
      service_delegation = object({
        name    = string
        actions = optional(list(string))
      })
    })))
    ip_address_pool = optional(object({
      id                     = string
      number_of_ip_addresses = string
    }))
    private_endpoint_network_policies             = optional(string)
    private_link_service_network_policies_enabled = optional(bool)
    service_endpoints                             = optional(list(string))
    service_endpoint_policy_ids                   = optional(list(string))
    sharing_scope                                 = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

variable "route_table" {
  description = "Route table configuration."
  type = object({
    name                          = string
    location                      = optional(string)
    bgp_route_propagation_enabled = optional(bool)
    tags                          = optional(map(string))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  })
}

variable "routes" {
  description = "Routes to create in the route table."
  type = map(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}
