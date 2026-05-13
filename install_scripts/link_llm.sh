#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
LLM_DIR="$DOTFILES_DIR/llm"

# shellcheck disable=SC2034
LINKING_PROMPT_NAME="LLM config files"
# shellcheck source=install_scripts/lib/linking.sh
. "$SCRIPT_DIR/lib/linking.sh"

migrate_old_managed_dir() {
  dest="$1"
  old_src="$2"

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$old_src" ]; then
    rm "$dest"
    mkdir -p "$dest"
    echo "Migrated old managed symlink $dest into a directory"
  else
    mkdir -p "$dest"
  fi
}

echo "Linking LLM configs..."

migrate_old_managed_dir "$HOME/.claude" "$DOTFILES_DIR/.claude"
migrate_old_managed_dir "$HOME/.codex" "$DOTFILES_DIR/.codex"
migrate_old_managed_dir "$HOME/.config/opencode" "$DOTFILES_DIR/opencode/.config/opencode"

mkdir -p "$HOME/.agents"

link_once "$LLM_DIR/skills" "$HOME/.agents/skills"
link_once "$LLM_DIR/skills" "$HOME/.claude/skills"
link_once "$LLM_DIR/skills" "$HOME/.config/opencode/skills"

link_once "$LLM_DIR/targets/claude/CLAUDE.md" "$HOME/.claude/CLAUDE.md"

link_once "$LLM_DIR/targets/codex/AGENTS.md" "$HOME/.codex/AGENTS.md"
link_once "$LLM_DIR/targets/codex/config.toml" "$HOME/.codex/config.toml"

link_once "$LLM_DIR/targets/opencode/AGENTS.md" "$HOME/.config/opencode/AGENTS.md"
link_once "$LLM_DIR/targets/opencode/opencode.jsonc" "$HOME/.config/opencode/opencode.jsonc"
link_once "$LLM_DIR/targets/opencode/commands" "$HOME/.config/opencode/commands"

"$LLM_DIR/scripts/render-agent-targets.sh"
