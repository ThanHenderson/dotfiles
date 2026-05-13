#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "Linking dotfiles with manual symlinks..."

mkdir -p "$HOME/.config"

# shellcheck disable=SC2034
LINKING_PROMPT_NAME="dotfiles"
# shellcheck source=install_scripts/lib/linking.sh
. "$SCRIPT_DIR/lib/linking.sh"

link_once "$DOTFILES_DIR/shell/.bash_profile" "$HOME/.bash_profile"
link_once "$DOTFILES_DIR/shell/.bashrc" "$HOME/.bashrc"
link_once "$DOTFILES_DIR/shell/.profile" "$HOME/.profile"
link_once "$DOTFILES_DIR/shell/.zprofile" "$HOME/.zprofile"
link_once "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc"

link_once "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
link_once "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"
link_once "$DOTFILES_DIR/p10k/.p10k.zsh" "$HOME/.p10k.zsh"

link_once "$DOTFILES_DIR/nvim/.config/nvim" "$HOME/.config/nvim"
link_once "$DOTFILES_DIR/alacritty/.config/alacritty" "$HOME/.config/alacritty"
link_once "$DOTFILES_DIR/htop/.config/htop" "$HOME/.config/htop"
link_once "$DOTFILES_DIR/helix/.config/helix" "$HOME/.config/helix"
link_once "$DOTFILES_DIR/vscode/.config/Code" "$HOME/.config/Code"

if [ -f "$SCRIPT_DIR/link_llm.sh" ]; then
  bash "$SCRIPT_DIR/link_llm.sh"
fi

if [ "$(uname -s)" = "Darwin" ] && command -v aerospace >/dev/null 2>&1; then
  link_once "$DOTFILES_DIR/aerospace/.aerospace.toml" "$HOME/.aerospace.toml"
fi
