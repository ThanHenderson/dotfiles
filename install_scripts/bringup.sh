#!/usr/bin/env sh

# bringup.sh - Set up dotfiles and install pixi tools
set -eu

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
echo "Linking dotfiles..."
if [ -f "$SCRIPT_DIR/link_dotfiles.sh" ]; then
    bash "$SCRIPT_DIR/link_dotfiles.sh"
else
    echo "Error: link_dotfiles.sh not found at $SCRIPT_DIR/link_dotfiles.sh"
    exit 1
fi

if command -v git >/dev/null 2>&1; then
    printf "\nConfigure git now? (y/N): "
    read -r configure_git
    case "$configure_git" in
        y|Y|yes|YES)
            printf "Git user.name: "
            read -r git_name
            printf "Git user.email: "
            read -r git_email

            if [ -n "$git_name" ]; then
                git config --global user.name "$git_name"
            fi
            if [ -n "$git_email" ]; then
                git config --global user.email "$git_email"
            fi

            printf "Enable commit GPG signing by default? (y/N): "
            read -r git_gpgsign
            case "$git_gpgsign" in
                y|Y|yes|YES)
                    git config --global commit.gpgsign true
                    ;;
            esac
            ;;
    esac
fi

echo ""
echo "Bringup complete! pixi and dotfiles have been set up."
