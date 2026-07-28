---
name: implement
description: "Implement a piece of work based on a spec or set of tickets."
disable-model-invocation: true
---

Implement the work described by the user in the spec or tickets.

Use /tdd where possible, at pre-agreed seams.

Run typechecking regularly, single test files regularly, and the full test suite once at the end.

Once done, use /code-review to review the work.

Commit your work to the current branch.

Once the commit lands, invoke `/verify-acs` — the ticket counts as implemented only when its acceptance criteria are settled — then fire `/checkpoint`.

Blocked mid-ticket (a decision only the user can make, a go-ahead on an irreversible step, access you lack)? Fire `/checkpoint` first, then ask the blocking question per the `questionnaire` skill.
