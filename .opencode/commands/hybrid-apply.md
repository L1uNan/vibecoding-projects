---
description: Execute tasks with 3-Strike error protocol
---

Execute implementation tasks with systematic error handling.

## Input
- Optional: Change name (defaults to active)
- Optional: Batch number to start from

## Prerequisites
- tasks.md must exist with unchecked tasks
- task_plan.md must exist

## Execution Flow

1. Load change and verify prerequisites

2. Read tasks.md for task list

3. Read task_plan.md for current state

4. Execute tasks by batch:
   ```markdown
   ## Batch 1: Foundation
   - [x] 1.1 Setup (complete)
   - [ ] 1.2 Create model ← CURRENT
   - [ ] 1.3 Add validation
   ```

5. After each task:
   - Update checkbox: `- [ ]` → `- [x]`
   - Update task_plan.md Progress
   - Log to progress.md

## 3-Strike Error Protocol

When a task fails:

| Attempt | Action |
|---------|--------|
| 1 | Diagnose and fix |
| 2 | Try alternative approach |
| 3 | Rethink the problem |
| 3 fails | Escalate to user |

Log all attempts in task_plan.md:
```markdown
| Error | Attempt | Solution |
|-------|---------|----------|
| TypeError: x is null | 1 | Added null check |
| TypeError: x is null | 2 | Used optional chaining |
| TypeError: x is null | 3 | Refactored data flow |
```

## Completion Criteria

- All checkboxes in tasks.md checked
- task_plan.md Progress: 100%
- All verification steps passed

## Output
- All tasks implemented
- Progress at 100%
- Ready for /hybrid-verify
