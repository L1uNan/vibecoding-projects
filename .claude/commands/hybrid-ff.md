---
description: Fast-forward planning - generate all planning docs
---

Fast-forward: generate all planning artifacts for the active change.

## Output

- `proposal.md`
- `design.md`
- `specs/**/*.md`
- `tasks.md`

## Steps

1. Ensure tracking files exist (`task_plan.md`, `findings.md`, `progress.md`).
2. Generate artifacts in order (proposal -> design -> specs -> tasks).
   - enforce source rules: Simplified Chinese outputs, `proposal.md` <= 500 Chinese chars, `design.md` includes architecture diagram, tasks are 2-5 minutes with verification steps
3. Update `task_plan.md` phase/progress along the way.
4. Record key decisions in `findings.md` (ADR style).
5. Append logs to `progress.md`.
6. Next step: `/hybrid-apply`.
