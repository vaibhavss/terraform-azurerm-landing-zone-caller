# connectivity-core

Composition module for the Phase 1 connectivity foundation.

## What it assembles

- Resource group
- Virtual network
- Optional inline subnets
- Optional standalone subnets
- Route table
- Optional routes

## Notes

- Inline subnets can set `attach_route_table = true` to associate with the route table created by this composition.
- Standalone subnets remain independent from the VNet lifecycle, but route-table association is not yet available because there is no dedicated subnet-route-table-association module in the published module set.
