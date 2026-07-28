# Principles (hard rules)

Every skill, workflow, and doc in this framework follows these rules. When a change conflicts with them, the change loses.

## 1. Matt Pocock's engineering philosophy governs

The engineering skills are vendored from [mattpocock/skills](https://github.com/mattpocock/skills) and the workflow layer is built in its image:

- **Small, composable, hackable.** Skills stay short and easy to adapt; the user keeps control of the process, so bugs in it stay fixable.
- **Align before building.** Grilling closes the gap between what the user means and what the agent builds. Every non-trivial change starts with alignment.
- **Feedback loops are the speed limit.** Red-green TDD, types, browser access — every change runs against a live loop.
- **Design is invested in daily.** Deep modules, small interfaces, a shared ubiquitous language in `CONTEXT.md` and ADRs.
- **Decisions, not deliverables, when the fog is thick.** Big foggy efforts are charted as wayfinder maps and resolved one decision at a time.
- **Context hygiene.** One phase, one context window; cross sessions with `/handoff` at the smart-zone boundary.

## 2. Design follows Hallmark

Visual work is governed by the vendored [Nutlope/hallmark](https://github.com/Nutlope/hallmark) skill: structural variety and its anti-pattern rules. `/design-gate` fronts it with two house rules — the user signs off on the look before backend work starts, and icons come from an established library (lucide, heroicons, phosphor…). The full gate lives in [`skills/design-gate/SKILL.md`](skills/design-gate/SKILL.md).

## 3. Skills are written under /writing-great-skills

Any skill created or edited in this repo is written by invoking `/writing-great-skills` first — its `GLOSSARY.md` included — then pruning the draft against its failure modes before committing. The agent-facing docs in this repo (this file, `CLAUDE.md`) are held to the same principles.

## 4. Decisions on heavy models, execution wherever it's cheapest

Skills are plain markdown following the Agent Skills standard — they run on any model and any harness (Claude Code, Codex, opencode…). What stays on a deep-reasoning model is the *thinking* (grilling, specs, architecture, review). Well-specified tickets are deliberately portable to lighter models and agents. See [`skills/model-routing/SKILL.md`](skills/model-routing/SKILL.md).

## 5. Progress lives in files

Any session can die at any moment. State that matters is on disk: `.dev/PROGRESS.md` (the index), the issue tracker (the work), `CONTEXT.md`/ADRs (the language and decisions), handoff files (the conversations). Resuming is `/dev` in a fresh session reading that index.
