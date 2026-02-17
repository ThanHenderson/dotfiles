#!/usr/bin/env sh

set -eu

if ! command -v pixi &> /dev/null; then
    echo "Installing pixi..."
    curl -fsSL https://pixi.sh/install.sh | bash
else
    echo "pixi is already installed."
fi

export PATH="$HOME/.pixi/bin:$PATH"

append_line_once_regex() {
    file="$1"
    line="$2"
    pattern="$3"
    if [ -f "$file" ]; then
        if ! grep -Eq "$pattern" "$file"; then
            printf "%s\n" "$line" >> "$file"
        fi
    fi
}

append_line_once_regex "$HOME/.profile" \
    'export PATH="$HOME/.pixi/bin:$PATH"' \
    '\.pixi/bin'

append_line_once_regex "$HOME/.profile" \
    'export PATH="$HOME/.pixi/envs/acme/bin:$PATH"' \
    '\.pixi/envs/acme/bin'

append_line_once_regex "$HOME/.zshrc" 'if command -v fzf &> /dev/null; then source <(fzf --zsh); fi' 'fzf[[:space:]]+--zsh'
append_line_once_regex "$HOME/.zshrc" 'if command -v zoxide &> /dev/null; then eval "$(zoxide init zsh)"; fi' 'zoxide[[:space:]]+init[[:space:]]+zsh'
append_line_once_regex "$HOME/.bashrc" 'if command -v fzf &> /dev/null; then source <(fzf --bash); fi' 'fzf[[:space:]]+--bash'
append_line_once_regex "$HOME/.bashrc" 'if command -v zoxide &> /dev/null; then eval "$(zoxide init bash)"; fi' 'zoxide[[:space:]]+init[[:space:]]+bash'

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_GLOBAL_MANIFEST="$SCRIPT_DIR/../pixi/.pixi/manifests/pixi-global.toml"

if [ -f "$DOTFILES_GLOBAL_MANIFEST" ]; then
    echo "Symlinking pixi global manifest from dotfiles..."
    mkdir -p "$HOME/.pixi/manifests"
    ln -sf "$DOTFILES_GLOBAL_MANIFEST" "$HOME/.pixi/manifests/pixi-global.toml"
    echo "Symlinked $DOTFILES_GLOBAL_MANIFEST -> $HOME/.pixi/manifests/pixi-global.toml"
fi

if [ -f "$HOME/.pixi/manifests/pixi-global.toml" ]; then
    echo "Installing pixi tools from global manifest..."
    pixi global sync
else
    echo "No pixi global manifest found - skipping tool installation"
fi

echo "Setup complete! Restart your shell or source your profile to use pixi tools."
