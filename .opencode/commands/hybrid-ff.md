---
description: Fast-forward - generate all planning documents at once
---

Fast-forward through planning: generate all documents in one command.

## Input
- Optional: Change name (defaults to active change)

## What it Creates

1. **proposal.md** - Requirements and options
2. **design.md** - Technical architecture
3. **specs/**/*.md** - Feature specifications
4. **tasks.md** - Implementation tasks

## Prerequisites
- Change must exist (use `/hybrid-new` first)
- Tracking layer initialized

## Steps

1. Load active change or specified change

2. Verify tracking layer exists (MUST):
   - If missing, call planning-with-files skill

3. Generate all artifacts sequentially:
   ```
   proposal → design → specs → tasks
   ```

4. Update task_plan.md:
   - Phase: tasks
   - Status: complete
   - Progress: 80%

5. Show summary and next step (/hybrid-apply)

## Output
- All planning documents created
- Ready for implementation
- Clear task breakdown

## Example

```
You: /hybrid-ff add-dark-mode

AI: 🚀 Fast-forwarding add-dark-mode...

    ✓ Created proposal.md (3 options)
    ✓ Created design.md (architecture + diagram)
    ✓ Created specs/ui/dark-mode.md (5 scenarios)
    ✓ Created tasks.md (12 tasks in 4 batches)

    Progress: 80%

    Next: /hybrid-apply
```
