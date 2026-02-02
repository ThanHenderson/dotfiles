#!/usr/bin/env sh

set -e

# Install pixi
if ! command -v pixi &> /dev/null; then
    echo "Installing pixi..."
    curl -fsSL https://pixi.sh/install.sh | bash
else
    echo "pixi is already installed."
fi

export PATH="$HOME/.pixi/bin:$PATH"

# Add pixi to PATH in shell rc files if they exist
if [ -f ~/.zshrc ]; then
    if ! grep -q '.pixi/bin' ~/.zshrc; then
        cat <<'EOF' >> ~/.zshrc
# Added by pixi setup
export PATH="$HOME/.pixi/bin:$PATH"
EOF
        echo "Added pixi to PATH in ~/.zshrc"
    else
        echo "pixi PATH already present in ~/.zshrc"
    fi
fi

if [ -f ~/.bashrc ]; then
    if ! grep -q '.pixi/bin' ~/.bashrc; then
        cat <<'EOF' >> ~/.bashrc
export PATH="$HOME/.pixi/bin:$PATH"
EOF
        echo "Added pixi to PATH in ~/.bashrc"
    else
        echo "pixi PATH already present in ~/.bashrc"
    fi
fi

# Manually symlink pixi global manifest
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DOTFILES_GLOBAL_MANIFEST="$SCRIPT_DIR/../pixi/.pixi/manifests/pixi-global.toml"

if [ -f "$DOTFILES_GLOBAL_MANIFEST" ]; then
    echo "Symlinking pixi global manifest from dotfiles..."
    mkdir -p "$HOME/.pixi/manifests"
    ln -sf "$DOTFILES_GLOBAL_MANIFEST" "$HOME/.pixi/manifests/pixi-global.toml"
    echo "Symlinked $DOTFILES_GLOBAL_MANIFEST -> $HOME/.pixi/manifests/pixi-global.toml"
fi

# Install tools from global manifest
if [ -f "$HOME/.pixi/manifests/pixi-global.toml" ]; then
    echo "Installing pixi tools from global manifest..."
    pixi global sync

    if command -v git &> /dev/null; then
        echo "Configuring git..."
        git config --global user.name "than"
        git config --global user.email "than.henderson@proton.me"
        git config --global commit.gpgsign true
    fi
else
    echo "No pixi global manifest found - skipping tool installation"
fi

echo "Setup complete! Restart your shell or source your rc file to use pixi tools."
