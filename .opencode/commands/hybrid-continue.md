---
description: Continue to next artifact in hybrid workflow
---

Continue creating the next artifact in the hybrid workflow.

## Steps

1. Load active change

2. Check current phase from task_plan.md

3. Determine next artifact:
   | Current | Next |
   |---------|------|
   | init | proposal |
   | proposal | design |
   | design | specs |
   | specs | tasks |
   | tasks | apply |

4. Create next artifact using template

5. Update task_plan.md:
   - Phase: <new-phase>
   - Status: complete
   - Progress: <percentage>

6. Update progress.md with action log

## Output
- Next artifact created
- Progress updated
- Clear next step

## Example

```
You: /hybrid-continue

AI: Current phase: proposal (complete)
    Next phase: design

    Creating design.md...

    ✓ Architecture overview
    ✓ Data models
    ✓ API design
    ✓ Component design
    ✓ Risks & mitigations

    Progress: 40%

    Next: /hybrid-continue (to create specs)
```
