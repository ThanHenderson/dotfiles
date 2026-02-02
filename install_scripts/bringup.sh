#!/usr/bin/env sh

# bringup.sh - Set up dotfiles using stow and install mise tools
# This script uses stow to symlink .mise.toml and then runs setup_mise.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

if ! command -v stow &> /dev/null; then
    echo "Error: stow is not installed."
    echo "Please install stow first"
    exit 1
fi

echo "Setting up mise configuration with stow..."
# Use stow to symlink the mise directory
# This will create ~/.mise.toml -> ~/dotfiles/mise/.mise.toml
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"
stow -d "$DOTFILES_DIR" -t "$HOME" mise

echo ""
echo "Running setup_mise.sh..."
if [ -f "$SCRIPT_DIR/setup_mise.sh" ]; then
    sh "$SCRIPT_DIR/setup_mise.sh"
else
    echo "Error: setup_mise.sh not found at $SCRIPT_DIR/setup_mise.sh"
    exit 1
fi

echo ""
echo "Bringup complete! mise configuration has been set up."
