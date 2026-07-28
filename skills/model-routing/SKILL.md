---
name: model-routing
description: Which phases need a deep-reasoning model and which can run on lighter models or other coding agents (Codex, opencode…). Use when choosing where to run a phase, when the user asks to save cost or tokens, or when a ticket is about to be implemented.
---

# Model Routing

The rule from `PRINCIPLES.md`: **decisions on heavy models, execution wherever it's cheapest.** Thinking work — alignment, architecture, review — pays for deep reasoning many times over. A well-specified ticket, by design, no longer needs it.

These skills are plain markdown (Agent Skills standard), so they run unchanged in Claude Code, Codex, opencode, and any harness that reads `SKILL.md` files. The portable unit of work is the **agent-ready ticket**: goal, constraints, and completion criterion all written down, no open decisions. If implementing it would require a decision, it isn't ready to leave the heavy model — sharpen it first.

## The tiers

| Tier | Phases / skills | Why |
| --- | --- | --- |
| **Heavy** (deep-reasoning model, e.g. Opus-class) | `/wayfinder`, `/grill-with-docs`, `/grill-me`, `/domain-modeling`, `/to-spec`, `/codebase-design`, `/improve-codebase-architecture`, `/diagnosing-bugs` (the hard ones), `/code-review`, `/design-gate` + hallmark's Design flow | Open decision space. Errors here compound into every downstream ticket. |
| **Medium** (mid-tier model, e.g. Sonnet-class) | `/implement` on an agent-ready ticket, `/tdd` slices, `/to-tickets` from a finished spec, `/prototype`, `/triage` | The shape of the work is fixed; the model executes and verifies against feedback loops. |
| **Light** (small model, or any other coding agent) | `/research` (reading legwork), `/checkpoint`, boilerplate and mechanical edits, running test suites, lockfile/dep bumps | Verifiable output, near-zero decision content. |

Tier is a floor on *judgment*, not a cap on tooling: a medium ticket that unexpectedly surfaces a real decision goes **back up** — stop, note the question on the ticket, and return it to the heavy model rather than deciding down-tier.

## Crossing agents

Handing a phase to another agent app is the same move as crossing sessions — the bridge is files, not memory:

1. On the heavy model: finish the thinking, cut agent-ready tickets, `/checkpoint`. If mid-conversation context matters to the ticket, `/handoff` it into a file and link it from the ticket.
2. In the lighter agent (Codex, opencode, a smaller Claude model): open the repo, point it at the ticket file (and handoff file, if any). The skills and `docs/agents/*` conventions travel with the repo, so the lighter agent plays by the same rules.
3. Back on the heavy model: `/code-review` the diff before it merges — review stays heavy regardless of who wrote the code.

`.dev/PROGRESS.md` records phases, whichever agent ran them — switching apps keeps the thread.
