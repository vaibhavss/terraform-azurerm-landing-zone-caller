# terraform-azurerm-landing-zone-caller

Composition repository for assembling the published Azure Terraform module repos into landing zone deployments.

## What this repo contains

- `modules/connectivity-core`: a composition module for the Phase 1 connectivity foundation.
- `environments/connectivity/hub`: a deployable root module for the shared connectivity hub.
- `config/connectivity/hub.yaml`: YAML-driven platform values consumed by the hub root.

## Design notes

- Resource-focused modules stay in their own repositories.
- This caller repo assembles those modules into deployment compositions.
- The hub root loads YAML values with `yamldecode(...)` so the repo aligns with the landing-zone brief.
- Inline subnets are supported for cases where subnet lifecycle must stay coupled to the VNet, including route-table attachment.
- Standalone subnets are also supported for independently managed subnet lifecycles.
- The connectivity hub is modeled as a single shared platform stack, not as a dev/nonprod/prod environment split.

## Usage

```bash
cd environments/connectivity/hub
terraform init
terraform plan
```

## Current GitHub module sources

- `vaibhavss/terraform-azurerm-resource-group`
- `vaibhavss/terraform-azurerm-virtual-network`
- `vaibhavss/terraform-azurerm-subnet`
- `vaibhavss/terraform-azurerm-route-table`
- `vaibhavss/terraform-azurerm-route`

The composition module currently references these repos with `?ref=main`. Replace those with version tags once you start releasing module versions.
