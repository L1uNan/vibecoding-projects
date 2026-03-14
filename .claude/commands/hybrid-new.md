---
description: Start a new Hybrid workflow change
---

Start a new Hybrid workflow change with flexible mode selection.

## Input

- Change name (kebab-case) or description
- Optional: `--mode` flag (`quick` | `explore` | `structured`)

## Steps

1. If no input, ask what to build and request a kebab-case change name.
2. Create change skeleton under `openspec/changes/<name>/`:
   - `openspec/changes/<name>/specs/`
   - required tracking files: `task_plan.md`, `findings.md`, `progress.md`
   - artifacts: `proposal.md`, `design.md`, `tasks.md`
3. Set active change:
   - write `<name>` to `openspec/.active`
4. Initialize `task_plan.md` with:
   - Phase: `init`
   - Goals (from user request)
   - Decisions (empty section)
   - Progress: 0%
   - Errors table for 3-Strike protocol
5. Append a log entry to `progress.md`.
6. Show mode-specific next step:
   - `quick` -> `/hybrid-ff`
   - `explore` -> `/hybrid-explore`
   - `structured` -> `/hybrid-continue`
7. Enforce source requirements from `openspec/config.yaml`:
   - all artifacts in Simplified Chinese
   - `proposal.md` within 500 Chinese characters
   - `design.md` must include architecture diagram

## Shell helpers (optional)

```bash
NAME="<change-name>"
mkdir -p "openspec/changes/$NAME/specs"
printf "%s\n" "$NAME" > openspec/.active
for f in task_plan.md findings.md progress.md proposal.md design.md tasks.md; do : > "openspec/changes/$NAME/$f"; done
```
