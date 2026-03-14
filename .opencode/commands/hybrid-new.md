---
description: Start a new Hybrid workflow change
---

Start a new Hybrid workflow change with flexible mode selection.

## Input
- Change name (kebab-case) or description
- Optional: `--mode` flag (quick | explore | structured)

## Modes

### Quick Mode (default)
For clear requirements, fast execution:
```
/hybrid-new add-login --mode quick
```
Flow: init → ff → apply → archive

### Explore Mode
For unclear requirements:
```
/hybrid-new optimize-performance --mode explore
```
Flow: explore → init → continue → apply → archive

### Structured Mode
For large features:
```
/hybrid-new redesign-checkout --mode structured
```
Flow: init → proposal → design → specs → tasks → apply → archive

## Steps

1. If no input, ask what to build using AskUserQuestion

2. Create change with hybrid-workflow schema:
   ```bash
   openspec new change "<name>" --schema hybrid-workflow
   ```

3. Initialize tracking layer (MUST):
   - Use Skill tool with skill: "planning-with-files"
   - Creates: task_plan.md, findings.md, progress.md

4. Show mode-specific next steps

## Output
- Change created with hybrid-workflow schema
- Tracking layer initialized
- Ready for next phase based on mode
