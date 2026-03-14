---
description: Show hybrid workflow status
---

Show current hybrid workflow status and tracking layer progress.

## Steps

1. Read active change from `openspec/.active`.
2. Summarize:
   - Current phase and progress (from `task_plan.md`)
   - Recent activity (from `progress.md`)
   - Artifact presence: `proposal.md`, `design.md`, `specs/`, `tasks.md`
   - Tasks completion count (from `tasks.md`, if present)
3. Output the next recommended command:
   - missing artifacts -> `/hybrid-continue`
   - tasks exist -> `/hybrid-apply`
   - all tasks done -> `/hybrid-verify` then `/hybrid-archive`

If there is no active change, instruct to run `/hybrid-new <name>`.

