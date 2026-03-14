# Project Context (OpenSpec / Hybrid Workflow)

This repo uses **OpenSpec** as a *file-based* workflow. In Claude Code CLI, the workflow can be driven via slash commands defined in `.claude/commands/`, but the source of truth is always the `openspec/` files.

## Source Of Truth

- Project config: `openspec/config.yaml`
- Workflow schema: `openspec/schemas/hybrid-workflow/schema.yaml`

If instructions conflict, follow the schema first, then the config.

## Global Requirements

- All artifacts must be written in Simplified Chinese.
- Before running any workflow phase, initialize tracking (planning-with-files requirement in source schema/config).

## What “Following OpenSpec” Means Here

For each feature/fix, create (or use) exactly one change folder:

- `openspec/changes/<change-name>/`
- Set the active change in `openspec/.active` (contains only `<change-name>`).

Required tracking files (must exist for every change):

- `task_plan.md` (phase, goals, decisions, progress, errors/3-strike log)
- `findings.md` (tech findings, ADR-style decisions)
- `progress.md` (append-only session log)

Artifacts (structured flow):

- `proposal.md` (must be within 500 Chinese characters; includes Non-goals, 2-3 options, success metrics)
- `design.md` (must include architecture diagram, risks/mitigations, breaking changes)
- `specs/**/*.md` (Gherkin Given/When/Then; cover happy/edge/error cases)
- `tasks.md` (checkbox tasks grouped by batch; each task 2-5 minutes; each task has verification steps)

Execution (“apply” phase):

- Implement tasks from `tasks.md` in order.
- After each task:
  - mark `- [ ]` to `- [x]`
  - update `task_plan.md` progress/phase
  - append an entry to `progress.md`

3-Strike error protocol (log in `task_plan.md`):

- Attempt 1: diagnose/fix
- Attempt 2: alternative approach
- Attempt 3: rethink approach
- After 3 failures: escalate to the user with concrete error details and options

Verification (“verify” phase):

- Run the project’s relevant checks (tests/build/lint as applicable).
- Record results and any gaps in `findings.md`.

## What “Done” Means

- `tasks.md` checkboxes are all checked
- `task_plan.md` progress is 100%
- verification commands for the project pass (tests/build as applicable)
- key decisions and findings recorded in `findings.md`

## Notes

- `.opencode/commands/*.md` are for OpenCode. Claude uses `.claude/commands/*.md`.
- Do not assume an `openspec` CLI exists. Use filesystem operations (create folders/files, edit markdown) as defined by the schema.

## Prompt Template (For Teammates)

Use this when starting a Claude Code CLI session in this repo:

“Follow OpenSpec `hybrid-workflow` in this repo. For my request, create/use one change under `openspec/changes/<name>/`, set `openspec/.active`, keep `task_plan.md/findings.md/progress.md` updated, produce `proposal.md → design.md → specs → tasks.md`, then implement tasks with checkboxes + 3-strike logging, and verify with project checks.”
