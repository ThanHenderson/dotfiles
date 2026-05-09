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

install_npm_cli() {
    package="$1"
    binary="$2"
    pixi_npm="$HOME/.pixi/envs/acme/bin/npm"

    if command -v "$binary" >/dev/null 2>&1; then
        echo "$binary is already installed."
        return 0
    fi

    if [ ! -x "$pixi_npm" ]; then
        echo "Skipping $package; pixi npm is not available at $pixi_npm."
        return 0
    fi

    echo "Installing $package with pixi npm..."
    NPM_CONFIG_PREFIX="$HOME/.local" "$pixi_npm" install -g "$package"
}

prompt_install_npm_cli() {
    name="$1"
    package="$2"
    binary="$3"

    printf "\nInstall %s? (y/N): " "$name"
    read -r install_cli
    case "$install_cli" in
        y|Y|yes|YES)
            install_npm_cli "$package" "$binary"
            ;;
        *)
            echo "Skipping $name."
            ;;
    esac
}

prompt_install_cursor_cli() {
    printf "\nInstall Cursor CLI? (y/N): "
    read -r install_cursor
    case "$install_cursor" in
        y|Y|yes|YES)
            if command -v cursor-agent >/dev/null 2>&1; then
                echo "cursor-agent is already installed."
            elif ! command -v curl >/dev/null 2>&1; then
                echo "Skipping Cursor CLI; curl is not available."
            else
                echo "Installing Cursor CLI..."
                cursor_installer="$(mktemp)"
                curl https://cursor.com/install -fsS -o "$cursor_installer"
                bash "$cursor_installer"
                rm -f "$cursor_installer"
            fi
            ;;
        *)
            echo "Skipping Cursor CLI."
            ;;
    esac
}

install_ai_clis() {
    mkdir -p "$HOME/.local/bin"
    export PATH="$HOME/.local/bin:$HOME/.pixi/envs/acme/bin:$PATH"
    export NPM_CONFIG_PREFIX="$HOME/.local"

    prompt_install_cursor_cli
    prompt_install_npm_cli "Claude Code" "@anthropic-ai/claude-code" "claude"
    prompt_install_npm_cli "Codex" "@openai/codex" "codex"
    prompt_install_npm_cli "OpenCode" "opencode-ai" "opencode"
}

link_opencode_config() {
    if command -v opencode >/dev/null 2>&1; then
        mkdir -p "$HOME/.config"
        link_once "$DOTFILES_DIR/opencode/.config/opencode" "$HOME/.config/opencode"
    else
        echo "Skipping opencode config; opencode is not available."
    fi
}

sync_nvim_plugins() {
    if ! command -v nvim >/dev/null 2>&1; then
        return 0
    fi

    printf "\nSync Neovim plugins now? (Y/n): "
    read -r sync_nvim
    case "$sync_nvim" in
        n|N|no|NO)
            ;;
        *)
            echo "Syncing Neovim plugins..."
            if nvim --headless '+PackSync' '+qa'; then
                echo "Neovim plugins synced."
            else
                echo "Warning: Neovim plugin sync failed. Run :PackSync later from Neovim."
            fi
            ;;
    esac
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

sync_nvim_plugins
install_ai_clis
link_opencode_config

echo ""
echo "Bringup complete!"
