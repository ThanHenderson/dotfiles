#!/usr/bin/env sh

set -e

# Install mise
if ! command -v mise &> /dev/null
then
    echo "Installing mise..."
    curl https://mise.run/zsh | sh
else
    echo "mise is already installed."
fi

# Add mise activation to shell rc files if they exist
if [ -f ~/.zshrc ]; then
    if ! grep -q 'mise activate zsh' ~/.zshrc; then
        cat <<'EOF' >> ~/.zshrc
if command -v mise &> /dev/null; then
  eval "$(mise activate zsh)"
fi
EOF
        echo "Added guarded mise activation to ~/.zshrc"
    else
        echo "mise activation already present in ~/.zshrc"
    fi
fi

if [ -f ~/.bashrc ]; then
    if ! grep -q 'mise activate bash' ~/.bashrc; then
        cat <<'EOF' >> ~/.bashrc
if command -v mise &> /dev/null; then
  eval "$(mise activate bash)"
fi
EOF
        echo "Added guarded mise activation to ~/.bashrc"
    else
        echo "mise activation already present in ~/.bashrc"
    fi
fi

# Install mise tools
if [ -f $HOME/.mise.toml ]; then
    echo "Trusting mise configuration..."
    mise trust $HOME/.mise.toml
    echo "Installing mise tools..."
    mise install
fi

# Configure git via mise task
if command -v mise &> /dev/null; then
    echo "Configuring git..."
    mise run configure-git
fi
