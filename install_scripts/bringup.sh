#!/usr/bin/env sh

# bringup.sh - Set up dotfiles and install pixi tools
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

echo "Running setup_pixi.sh..."
if [ -f "$SCRIPT_DIR/setup_pixi.sh" ]; then
    bash "$SCRIPT_DIR/setup_pixi.sh"
else
    echo "Error: setup_pixi.sh not found at $SCRIPT_DIR/setup_pixi.sh"
    exit 1
fi

echo ""
echo "Bringup complete! pixi configuration has been set up."