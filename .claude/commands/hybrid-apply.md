---
description: Execute tasks with 3-Strike error protocol
---

Execute implementation tasks from `tasks.md` with systematic error handling.

## Prerequisites

- `tasks.md` exists with unchecked tasks
- `task_plan.md` exists

## Execution Flow

1. Load active change.
2. Read `tasks.md` for task list.
3. Read `task_plan.md` for current state.
4. Execute tasks by batch.
5. After each task:
   - Update checkbox in `tasks.md`: `- [ ]` -> `- [x]`
   - Update progress in `task_plan.md`
   - Append a log entry to `progress.md` (what changed + how verified)

## 3-Strike Error Protocol

When a task fails:

- Attempt 1: diagnose and fix
- Attempt 2: try an alternative approach
- Attempt 3: rethink the problem
- After 3 failures: escalate to the user with concrete error details and options

Log all attempts in the Errors table in `task_plan.md`.

