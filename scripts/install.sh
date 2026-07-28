#!/usr/bin/env bash
# Copy the framework's skills into a target project's .claude/skills/
# Usage: scripts/install.sh /path/to/project
set -euo pipefail

TARGET="${1:?usage: install.sh <target-project-dir>}"
FRAMEWORK_DIR="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$TARGET/.claude/skills"

mkdir -p "$DEST"
for skill in "$FRAMEWORK_DIR"/skills/*/; do
  name="$(basename "$skill")"
  if [ -e "$DEST/$name" ]; then
    echo "skip  $name (already exists — remove it to reinstall)"
  else
    cp -R "$skill" "$DEST/$name"
    echo "add   $name"
  fi
done

echo
echo "Installed into $DEST"
echo "Note: the checkpoint-guard hook ships only with the plugin install"
echo "      (/plugin install dev-framework@dev-framework)."
echo "Next: open the project in your agent and run /dev"
