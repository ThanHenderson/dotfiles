#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "Linking dotfiles with manual symlinks..."

mkdir -p "$HOME/.config"

INTERACTIVE_REPLACE_ASKED=0
INTERACTIVE_REPLACE=0
BACKUP_ROOT=""

ask_interactive_replace() {
  if [ "$INTERACTIVE_REPLACE_ASKED" -eq 1 ]; then
    return 0
  fi

  INTERACTIVE_REPLACE_ASKED=1
  printf "\nInteractive replace existing dotfiles? (y/N): "
  if ! read -r replace_existing; then
    replace_existing=""
  fi
  case "$replace_existing" in
    y|Y|yes|YES) INTERACTIVE_REPLACE=1 ;;
  esac
}

link_once() {
  src="$1"
  dest="$2"

  if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
    echo "Already linked $dest"
    return 0
  fi

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    ask_interactive_replace
    if [ "$INTERACTIVE_REPLACE" -ne 1 ]; then
      echo "Skipping existing $dest"
      return 0
    fi

    echo "Conflict: $dest already exists."
    printf "Replace it with a symlink to %s? (y/N): " "$src"
    if ! read -r replace_file; then
      replace_file=""
    fi
    case "$replace_file" in
      y|Y|yes|YES) ;;
      *)
        echo "Skipping existing $dest"
        return 0
        ;;
    esac

    if [ -z "$BACKUP_ROOT" ]; then
      BACKUP_ROOT="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/backups/$(date +%Y%m%d-%H%M%S)"
      mkdir -p "$BACKUP_ROOT"
    fi

    home_prefix="$HOME/"
    case "$dest" in
      "$HOME"/*) rel_path="${dest#"$home_prefix"}" ;;
      *) rel_path="${dest#/}" ;;
    esac

    backup_path="$BACKUP_ROOT/$rel_path"
    suffix=1
    while [ -e "$backup_path" ] || [ -L "$backup_path" ]; do
      backup_path="$BACKUP_ROOT/$rel_path.$suffix"
      suffix=$((suffix + 1))
    done

    mkdir -p "$(dirname "$backup_path")"
    mv "$dest" "$backup_path"
    printf '%s\n' "$rel_path" >> "$BACKUP_ROOT/.backup-manifest"
    echo "Backed up $dest to $backup_path"
    ln -s "$src" "$dest"
    echo "Linked $dest -> $src"
    return 0
  fi

  ln -s "$src" "$dest"
  echo "Linked $dest -> $src"
}

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
