---
name: continue
description: "Resume the current effort in a fresh session — reads .dev/PROGRESS.md, verifies the next action, and runs it on your confirmation."
disable-model-invocation: true
---

# Continue

Pick the effort back up in a fresh session. `.dev/PROGRESS.md` is the index, not the archive — read it, then zoom into what it points at only as needed.

1. Read `.dev/PROGRESS.md`. Absent → there is no effort to resume; suggest `/dev`.
2. Orient against reality: `git log --oneline -10`, plus any handoff files the index points at — a handoff carries the conversation the previous session couldn't.
3. Verify the **Next action** is still true (tickets may have closed, files may have moved). If stale, correct it and `/checkpoint` the correction.
4. State the effort and the next action to the user in two lines, confirm (per the `questionnaire` skill), then run it.

Completion criterion: the next action is running with the user's confirmation — or the corrected one is checkpointed and confirmed instead.
