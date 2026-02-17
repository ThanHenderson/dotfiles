#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "Linking dotfiles with manual symlinks..."

mkdir -p "$HOME/.config"

link_once() {
  src="$1"
  dest="$2"
  if [ -e "$dest" ] || [ -L "$dest" ]; then
    echo "Skipping existing $dest"
    return 0
  fi
  ln -s "$src" "$dest"
}

link_once "$DOTFILES_DIR/shell/.bash_profile" "$HOME/.bash_profile"
link_once "$DOTFILES_DIR/shell/.bashrc" "$HOME/.bashrc"
link_once "$DOTFILES_DIR/shell/.profile" "$HOME/.profile"
link_once "$DOTFILES_DIR/shell/.zprofile" "$HOME/.zprofile"
link_once "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc"

link_once "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
link_once "$DOTFILES_DIR/vim/.vimrc" "$HOME/.vimrc"
link_once "$DOTFILES_DIR/p10k/.p10k.zsh" "$HOME/.p10k.zsh"
link_once "$DOTFILES_DIR/.codex" "$HOME/.codex"
link_once "$DOTFILES_DIR/.claude" "$HOME/.claude"

link_once "$DOTFILES_DIR/nvim/.config/nvim" "$HOME/.config/nvim"
link_once "$DOTFILES_DIR/alacritty/.config/alacritty" "$HOME/.config/alacritty"
link_once "$DOTFILES_DIR/htop/.config/htop" "$HOME/.config/htop"
link_once "$DOTFILES_DIR/helix/.config/helix" "$HOME/.config/helix"
link_once "$DOTFILES_DIR/vscode/.config/Code" "$HOME/.config/Code"
