# management-core

Composition module for the Management subscription's DNS responsibilities.

## What it assembles

- Resource group
- Public DNS zones
- Private DNS zones together with their virtual network links

## Notes

- This module implements the confirmed management requirement from the brief: centralize DNS zones in the Management subscription.
- Private DNS zone links are modeled as nested configuration under each private DNS zone so the zone and its links share the same lifecycle.
- Governance, policy, monitoring, and alerting resources are intentionally left out until those decisions are confirmed.
