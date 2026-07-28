---
name: design-gate
description: Decide who designs before any UI is built. Use before building, styling, or prototyping any user-facing page, screen, or component that doesn't already have an approved design — it routes between self-design via hallmark, an external design agent, or an existing design the user supplies.
---

# Design Gate

The gate runs **before** any user-facing UI is planned or built, and settles two things: **who designs**, and **what sign-off looks like**. Frontend comes first — the user approves the look before backend work is planned around it.

Skip the gate only when an approved design already exists (a `design.md`, an approved prototype route, or a pointer in `.dev/PROGRESS.md` under Design).

## Step 1 — Who designs?

Ask the user to pick a lane (one question, three options):

1. **I design it here** — run the vendored `hallmark` skill's Design flow: theme selection, structural variety, the anti-pattern rules. Best when the user wants to iterate live with the agent.
2. **A design agent designs it** — the user prefers a dedicated design tool (Claude Design / claude.ai artifacts, Google Stitch, v0, Figma Make…). Go to [Step 2 — the design brief](#step-2--the-design-brief).
3. **A design already exists** — the user has a screenshot, a URL, a Figma file, or HTML. Run `hallmark study` on it to extract the DNA, then build with that DNA.

## Step 2 — The design brief

When an external design agent is chosen, your deliverable is a **paste-ready brief**, not a design. Write it into `.dev/design-brief.md` and show it to the user. The brief contains:

- The product and page in one paragraph — audience, purpose, the single action the page drives
- Content inventory — real headings, real copy fragments, real data the page must carry
- Brand constraints — colours, fonts, tone, if any exist
- Structural asks — request structural variety and name any macrostructure preference, so the result reads as designed for this brief
- Output request — "return a full HTML page (or screenshot) I can hand back to my coding agent"

Then stop: the user takes the brief away and **comes back with an image or HTML**. When they do, run `hallmark study` on what they brought to extract the DNA, and build the real implementation from that DNA — never pixel-copy.

## Step 3 — Sign-off

Whatever the lane, the gate closes only on explicit user approval of a **visible** artifact — a rendered prototype route, a screenshot, an artifact page. Approval means: this is the look the backend now gets built to serve. Record the outcome (lane chosen, where the approved design lives) via `/checkpoint`.

## Hard rules (all lanes)

- **Icons come from an established icon library** (lucide, heroicons, phosphor, radix). Free-handing SVG `<path>` data is the tell of generated UI — when a needed icon doesn't exist in the library, ask the user rather than drawing one.
- **Hallmark's anti-pattern list applies to any code you write**, whichever lane produced the design — see `../hallmark/references/anti-patterns.md`.
- Imported designs are DNA, not pixels: honour the user's content and brand, not the reference's.

Completion criterion: a design lane was chosen, a visible artifact was approved by the user, and its location is checkpointed.
