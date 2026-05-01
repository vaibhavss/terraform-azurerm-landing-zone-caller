# terraform-azurerm-landing-zone-caller

Composition repository for assembling the published Azure Terraform module repos into landing zone deployments.

## What this repo contains

- `modules/connectivity-core`: a composition module for the Phase 1 connectivity foundation.
- `environments/connectivity/dev`: a deployable root module for a dev connectivity environment.
- `config/connectivity/dev.yaml`: YAML-driven platform and environment values consumed by the dev root.

## Design notes

- Resource-focused modules stay in their own repositories.
- This caller repo assembles those modules into deployment compositions.
- The example environment loads YAML values with `yamldecode(...)` so the repo aligns with the landing-zone brief.
- Inline subnets are supported for cases where subnet lifecycle must stay coupled to the VNet, including route-table attachment.
- Standalone subnets are also supported for independently managed subnet lifecycles.

## Usage

```bash
cd environments/connectivity/dev
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
