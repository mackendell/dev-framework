---
name: dev
description: The initializer — names the situation (greenfield, takeover, or resuming), lays the ground, and hands over the route menu. Run once per project.
disable-model-invocation: true
---

# Dev

The framework's initializer. The user types `/dev` in a folder; you establish **where they are**, lay the ground, hand them the [route menu](#routes), and stop. The user drives from there.

## Step 1 — Situate

Establish which of three situations this is:

- **Resuming** — `.dev/PROGRESS.md` exists. Already initialized: point the user at `/continue` and stop.
- **Greenfield** — the folder is empty or has no meaningful source.
- **Takeover** — an existing codebase without a progress file.

Completion criterion: you've read `.dev/PROGRESS.md` (or confirmed it's absent) and named the situation to the user in one line.

## Step 2 — Lay the ground

- **Greenfield**: `/setup-matt-pocock-skills` — tracker (local markdown is the sensible default until a remote exists) and doc layout.
- **Takeover**: `/setup-matt-pocock-skills` only if `docs/agents/` is absent; an existing config is trusted as-is.

Completion criterion: `docs/agents/` exists (or already did) and you've told the user in one line what was set up.

## Step 3 — Hand over

Print the routes below that fit the situation, then stop. The routed skills fire by the user's hand, not yours.

## Routes

| You have | Type |
| --- | --- |
| An idea, no codebase yet | `/grill-me` |
| An idea against an existing codebase | `/grill-with-docs` |
| A foggy epic — the way to the destination isn't visible | `/wayfinder` |
| A grilled idea ready to build | `/to-spec` → `/to-tickets` → `/implement` per ticket, fresh context each; one-sitting work goes straight to `/tdd` or a direct edit |
| Something broken | `/diagnosing-bugs` |
| "Improve this codebase" | `/improve-codebase-architecture` |
| A pile of raw issues | `/triage`, then `/implement` the agent-ready ones |
| A dead or cleared session | `/continue` |
