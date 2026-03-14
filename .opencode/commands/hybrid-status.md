---
description: Show hybrid workflow status
---

Show current hybrid workflow status and progress.

## Output

### Change Overview
- Change name
- Current phase
- Progress percentage
- Created date

### Tracking Layer
- task_plan.md status
- findings.md entries
- progress.md entries

### Artifacts Status
| Artifact | Status | Size |
|----------|--------|------|
| proposal.md | ✓ | 2.1k |
| design.md | ✓ | 4.3k |
| specs/ | ✓ | 3 files |
| tasks.md | ✓ | 12/12 |

### Recent Activity
Last 5 entries from progress.md

## Example

```
You: /hybrid-status

AI: 📊 Hybrid Workflow Status

    Change: add-dark-mode
    Phase: apply
    Progress: 85%

    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    Artifacts
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    ✓ proposal.md    (1.2k)
    ✓ design.md      (3.4k)
    ✓ specs/         (2 files)
    ✓ tasks.md       (10/12 complete)

    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    Recent Activity
    ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    10:45 ✓ Batch 3.1: Added theme context
    10:42 ✓ Batch 2.3: Updated button styles
    10:40 ✓ Batch 2.2: Added CSS variables

    Next: Continue /hybrid-apply
```
