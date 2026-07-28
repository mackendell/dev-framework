---
name: checkpoint
description: Update .dev/PROGRESS.md so a fresh session can resume the effort. Use when a workflow phase completes (grilling done, spec written, tickets cut, ticket implemented, design signed off), when the session is ending mid-effort, or when another skill hands off.
---

# Checkpoint

`.dev/PROGRESS.md` is the resume point: the single file `/dev` reads first in a fresh session. It is an **index, not an archive** — one screen, pointing at where the detail lives (tracker, spec, handoffs, `CONTEXT.md`). A decision lives in its ticket or ADR; the progress file says which phase the effort is in and what happens next.

## Process

1. Read the current `.dev/PROGRESS.md` if it exists (create `.dev/` if not).
2. Rewrite it to match reality — replace stale content, keep it under a screen:

```markdown
# Progress

## Effort
<one line — what is being built or fixed>

## Scale
S | M | L | XL

## Phase
<where in the route the effort is, e.g. "tickets cut, 2 of 5 implemented">

## Next action
<the single next step, as an invocation a fresh session can run, tagged with its model tier,
e.g. "/implement .scratch/checkout/issues/003-payment-webhook.md — Medium">

## Pointers
- Tracker: <where the open tickets live>
- Spec: <path or issue link, if one exists>
- Design: <design.md / approved prototype route, if UI is in scope>
- Handoffs: <paths of any live handoff files>
- Map: <wayfinder map link, XL efforts only>
```

3. Keep only the pointer lines that apply. Every path you write must exist — verify each.
4. Look up the Next action's skill in `skills/model-routing/SKILL.md`'s tier table and append its tier (Heavy / Medium / Light) to the line.
5. Quote the **Next action** string in your reply, inside a code span, character-for-character identical to what you just wrote in the file — e.g. `` `/tdd .scratch/checkout/issues/003-payment-webhook.md — Medium` ``. Prose *about* it ("next action is still ticket 03") is not the invocation; the user must be able to copy what you wrote straight into the prompt.

Completion criterion: checkable — your reply contains a code span holding the Next action string and its tier, matching the file byte-for-byte.
