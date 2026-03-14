---
description: Continue SDD workflow - create next artifact
---

Continue the SDD workflow by creating the next artifact.

**Rules**
- Follow the phase order in `openspec/schemas/hybrid-workflow/schema.yaml`.
- Update `task_plan.md` phase and progress after creating each artifact.
- Append an entry to `progress.md` for every action.
- Record non-trivial decisions in `findings.md` (ADR style).
- Enforce source rules from `openspec/config.yaml`: Simplified Chinese outputs, `proposal.md` <= 500 Chinese chars, `design.md` includes architecture diagram, `tasks.md` items are 2-5 minutes with verification steps.

**Determine next artifact**
- `init` -> create `proposal.md`
- `proposal` -> create `design.md`
- `design` -> create `specs/**/*.md`
- `specs` -> create `tasks.md`
- `tasks` -> next is `/sdd-apply`
