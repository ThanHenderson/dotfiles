#!/usr/bin/env sh

set -eu

# Keep the install root and PATH consistent even when CARGO_HOME is customized.
export PATH="$HOME/.cargo/bin:$HOME/.pixi/bin:$HOME/.pixi/envs/acme/bin:$PATH"

treesitter_is_compatible() {
    tree-sitter --version 2>/dev/null | awk '
        $1 == "tree-sitter" && $2 ~ /^[0-9]+\.[0-9]+\.[0-9]+$/ {
            split($2, version, ".")
            if (version[1] > 0 || version[2] > 26 ||
                (version[2] == 26 && version[3] >= 1)) compatible = 1
        }
        END { exit !compatible }
    '
}

if treesitter_is_compatible; then
    echo "Tree-sitter CLI is already installed (>=0.26.1)."
    exit 0
fi

if ! command -v cargo >/dev/null 2>&1; then
    echo "Error: Cargo is required to install Tree-sitter CLI. Run setup_pixi.sh first." >&2
    exit 1
fi

echo "Installing Tree-sitter CLI with Cargo (>=0.26.1)..."
cargo install tree-sitter-cli --locked --version '>=0.26.1' --root "$HOME/.cargo"

if ! treesitter_is_compatible; then
    echo "Error: Tree-sitter CLI >=0.26.1 is not available after installation." >&2
    exit 1
fi
