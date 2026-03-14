---
description: Start a new SDD (Skill-Driven Development) workflow
---

Start a new Skill-Driven Development workflow using trinity-workflow schema.

**Input**: Change name (kebab-case) or description.

**Steps**

1. If no input, ask what to build using AskUserQuestion

2. Create change with trinity-workflow schema:
   ```bash
   openspec new change "<name>" --schema trinity-workflow
   ```

3. Show status and first artifact instructions

**Output**
- Change created with trinity-workflow schema
- Ready for proposal creation

**Note**: This is an alias for `/opsx-new` with `--schema trinity-workflow`
