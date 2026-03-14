---
description: Archive completed change
---

Archive a completed change.

## Rules

Only archive when:
- All tasks are checked
- `task_plan.md` progress is 100%
- Verification results are recorded

## Steps

1. Write a completion summary in `findings.md` (what shipped, key decisions, known gaps).
2. If the repo expects it, move the change folder to an archive location.
   - If archive structure is unclear, do not move files; just mark completion in tracking.
3. Clear or update `openspec/.active` appropriately.

