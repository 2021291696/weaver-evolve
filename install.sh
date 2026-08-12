#!/usr/bin/env bash
# weaver-evolve dual-platform skill installer
# Usage: bash install.sh [--platform codex|claude|all] [--force] [--dry-run]
set -euo pipefail

PLATFORM="all"
FORCE=false
DRY_RUN=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --platform)
      [[ $# -ge 2 ]] || { echo "Missing value for --platform"; exit 1; }
      case "$2" in
        codex|Codex|CODEX) PLATFORM="codex" ;;
        claude|Claude|CLAUDE) PLATFORM="claude" ;;
        all|All|ALL) PLATFORM="all" ;;
        *) echo "Unsupported platform: $2 (use codex, claude, or all)"; exit 1 ;;
      esac
      shift 2
      ;;
    --force) FORCE=true; shift ;;
    --dry-run) DRY_RUN=true; shift ;;
    *)
      echo "Usage: bash install.sh [--platform codex|claude|all] [--force] [--dry-run]"
      exit 1
      ;;
  esac
done

case "$PLATFORM" in
  codex|claude|all) ;;
  *) echo "Unsupported platform: $PLATFORM (use codex, claude, or all)"; exit 1 ;;
esac

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CODEX_SKILLS_DIR="${CODEX_SKILLS:-$HOME/.agents/skills}"
CLAUDE_SKILLS_DIR="${CLAUDE_SKILLS:-$HOME/.claude/skills}"
SKILLS=("weaver-自我迭代" "file-tidy" "memory-keeper" "debug-architect")

install_platform() {
  local label="$1"
  local source_root="$2"
  local target_root="$3"
  local installed=0
  local skipped=0

  echo "--- $label ---"
  echo "Source: $source_root"
  echo "Target: $target_root"

  if $DRY_RUN; then
    for skill in "${SKILLS[@]}"; do
      echo "  [dry-run] $skill"
    done
    echo ""
    return
  fi

  mkdir -p "$target_root"
  for skill in "${SKILLS[@]}"; do
    local source="$source_root/$skill"
    local target="$target_root/$skill"

    if [[ ! -d "$source" ]]; then
      echo "Error: missing source skill: $source" >&2
      exit 1
    fi

    if [[ -e "$target" ]] && ! $FORCE; then
      echo "  SKIP $skill (already exists; use --force to overwrite)"
      skipped=$((skipped + 1))
      continue
    fi

    if [[ -e "$target" ]]; then
      rm -rf -- "$target"
    fi
    cp -R -- "$source" "$target"
    echo "  OK   $skill"
    installed=$((installed + 1))
  done

  echo "Result: $installed installed, $skipped skipped"
  echo ""
}

echo "=== weaver-evolve installer ==="
echo "Platform: $PLATFORM"
echo ""

if [[ "$PLATFORM" == "codex" || "$PLATFORM" == "all" ]]; then
  install_platform "OpenAI Codex" "$SCRIPT_DIR/skills/codex" "$CODEX_SKILLS_DIR"
fi

if [[ "$PLATFORM" == "claude" || "$PLATFORM" == "all" ]]; then
  install_platform "Claude Code" "$SCRIPT_DIR/skills" "$CLAUDE_SKILLS_DIR"
fi
