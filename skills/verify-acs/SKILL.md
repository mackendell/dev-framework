---
name: verify-acs
description: Settle a ticket's acceptance criteria into verdicts — prove what the agent's own tools can reach, then quiz the user one criterion at a time on the residue. Use when a ticket or feature finishes implementation, or when the user asks to verify acceptance criteria or whether the ACs are met.
---

# Verify ACs

Every acceptance criterion ends in a **verdict** backed by named **evidence**. You settle everything your own tools can reach; only the **residue** — criteria whose evidence needs human senses or access you lack — goes to the user, one question at a time.

## Verdicts

| Verdict | Meaning | Evidence it carries |
| --- | --- | --- |
| **covered** | an automated test asserts it | the test file and name — stays true on every future run |
| **confirmed \<date\>** | observed true right now, by you or the user | the command output, screenshot, or observation |
| **untouched** | the change cannot affect it | one line on why it is outside the blast radius |
| **unmet** | evidence shows it fails | what failed — this row becomes the next red test |

`covered` outranks `confirmed`: a confirmation decays the moment the code changes, a test re-proves itself every run. A criterion that is testable but untested gets a test (via `/tdd`, at agreed seams), not a hand-check.

## Process

### 1. Collect

List the ticket's acceptance criteria verbatim, numbered. If the ticket carries none, draft them from the spec or conversation and get the user's agreement before verifying anything.

Completion criterion: every criterion the ticket promises is on the list.

### 2. Settle your share

Work the list in order. For each criterion, exhaust your own evidence before ruling it residue: run the covering test, run the command, grep the tree, typecheck, launch the app. Residue is only what your tools genuinely cannot observe — the look of a live pane, a third-party dashboard, a delivered email.

Completion criterion: every criterion carries a verdict with its evidence, or is ruled residue with the unreachable evidence named.

### 3. Quiz the residue

One criterion per question, in order, each presented per the `questionnaire` skill — ask, wait for the answer, record the verdict, then the next. Each question gives the criterion verbatim, the exact steps to check (what to open, where to look), and what a pass looks like, with options mapping to the verdicts below. Map the answer: pass → **confirmed \<today\>** with what the user saw; fail → **unmet**; can't check now → the row stays open and is named in the report.

Completion criterion: every residue row has been asked singly and answered.

### 4. Report

Render the table — one row per criterion, verdict plus evidence, matching the vocabulary above. **unmet** rows go back into the loop as the next red test; open rows become the ticket's next action.

Completion criterion: every criterion is covered, confirmed, or untouched — or every unmet/open row is restated as the ticket's next action.
