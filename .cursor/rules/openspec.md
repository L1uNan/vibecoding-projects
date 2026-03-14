# Cursor Rules (OpenSpec / Hybrid Workflow)

This repo uses **OpenSpec** as a file-based workflow. Follow the `openspec/` workflow artifacts and tracking files. Do not rely on tool-specific slash commands.

## Source Of Truth

- `openspec/config.yaml`
- `openspec/schemas/hybrid-workflow/schema.yaml`

If anything conflicts, follow the schema first, then the config.

## Global Requirements

- All artifacts must be written in Simplified Chinese.
- Before running any workflow phase, initialize tracking (planning-with-files requirement in source schema/config).

## Required Structure (Per Feature/Fix)

- One feature/fix = one change folder: `openspec/changes/<change-name>/`
- Active change is stored in `openspec/.active` (file content is only `<change-name>`).

Tracking files are required for every change:

- `task_plan.md` (phase/goals/decisions/progress/errors)
- `findings.md` (tech findings, ADR-style decisions)
- `progress.md` (append-only session log)

Artifacts (structured flow):

- `proposal.md` (must be within 500 Chinese characters; includes Non-goals, 2-3 options, success metrics)
- `design.md` (must include architecture diagram, risks/mitigations, breaking changes)
- `specs/**/*.md` (Gherkin Given/When/Then; cover happy/edge/error cases)
- `tasks.md` (checkbox tasks grouped by batch; each task is 2-5 minutes and has verification steps)

## Execution Rules

- Implement tasks from `tasks.md` in order.
- After each task:
  - mark `- [ ]` to `- [x]`
  - update `task_plan.md` progress/phase
  - append an entry to `progress.md`

## 3-Strike Error Protocol

Log all failures in `task_plan.md`:

- Attempt 1: diagnose/fix
- Attempt 2: alternative approach
- Attempt 3: rethink approach
- After 3 failures: escalate to the user with concrete error details and options

## Verification

- Run the project’s relevant checks (tests/build/lint as applicable).
- Record results and gaps in `findings.md`.

## Notes

- Do not assume an `openspec` CLI exists. Use filesystem operations as defined by the schema.
