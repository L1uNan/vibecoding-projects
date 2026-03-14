---
description: Execute SDD workflow tasks
---

Execute tasks from the SDD workflow.

**Prerequisites**
- `openspec/.active` points to an existing change
- `openspec/changes/<name>/tasks.md` exists and contains unchecked tasks
- `task_plan.md` exists

**Execution rules**
- Work batch-by-batch.
- After each task:
  - check it off in `tasks.md` (`- [ ]` -> `- [x]`)
  - update progress in `task_plan.md`
  - append a log entry to `progress.md` (what changed + how verified)

**3-Strike protocol**
When blocked:
- Attempt 1: diagnose and fix
- Attempt 2: try an alternative approach
- Attempt 3: rethink the approach
- After 3 failures: escalate to the user with concrete error details and 2-3 options

Log every attempt in the Errors table in `task_plan.md`.
