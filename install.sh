#!/bin/bash
# weaver-evolve skill cluster installer
# Usage: bash install.sh [--force] [--dry-run]
set -e

FORCE=false
DRY_RUN=false
for arg in "$@"; do
  case "$arg" in
    --force) FORCE=true ;;
    --dry-run) DRY_RUN=true ;;
    *) echo "Usage: bash install.sh [--force] [--dry-run]"; exit 1 ;;
  esac
done

SKILLS_DIR="${CLAUDE_SKILLS:-$HOME/.claude/skills}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

SKILLS=(
  "weaver-自我迭代"
  "file-tidy"
  "memory-keeper"
  "debug-architect"
  "skill-optimizer"
)

echo "=== weaver-evolve skill cluster installer ==="
echo "Target: $SKILLS_DIR"
echo ""

if $DRY_RUN; then
  echo "[dry-run] Would install these skills:"
  for skill in "${SKILLS[@]}"; do
    echo "  - $skill"
  done
  exit 0
fi

INSTALLED=0
SKIPPED=0
for skill in "${SKILLS[@]}"; do
  target="$SKILLS_DIR/$skill"
  source="$SCRIPT_DIR/$skill"
  if [ -e "$target" ] && ! $FORCE; then
    echo "⚠ $skill already exists, use --force to overwrite"
    SKIPPED=$((SKIPPED + 1))
  else
    if [ -e "$target" ]; then
      rm -rf "$target"
    fi
    cp -r "$source" "$target"
    echo "✓ $skill installed"
    INSTALLED=$((INSTALLED + 1))
  fi
done

echo ""
echo "Done: $INSTALLED installed, $SKIPPED skipped"
