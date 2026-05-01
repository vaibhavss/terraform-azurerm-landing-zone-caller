# management-core

Composition module for the Management subscription's DNS responsibilities.

## What it assembles

- Resource group
- Public DNS zones
- Private DNS zones
- Private DNS zone virtual network links

## Notes

- This module implements the confirmed management requirement from the brief: centralize DNS zones in the Management subscription.
- Private DNS zone links are modeled as nested configuration under each private DNS zone so hub and spoke linkage can be declared explicitly.
- Governance, policy, monitoring, and alerting resources are intentionally left out until those decisions are confirmed.
