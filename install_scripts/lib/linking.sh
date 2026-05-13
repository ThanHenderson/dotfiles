#!/usr/bin/env sh
# shellcheck disable=SC2218

# Shared safe symlink helper for dotfile installers.
# Callers may set LINKING_PROMPT_NAME before sourcing.

: "${LINKING_PROMPT_NAME:=dotfiles}"

INTERACTIVE_REPLACE_ASKED=0
INTERACTIVE_REPLACE=0
BACKUP_ROOT=""

ask_interactive_replace() {
    if [ "$INTERACTIVE_REPLACE_ASKED" -eq 1 ]; then
        return 0
    fi

    INTERACTIVE_REPLACE_ASKED=1
    printf "\nInteractive replace existing %s? (y/N): " "$LINKING_PROMPT_NAME"
    if ! read -r replace_existing; then
        replace_existing=""
    fi
    case "$replace_existing" in
        y|Y|yes|YES) INTERACTIVE_REPLACE=1 ;;
    esac
}

backup_path_for() {
    dest="$1"
    if [ -z "$BACKUP_ROOT" ]; then
        BACKUP_ROOT="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/backups/$(date +%Y%m%d-%H%M%S)"
        mkdir -p "$BACKUP_ROOT"
    fi

    home_prefix="$HOME/"
    case "$dest" in
        "$HOME"/*) rel_path="${dest#"$home_prefix"}" ;;
        *) rel_path="${dest#/}" ;;
    esac

    backup_path="$BACKUP_ROOT/$rel_path"
    suffix=1
    while [ -e "$backup_path" ] || [ -L "$backup_path" ]; do
        backup_path="$BACKUP_ROOT/$rel_path.$suffix"
        suffix=$((suffix + 1))
    done

    BACKUP_PATH="$backup_path"
    BACKUP_REL_PATH="$rel_path"
}

link_once() {
    src="$1"
    dest="$2"

    mkdir -p "$(dirname "$dest")"

    if [ -L "$dest" ] && [ "$(readlink "$dest")" = "$src" ]; then
        echo "Already linked $dest"
        return 0
    fi

    if [ -e "$dest" ] || [ -L "$dest" ]; then
        ask_interactive_replace
        if [ "$INTERACTIVE_REPLACE" -ne 1 ]; then
            echo "Skipping existing $dest"
            return 0
        fi

        echo "Conflict: $dest already exists."
        printf "Replace it with a symlink to %s? (y/N): " "$src"
        if ! read -r replace_file; then
            replace_file=""
        fi
        case "$replace_file" in
            y|Y|yes|YES) ;;
            *)
                echo "Skipping existing $dest"
                return 0
                ;;
        esac

        backup_path_for "$dest"
        mkdir -p "$(dirname "$BACKUP_PATH")"
        mv "$dest" "$BACKUP_PATH"
        printf '%s\n' "$BACKUP_REL_PATH" >> "$BACKUP_ROOT/.backup-manifest"
        echo "Backed up $dest to $BACKUP_PATH"
    fi

    ln -s "$src" "$dest"
    echo "Linked $dest -> $src"
}
