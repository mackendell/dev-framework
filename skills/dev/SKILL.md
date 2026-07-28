---
name: dev
description: The workflow front door — figures out where you are (new project, existing codebase, or mid-effort) and routes you to the right skill at the right scale. Start every session here.
disable-model-invocation: true
---

# Dev

The front door to the framework. The user types `/dev` (optionally with an idea or task); you work out **where they are** and **how big the work is**, then route into the vendored skills. You orchestrate — the routed skills do the work.

## Step 1 — Situate

Look before asking. Establish which of three situations this is:

- **Resuming** — `.dev/PROGRESS.md` exists. Go to [Resume](#resume).
- **Greenfield** — the folder is empty or has no meaningful source. Go to [Greenfield](#greenfield).
- **Takeover** — an existing codebase without a progress file. Go to [Takeover](#takeover).

Completion criterion: you've read `.dev/PROGRESS.md` (or confirmed it's absent) and named the situation to the user in one line.

## Step 2 — Size the work

Every effort gets a **scale** before it gets a process. Ceremony must match scale — a typo fix gets none, an epic gets a map. Ask only if the user's ask doesn't already make it obvious:

| Scale | Shape | Route |
| --- | --- | --- |
| **S** | One clear change, one sitting, nothing to decide | Straight to `/tdd` (behaviour) or a direct edit (config, copy). No spec, no tickets. |
| **M** | One feature, fits one context window, a few open questions | `/grill-with-docs` (or `/grill-me` when there's no codebase yet) → `/implement` in the same window. |
| **L** | Multi-session build, questions answerable in conversation | Grill → `/to-spec` → `/to-tickets` → `/implement` per ticket, fresh context each. |
| **XL** | Foggy epic — the way to the destination isn't visible | `/wayfinder` to chart and resolve decisions; when the map clears, merge onto L at `/to-spec`. |

Three overlays apply at any scale:

- **User-facing UI in scope?** → run `/design-gate` **before** implementation is planned. The look is settled and signed off first; backend work serves the approved frontend, not the other way round.
- **Something is broken?** → `/diagnosing-bugs` before any fix. A bug that survives a first glance gets the loop, not a guess.
- **Asking the user anything?** → the `questionnaire` skill governs the form, in every phase — sizing, grilling, quizzes, sign-offs.

Completion criterion: scale named, route named, user has agreed (one line each).

## Step 3 — Run the route

A router hints more than it fires. Most routed skills are **user-invoked** — only the human can reach them — so hand the user the exact next invocation to type (`/grill-with-docs`, `/to-spec`, `/to-tickets`, `/implement`, `/wayfinder`, `/triage`, `/improve-codebase-architecture`, `/handoff`) and pick the thread back up when it's done. The **model-invoked** skills on a route (`/design-gate`, `/tdd`, `/diagnosing-bugs`, `/prototype`, `/verify-acs`, `/checkpoint`, `hallmark`) you invoke yourself at the moment the route reaches them.

Between phases, keep [context hygiene](#context-hygiene). A ticket counts as implemented only once `/verify-acs` has settled its acceptance criteria into verdicts. After each phase boundary — grilling done, spec written, tickets cut, a ticket implemented, a design signed off — fire `/checkpoint` so `.dev/PROGRESS.md` reflects reality.

Completion criterion for the session: the phase you set out to finish is finished **and** checkpointed, or a handoff file exists for what isn't.

## Greenfield

Nothing exists yet, so build the ground first:

1. `/setup-matt-pocock-skills` — tracker (local markdown is the sensible default until a remote exists), doc layout. Skip only if `docs/agents/` already exists.
2. `/grill-me` the idea (no codebase means nothing for `grill-with-docs` to be stateful about yet). For an XL-scale idea, chart with `/wayfinder` instead.
3. If the product has a face: `/design-gate`, then `/prototype` the approved direction until the user says *that's it*.
4. Merge onto the sized route from Step 2 (spec → tickets → implement, or straight implement for M).
5. `/checkpoint` at every boundary.

## Takeover

The codebase is the incumbent; learn it before touching it:

1. `/setup-matt-pocock-skills` if `docs/agents/` is absent — otherwise trust the existing config.
2. Route by what the user brought:
   - **A bug** → `/diagnosing-bugs`, then the fix at scale S/M.
   - **"Improve this codebase"** → `/improve-codebase-architecture`; the opportunity they pick becomes an idea entering at `/grill-with-docs`.
   - **A pile of raw issues** → `/triage`, then `/implement` the agent-ready ones.
   - **A feature idea** → Step 2 sizing, entering the main flow at `/grill-with-docs`.
3. `/checkpoint` once a direction exists.

## Resume

`.dev/PROGRESS.md` is the index, not the archive — read it, then zoom into what it points at (spec, open tickets, handoff files, the wayfinder map) only as needed:

1. Read `.dev/PROGRESS.md`. State to the user, in two lines: the effort, and its recorded **next action**.
2. Verify the next action is still true (tickets may have closed, files may have moved). Adjust if stale.
3. Confirm with the user, then run it.

If the progress file points at a handoff file, read that too — it carries the conversation the previous session couldn't.

## Context hygiene

One phase, one window. Grill → spec → tickets stay in **one unbroken window**; each `/implement` starts **fresh** from its ticket. Approaching the smart zone (~120k tokens) mid-phase → `/handoff`, then continue in a new session (the handoff file is the bridge; `/checkpoint` records that it exists). Model and agent choice per phase is governed by `skills/model-routing/SKILL.md` — consult it whenever a phase could run cheaper.
