# dev-framework

A guided development workflow for coding agents. Two vendored skill sets supply the discipline; a thin native layer routes you through them:

- **[mattpocock/skills](https://github.com/mattpocock/skills)** — engineering: grilling, specs, tickets, TDD, code review, wayfinding, architecture.
- **[Nutlope/hallmark](https://github.com/Nutlope/hallmark)** — design: anti-slop rules, structural variety, real themes.
- **The native layer** — `/dev` (the front door), `/checkpoint` (resumable progress), `/design-gate` (who designs), `/model-routing` (where each phase runs), `/check-upstream` (keeping the vendored skills fresh).

The hard rules live in [`PRINCIPLES.md`](PRINCIPLES.md); the upstream pins in [`upstream.lock.json`](upstream.lock.json).

## Install

**Into any project** (copies the skills so you can hack them):

```bash
scripts/install.sh /path/to/your/project
```

**As a Claude Code plugin** (managed bundle, once this repo is pushed to GitHub):

```
/plugin marketplace add <you>/dev-framework
/plugin install dev-framework@dev-framework
```

## Use

Run `/dev`. That's the whole interface. It makes three moves ([`skills/dev/SKILL.md`](skills/dev/SKILL.md)):

1. **Situate** — greenfield, takeover of an existing codebase, or resuming a prior effort from `.dev/PROGRESS.md`.
2. **Size** — every effort gets a scale before it gets a process: **S** (direct fix, no ceremony), **M** (grill → implement in one window), **L** (spec → tickets → implement per ticket), **XL** (wayfinder map first). Ceremony matches scale.
3. **Route** — into the right skills, with two overlays at any scale: user-facing UI triggers `/design-gate` before implementation is planned, and anything broken goes through `/diagnosing-bugs` before any fix.

Common situations, and where `/dev` sends them:

| You bring | It routes to |
| --- | --- |
| An empty folder and an idea | tracker setup → `/grill-me` (or `/wayfinder` for a foggy epic) → design gate if the product has a face → spec → tickets → implement |
| A bug in an existing codebase | `/diagnosing-bugs`, then the fix at scale |
| "Make this codebase better" | `/improve-codebase-architecture` |
| A pile of raw issues | `/triage`, then `/implement` the agent-ready ones |
| A dead or cleared session | `.dev/PROGRESS.md` — `/dev` reads it and resumes from **Next action** |

## What the framework guarantees

Each guarantee is enforced by a skill; the linked file is the source of truth.

- **Alignment before code.** Every non-trivial change starts with grilling — closing the gap between what you mean and what the agent builds ([`PRINCIPLES.md`](PRINCIPLES.md)).
- **Frontend first, and no AI slop.** `/design-gate` runs before user-facing work is planned: you pick who designs (the agent via hallmark, an external design agent via a paste-ready brief, or a design you supply), and the gate closes only on your approval of a *visible* artifact. Icons come from established libraries, never free-handed SVG, and hallmark's [anti-pattern rules](skills/hallmark/references/anti-patterns.md) bind all UI code whichever lane produced the design ([`skills/design-gate/SKILL.md`](skills/design-gate/SKILL.md)).
- **Progress lives in files, not sessions.** `/checkpoint` keeps `.dev/PROGRESS.md` — a one-screen index of effort, scale, phase, and next action — current at every phase boundary, so any session can die and any fresh one can resume ([`skills/checkpoint/SKILL.md`](skills/checkpoint/SKILL.md)).
- **Decisions on heavy models, execution wherever it's cheapest.** Grilling, specs, architecture, and review stay on a deep-reasoning model; agent-ready tickets deliberately don't need one and can run on Codex, opencode, or a smaller Claude model — the skills are plain markdown (Agent Skills standard) and travel with the repo. Review of the diff comes back to the heavy model ([`skills/model-routing/SKILL.md`](skills/model-routing/SKILL.md)).
- **Upstream updates flow in; your hacks survive.** `/check-upstream` diffs each pinned upstream against its tip, reports new / updated / diverged / removed skills, merges what you pick, and re-pins. Locally edited files are treated as authored code, never auto-overwritten ([`skills/check-upstream/SKILL.md`](skills/check-upstream/SKILL.md)).
- **Skills are written well.** Every skill created or edited here goes through [`writing-great-skills`](skills/writing-great-skills/SKILL.md) first — enforced by `CLAUDE.md` so agents working on this repo do it automatically.

## Skill reference

### Framework layer (this repo)

| Skill | Invocation | Job |
| --- | --- | --- |
| [`dev`](skills/dev/SKILL.md) | `/dev [idea or task]` | Front door: situates, sizes (S–XL), routes. |
| [`checkpoint`](skills/checkpoint/SKILL.md) | auto + `/checkpoint` | Keeps `.dev/PROGRESS.md` resumable at every phase boundary. |
| [`design-gate`](skills/design-gate/SKILL.md) | auto, before UI work | Who designs; sign-off on a visible artifact before backend. |
| [`model-routing`](skills/model-routing/SKILL.md) | auto + on demand | Heavy/medium/light tiers per phase; protocol for crossing to other agents. |
| [`check-upstream`](skills/check-upstream/SKILL.md) | `/check-upstream` | Diff vendored skills against upstream tips; merge and re-pin. |

### Vendored — engineering (mattpocock/skills)

`ask-matt`, `grill-me`, `grill-with-docs`, `grilling`, `domain-modeling`, `codebase-design`, `to-spec`, `to-tickets`, `implement`, `tdd`, `code-review`, `diagnosing-bugs`, `triage`, `prototype`, `research`, `wayfinder`, `improve-codebase-architecture`, `resolving-merge-conflicts`, `handoff`, `teach`, `writing-great-skills`, `setup-matt-pocock-skills`

### Vendored — design (Nutlope/hallmark)

`hallmark` (with its full reference library: themes, macrostructures, components, anti-patterns, slop-test).

## Layout

```
PRINCIPLES.md        the hard rules
upstream.lock.json   pinned upstream commits (/check-upstream reads this)
skills/              all skills, flat — one folder per skill
scripts/install.sh   copy skills into a project's .claude/skills/
.claude-plugin/      Claude Code plugin + marketplace manifests
.dev/                per-project progress state (created in *your* project, not here)
```
