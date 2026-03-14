---
description: Hybrid workflow (OpenSpec + tracking) overview
---

Hybrid workflow combines OpenSpec artifacts with mandatory tracking.

## Usage

- Quick mode (clear requirements):
  - `/hybrid-new <name> --mode quick`
  - `/hybrid-ff`
  - `/hybrid-apply`
  - `/hybrid-archive`

- Explore mode (unclear requirements):
  - `/hybrid-explore`
  - `/hybrid-new <name> --mode explore`
  - `/hybrid-continue`
  - `/hybrid-apply`
  - `/hybrid-archive`

- Structured mode (large features):
  - `/hybrid-new <name> --mode structured`
  - `/hybrid-continue` (proposal)
  - `/hybrid-continue` (design)
  - `/hybrid-continue` (specs)
  - `/hybrid-continue` (tasks)
  - `/hybrid-apply`
  - `/hybrid-verify`
  - `/hybrid-archive`

## Key rule

Tracking is mandatory: every change must have `task_plan.md`, `findings.md`, `progress.md`.

## Source of truth

- `openspec/config.yaml`
- `openspec/schemas/hybrid-workflow/schema.yaml`

