---
description: Archive completed hybrid workflow change
---

Archive a completed hybrid workflow change.

## Prerequisites
- All tasks complete (or explicitly waived)
- Verification passed (recommended)

## Steps

1. Load active change

2. Check artifact status:
   - proposal.md exists?
   - design.md exists?
   - specs/ exists?
   - tasks.md complete?

3. Sync delta specs (if applicable):
   - Prompt user to confirm
   - Merge to main specs

4. Archive:
   - Move to openspec/changes/archive/YYYY-MM-DD-<name>/
   - Update project status

5. Update findings.md:
   - Mark change as archived
   - Add lessons learned

## Output

```
You: /hybrid-archive

AI: 📦 Archiving add-dark-mode...

    Artifact status:
    ✓ proposal.md
    ✓ design.md
    ✓ specs/ (2 files)
    ✓ tasks.md (10/10 complete)

    Delta specs: 2 files not synced
    → Sync now? [Yes/No]

You: Yes

AI: ✓ Synced specs to openspec/specs/ui/dark-mode.md
    ✓ Moved to openspec/changes/archive/2026-03-03-add-dark-mode/

    Change archived successfully.

    Lessons learned (add to findings.md?):
    1. CSS variables work well for theming
    2. Consider system preference detection for v2
```
