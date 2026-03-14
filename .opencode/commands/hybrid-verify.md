---
description: Verify implementation matches artifacts
---

Verify implementation matches artifacts across three dimensions.

## Dimensions

### 1. Completeness
- All tasks in tasks.md are checked
- All requirements in specs have corresponding code
- All scenarios covered

### 2. Correctness
- Implementation matches spec intent
- Edge cases from scenarios handled
- Error states match spec definitions

### 3. Coherence
- Design decisions reflected in code structure
- Naming conventions consistent with design.md
- Patterns consistent across implementation

## Output Format

```
Verifying <change-name>...

COMPLETENESS
✓ All 12 tasks in tasks.md are checked
✓ All requirements in specs have corresponding code
⚠ Scenario "X" not tested

CORRECTNESS
✓ Implementation matches spec intent
✓ Edge cases handled
✓ Error states correct

COHERENCE
✓ Design decisions reflected
✓ Naming conventions consistent
⚠ Design mentions "X" but code does "Y"

─────────────────────────────
Critical issues: 0
Warnings: 2
Ready to archive: Yes (with warnings)

Recommendations:
1. Add test for scenario X
2. Update design.md or code for Y
```

## Exit Codes
- 0: All checks pass
- 1: Warnings only
- 2: Critical issues found
