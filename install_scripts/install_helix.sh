#!/bin/bash

# Define installation directories
INSTALL_DIR="$HOME/bin"
RUNTIME_DIR="$HOME/.config/helix/runtime"
CONTRIB_DIR="$HOME/.local/share/helix/contrib"

# Create necessary directories
mkdir -p "$INSTALL_DIR" "$RUNTIME_DIR" "$CONTRIB_DIR"

# Function to detect platform and architecture
detect_platform() {
  OS=$(uname -s)
  ARCH=$(uname -m)

  if [[ "$OS" == "Linux" ]]; then
    PLATFORM="linux"
  elif [[ "$OS" == "Darwin" ]]; then
    PLATFORM="macos"
  else
    echo "Unsupported operating system: $OS"
    exit 1
  fi

  if [[ "$ARCH" == "x86_64" ]]; then
    ARCH="x86_64"
  elif [[ "$ARCH" == "arm64" ]]; then
    ARCH="aarch64"  # Helix uses "aarch64" for ARM
  else
    echo "Unsupported architecture: $ARCH"
    exit 1
  fi

  echo "$ARCH-$PLATFORM"
}

# Detect platform and architecture
ARCH_PLATFORM=$(detect_platform)

# Download the latest Helix release
echo "Fetching the latest Helix release..."
LATEST_VERSION=$(curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | grep '"tag_name"' | sed -E 's/.*"tag_name": *"([^"]+)".*/\1/')
VERSION_PLATFORM="$LATEST_VERSION-$ARCH_PLATFORM"

DOWNLOAD_URL="https://github.com/helix-editor/helix/releases/download/$LATEST_VERSION/helix-$VERSION_PLATFORM.tar.xz"
curl -L "$DOWNLOAD_URL" -o helix.tar.xz

# Extract the downloaded file
echo "Extracting Helix..."
tar -xf helix.tar.xz

# Move the Helix binary to ~/bin
echo "Installing Helix binary to $INSTALL_DIR..."
mv helix-$VERSION_PLATFORM/hx "$INSTALL_DIR/"

# Move the runtime folder to ~/.config/helix/runtime
echo "Installing runtime files to $RUNTIME_DIR..."
mv helix-$VERSION_PLATFORM/runtime "$RUNTIME_DIR"

# Move the contrib folder to ~/.local/share/helix/contrib
echo "Moving contrib files to $CONTRIB_DIR..."
mv helix-$VERSION_PLATFORM/contrib "$CONTRIB_DIR"

# Clean up temporary files
echo "Cleaning up..."
rm -rf helix.tar.xz helix-$VERSION_PLATFORM

# Add ~/bin to PATH if not already present
if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
  echo "Adding $INSTALL_DIR to PATH in ~/.bashrc or ~/.zshrc..."
  if [[ -f "$HOME/.bashrc" ]]; then
    echo "export PATH=\$PATH:$INSTALL_DIR" >> "$HOME/.bashrc"
  fi
  if [[ -f "$HOME/.zshrc" ]]; then
    echo "export PATH=\$PATH:$INSTALL_DIR" >> "$HOME/.zshrc"
  fi
fi

# Add HELIX_RUNTIME to the environment
if ! grep -q "HELIX_RUNTIME" "$HOME/.bashrc" && ! grep -q "HELIX_RUNTIME" "$HOME/.zshrc"; then
  echo "Adding HELIX_RUNTIME to shell configuration..."
  if [[ -f "$HOME/.bashrc" ]]; then
    echo "export HELIX_RUNTIME=$RUNTIME_DIR" >> "$HOME/.bashrc"
  fi
  if [[ -f "$HOME/.zshrc" ]]; then
    echo "export HELIX_RUNTIME=$RUNTIME_DIR" >> "$HOME/.zshrc"
  fi
fi

echo "Installation complete! Run 'source ~/.bashrc' or 'source ~/.zshrc' to apply changes, or restart your terminal."
"$INSTALL_DIR/hx" --version
