---
name: check-upstream
description: Check the vendored upstream repos (mattpocock/skills, Nutlope/hallmark) for new or changed skills and merge the updates in. Run it every few weeks, or when either upstream announces something new.
disable-model-invocation: true
---

# Check Upstream

The skills in this repo are **vendored** — copied from upstreams at a pinned commit so they can be hacked on locally. `upstream.lock.json` at the repo root records each source: repo, the paths tracked, and the commit the vendored copy came from. This skill diffs each upstream against its pin, presents what changed, and updates only what the user picks.

## Process

1. **Read the lock.** Each entry: `repo`, `paths` (upstream paths that map into `skills/`), `commit` (the pin), `mapping` notes.
2. **Fetch the current tip** of each upstream's default branch (`gh api repos/<repo>/commits/<branch> --jq .sha`). Tip equals pin → that upstream is up to date; say so and move on.
3. **Diff pin → tip** scoped to the tracked paths (`gh api "repos/<repo>/compare/<pin>...<tip>"`), and sort the changed files into:
   - **New skills** — upstream folders with a `SKILL.md` that don't exist under `skills/` here
   - **Updated** — tracked files changed upstream and untouched locally
   - **Diverged** — changed upstream **and** edited locally since vendoring (`git log` on the local copy tells you)
   - **Deprecated/removed** — deleted upstream or moved into a deprecated folder
4. **Present the report** grouped exactly like that, each item one line with the upstream commit message that touched it. Then ask which groups (or single items) to take.
5. **Apply.** Download the chosen files at `<tip>` and copy them over the local paths. For each *diverged* file show the local edit vs the upstream change first, and merge only as directed — local hacks are the point of vendoring, treat them as authored code.
6. **Re-pin.** Set each reviewed upstream's `commit` to `<tip>` in `upstream.lock.json` — including upstreams where nothing was taken, so the next run reports only what's new since this review. Commit the update with a message listing what was taken and what was declined.

Adding a new upstream to track is one new entry in the lock plus a first vendoring pass — same steps from 2.

Completion criterion: every lock entry pinned at the tip you reviewed, every taken file identical to its upstream version (or deliberately merged), and the report delivered even when the answer is "everything is current".
