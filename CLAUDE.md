# dev-framework

A guided workflow layer on top of vendored skills from mattpocock/skills and Nutlope/hallmark. `PRINCIPLES.md` holds the hard rules — read it before changing anything here.

## Working on this repo

- **Creating or editing any skill or agent-facing doc**: invoke `/writing-great-skills` first, read its `GLOSSARY.md`, write under it, and prune the draft against its failure modes before committing (Principle 3).
- **Vendored skills** (everything listed in `upstream.lock.json`) are updated via `/check-upstream`; a deliberate local edit marks the file *diverged*, and `/check-upstream` then treats it as authored code.
- **Framework-native skills** (`dev`, `checkpoint`, `design-gate`, `verify-acs`, `questionnaire`, `model-routing`, `check-upstream`) are ours; keep them consistent with the routes named in `skills/dev/SKILL.md`.
- When a skill is added, removed, or renamed, update the routing table in `skills/dev/SKILL.md` and the reference list in `README.md` in the same change.
