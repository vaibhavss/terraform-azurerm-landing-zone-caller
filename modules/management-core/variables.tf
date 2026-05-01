variable "common_tags" {
  description = "Tags applied across the management composition."
  type        = map(string)
  default     = {}
}

variable "resource_group" {
  description = "Management resource group configuration."
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

variable "public_dns_zones" {
  description = "Public DNS zones managed in the Management subscription."
  type = map(object({
    name = string
    soa_record = optional(object({
      email         = string
      expire_time   = optional(number)
      minimum_ttl   = optional(number)
      refresh_time  = optional(number)
      retry_time    = optional(number)
      serial_number = optional(number)
      ttl           = optional(number)
      tags          = optional(map(string))
    }))
    tags = optional(map(string))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default = {}
}

variable "private_dns_zones" {
  description = "Private DNS zones managed in the Management subscription, including optional virtual network links."
  type = map(object({
    name = string
    soa_record = optional(object({
      email        = string
      expire_time  = optional(number)
      minimum_ttl  = optional(number)
      refresh_time = optional(number)
      retry_time   = optional(number)
      ttl          = optional(number)
      tags         = optional(map(string))
    }))
    tags = optional(map(string))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
    virtual_network_links = optional(map(object({
      name                 = optional(string)
      virtual_network_id   = string
      registration_enabled = optional(bool)
      resolution_policy    = optional(string)
      tags                 = optional(map(string))
      timeouts = optional(object({
        create = optional(string)
        read   = optional(string)
        update = optional(string)
        delete = optional(string)
      }))
    })))
  }))
  default = {}
}
