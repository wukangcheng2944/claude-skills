#!/usr/bin/env bash
# Install all skills by symlinking into ~/.claude/skills/
set -euo pipefail

SKILLS_DIR="${HOME}/.claude/skills"
REPO_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p "$SKILLS_DIR"

installed=0
for skill_dir in "$REPO_DIR"/*/; do
    [ -f "$skill_dir/SKILL.md" ] || continue
    skill_name="$(basename "$skill_dir")"
    target="$SKILLS_DIR/$skill_name"

    if [ -L "$target" ]; then
        echo "  update: $skill_name"
        rm "$target"
    elif [ -d "$target" ]; then
        echo "  skip: $skill_name (already exists as directory, remove manually to use symlink)"
        continue
    else
        echo "  install: $skill_name"
    fi

    ln -sf "$skill_dir" "$target"
    installed=$((installed + 1))
done

echo ""
echo "Done. $installed skill(s) linked to $SKILLS_DIR"
