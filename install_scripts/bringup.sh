#!/usr/bin/env sh

# bringup.sh - Set up pixi tools, optionally link dotfiles, and configure git
set -eu

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$SCRIPT_DIR"

link_once() {
    src="$1"
    dest="$2"
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "Skipping existing $dest"
        return 0
    fi
    ln -s "$src" "$dest"
}

echo "Running setup_pixi.sh..."
if [ -f "$SCRIPT_DIR/setup_pixi.sh" ]; then
    bash "$SCRIPT_DIR/setup_pixi.sh"
else
    echo "Error: setup_pixi.sh not found at $SCRIPT_DIR/setup_pixi.sh"
    exit 1
fi

export PATH="$HOME/.local/bin:$HOME/.pixi/bin:$HOME/.pixi/envs/acme/bin:$PATH"

echo ""
echo "Linking available tool configs..."
if command -v tmux >/dev/null 2>&1; then
    link_once "$DOTFILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
else
    echo "Skipping tmux config; tmux is not available."
fi

if command -v nvim >/dev/null 2>&1; then
    mkdir -p "$HOME/.config"
    link_once "$DOTFILES_DIR/nvim/.config/nvim" "$HOME/.config/nvim"
else
    echo "Skipping nvim config; nvim is not available."
fi

echo ""
printf "Link dotfiles now? (y/N): "
read -r link_dotfiles
case "$link_dotfiles" in
    y|Y|yes|YES)
        echo "Linking dotfiles..."
        if [ -f "$SCRIPT_DIR/link_dotfiles.sh" ]; then
            bash "$SCRIPT_DIR/link_dotfiles.sh"
        else
            echo "Error: link_dotfiles.sh not found at $SCRIPT_DIR/link_dotfiles.sh"
            exit 1
        fi
        ;;
esac

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

            printf "Git core.editor [nvim]: "
            read -r git_editor
            git_editor="${git_editor:-nvim}"
            if [ -n "$git_editor" ]; then
                git config --global core.editor "$git_editor"
            fi

            printf "Apply recommended git defaults? (Y/n): "
            read -r git_defaults
            case "$git_defaults" in
                n|N|no|NO)
                    ;;
                *)
                    git config --global push.autoSetupRemote true
                    git config --global fetch.prune true
                    ;;
            esac

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
echo "Bringup complete!"
