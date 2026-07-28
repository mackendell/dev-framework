#!/usr/bin/env bash
# Stop hook: hold the turn open while .dev/PROGRESS.md lags the commits,
# so /checkpoint runs before the session can be cleared with stale state.
# Silent in projects that don't use the framework.
set -euo pipefail

input="$(cat)"
# A previous block this turn already asked for the checkpoint — let the turn end.
case "$input" in
  *'"stop_hook_active":true'*) exit 0 ;;
esac

[ -f .dev/PROGRESS.md ] || exit 0
git rev-parse --git-dir >/dev/null 2>&1 || exit 0

stale=0
if git ls-files --error-unmatch .dev/PROGRESS.md >/dev/null 2>&1; then
  # Tracked. Uncommitted edits to it mean a checkpoint just happened — fresh.
  if git diff --quiet -- .dev/PROGRESS.md && git diff --cached --quiet -- .dev/PROGRESS.md; then
    last="$(git log -1 --format=%H -- .dev/PROGRESS.md 2>/dev/null || true)"
    if [ -n "$last" ]; then
      if [ "$(git rev-list --count "$last"..HEAD)" -gt 0 ]; then
        stale=1
      fi
    fi
  fi
else
  # Untracked or gitignored: compare its mtime against the last commit.
  commit_ts="$(git log -1 --format=%ct 2>/dev/null || echo 0)"
  file_ts="$(stat -f %m .dev/PROGRESS.md 2>/dev/null || stat -c %Y .dev/PROGRESS.md 2>/dev/null || echo 0)"
  if [ "$commit_ts" -gt "$file_ts" ]; then
    stale=1
  fi
fi

[ "$stale" -eq 1 ] || exit 0

cat <<'JSON'
{"decision": "block", "reason": "Commits have landed since .dev/PROGRESS.md was last checkpointed. Fire /checkpoint so its Next action reflects reality — commit the update if the file is tracked — then finish the turn."}
JSON
exit 0
