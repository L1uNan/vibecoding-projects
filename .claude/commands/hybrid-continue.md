---
description: Continue to next artifact in hybrid workflow
---

Continue creating the next artifact in the hybrid workflow.

## Steps

1. Load active change from `openspec/.active`.
2. Read `task_plan.md` to determine current phase.
3. Determine next artifact:
   - `init` -> `proposal.md`
   - `proposal` -> `design.md`
   - `design` -> `specs/**/*.md`
   - `specs` -> `tasks.md`
   - `tasks` -> next is `/hybrid-apply`
4. Create the next artifact, following rules in:
   - `openspec/config.yaml`
   - `openspec/schemas/hybrid-workflow/schema.yaml`
   - enforce: Simplified Chinese outputs, `proposal.md` <= 500 Chinese chars, `design.md` includes architecture diagram, `tasks.md` uses 2-5 minute tasks with verification steps
5. Update `task_plan.md` (phase/status/progress).
6. Append an entry to `progress.md`.
