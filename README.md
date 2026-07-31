# dev-framework

A guided development workflow for coding agents. Two vendored skill sets supply the discipline; a thin native layer routes you through them:

- **[mattpocock/skills](https://github.com/mattpocock/skills)** — engineering: grilling, specs, tickets, TDD, code review, wayfinding, architecture.
- **[Nutlope/hallmark](https://github.com/Nutlope/hallmark)** — design: anti-slop rules, structural variety, real themes.
- **The native layer** — `/dev` (the initializer), `/continue` (resume after `/clear`), `/checkpoint` (resumable progress), `/design-gate` (who designs), `/verify-acs` (acceptance criteria settled into verdicts), `questionnaire` (questions asked as structured questionnaires), `/model-routing` (where each phase runs), `/check-upstream` (keeping the vendored skills fresh).

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

Run `/dev` once per project. It names your situation — greenfield, takeover of an existing codebase, or resuming from `.dev/PROGRESS.md` — lays the ground (tracker and doc layout via `/setup-matt-pocock-skills`), hands you the route menu, and stops ([`skills/dev/SKILL.md`](skills/dev/SKILL.md)). From there you drive:

| You have | Type |
| --- | --- |
| An idea, no codebase yet | `/grill-me` |
| An idea against an existing codebase | `/grill-with-docs` |
| A foggy epic | `/wayfinder` |
| A grilled idea ready to build | `/to-spec` → `/to-tickets` → `/implement` per ticket; one-sitting work goes straight to `/tdd` or a direct edit |
| A bug | `/diagnosing-bugs` |
| "Make this codebase better" | `/improve-codebase-architecture` |
| A pile of raw issues | `/triage`, then `/implement` the agent-ready ones |
| A dead or cleared session | `/continue` — reads `.dev/PROGRESS.md` and resumes from **Next action** |

## What the framework guarantees

Each guarantee is enforced by a skill; the linked file is the source of truth.

- **Alignment before code.** Every non-trivial change starts with grilling — closing the gap between what you mean and what the agent builds ([`PRINCIPLES.md`](PRINCIPLES.md)).
- **Frontend first, and no AI slop.** `/design-gate` runs before user-facing work is planned: you pick who designs (the agent via hallmark, an external design agent via a paste-ready brief, or a design you supply), and the gate closes only on your approval of a *visible* artifact. Icons come from established libraries, never free-handed SVG, and hallmark's [anti-pattern rules](skills/hallmark/references/anti-patterns.md) bind all UI code whichever lane produced the design ([`skills/design-gate/SKILL.md`](skills/design-gate/SKILL.md)).
- **Questions arrive as questionnaires.** Whenever the agent needs your input — grilling, ticket quizzes, design sign-off, verification — it presents a structured questionnaire with selectable options and a recommendation, one decision at a time, instead of open questions in prose ([`skills/questionnaire/SKILL.md`](skills/questionnaire/SKILL.md)).
- **Done means verified.** A ticket counts as implemented only when every acceptance criterion has a verdict backed by evidence — covered by a test, confirmed by observation, or untouched by the change. The agent proves everything its own tools can reach; only the residue that needs human eyes reaches you, as a questionnaire answered one criterion at a time ([`skills/verify-acs/SKILL.md`](skills/verify-acs/SKILL.md)).
- **Progress lives in files, not sessions.** `/checkpoint` keeps `.dev/PROGRESS.md` — a one-screen index of effort, phase, and next action — current at every phase boundary, so any session can die and any fresh one can resume ([`skills/checkpoint/SKILL.md`](skills/checkpoint/SKILL.md)). The plugin install makes the writing side deterministic ([`hooks/`](hooks/)): a Stop-hook guard holds the turn open until `/checkpoint` runs whenever commits have landed past the file — so `/clear` at any moment loses nothing, and `/continue` in the fresh session picks the effort straight back up.
- **Decisions on heavy models, execution wherever it's cheapest.** Grilling, specs, architecture, and review stay on a deep-reasoning model; agent-ready tickets deliberately don't need one and can run on Codex, opencode, or a smaller Claude model — the skills are plain markdown (Agent Skills standard) and travel with the repo. Review of the diff comes back to the heavy model ([`skills/model-routing/SKILL.md`](skills/model-routing/SKILL.md)).
- **Upstream updates flow in; your hacks survive.** `/check-upstream` diffs each pinned upstream against its tip, reports new / updated / diverged / removed skills, merges what you pick, and re-pins. Locally edited files are treated as authored code, never auto-overwritten ([`skills/check-upstream/SKILL.md`](skills/check-upstream/SKILL.md)).
- **Skills are written well.** Every skill created or edited here goes through [`writing-great-skills`](skills/writing-great-skills/SKILL.md) first — enforced by `CLAUDE.md` so agents working on this repo do it automatically.

## Skill reference

### Framework layer (this repo)

| Skill | Invocation | Job |
| --- | --- | --- |
| [`dev`](skills/dev/SKILL.md) | `/dev` | Initializer: names the situation, lays the ground, hands over the route menu. |
| [`checkpoint`](skills/checkpoint/SKILL.md) | auto + `/checkpoint` | Keeps `.dev/PROGRESS.md` resumable at every phase boundary. |
| [`continue`](skills/continue/SKILL.md) | `/continue` | Resumes a fresh session from `.dev/PROGRESS.md`: verify the next action, confirm, run. |
| [`design-gate`](skills/design-gate/SKILL.md) | auto, before UI work | Who designs; sign-off on a visible artifact before backend. |
| [`verify-acs`](skills/verify-acs/SKILL.md) | auto, as a ticket wraps | Every acceptance criterion gets a verdict; the agent proves what it can, the user is quizzed one-by-one on the rest. |
| [`questionnaire`](skills/questionnaire/SKILL.md) | auto, on any question to the user | Questions arrive as structured questionnaires with selectable options, never plain prose. |
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
hooks/               plugin hook: the checkpoint guard (Stop)
scripts/install.sh   copy skills into a project's .claude/skills/ (the hook ships with the plugin install only)
.claude-plugin/      Claude Code plugin + marketplace manifests
.dev/                per-project progress state (created in *your* project, not here)
```
