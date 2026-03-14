---
description: Start a new SDD (Skill-Driven Development) workflow
---

Start a new Skill-Driven Development workflow using the OpenSpec workflow in this repo.

If the user did not provide `<change-name>`, ask for one in kebab-case (e.g. `add-login`).

**Steps**
1. Ensure CWD is the repo root (contains `openspec/`).
2. Create change skeleton under `openspec/changes/<name>/`:
   - `openspec/changes/<name>/`
   - `openspec/changes/<name>/specs/`
   - required tracking files: `task_plan.md`, `findings.md`, `progress.md`
   - artifacts: `proposal.md`, `design.md`, `tasks.md`
3. Set active change:
   - write `<name>` to `openspec/.active`
4. Initialize `task_plan.md` with:
   - Phase: `init`
   - Goals (from user request)
   - Decisions (empty section)
   - Progress: 0%
   - Errors table for 3-Strike protocol
5. Append a log entry to `progress.md` describing what was created.
6. Enforce source requirements from `openspec/config.yaml`:
   - all artifacts in Simplified Chinese
   - `proposal.md` within 500 Chinese characters
   - `design.md` must include architecture diagram

**Shell helpers (run if needed)**
```bash
NAME="<change-name>"
mkdir -p "openspec/changes/$NAME/specs"
printf "%s\n" "$NAME" > openspec/.active
for f in task_plan.md findings.md progress.md proposal.md design.md tasks.md; do : > "openspec/changes/$NAME/$f"; done
```
