---
description: Show SDD workflow status
---

Show current SDD workflow status and tracking layer progress.

**Input**: Optional change name.

**Steps**

1. Get openspec status:
   ```bash
   openspec status --change "<name>"
   ```

2. If tracking files exist, show:
   - Current phase (from task_plan.md)
   - Progress percentage
   - Recent activity (from progress.md)

**Note**: This is an alias for `/opsx-status` with tracking layer info
