#!/usr/bin/env bash

set -euo pipefail

BACKUP_BASE="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/backups"
RESTORE_BACKUP_BASE="${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/restore-backups"
DRY_RUN=0
ALLOW_SYMLINK_RESTORE=0

usage() {
  cat <<'EOF'
Usage:
  restore_backup.sh list
  restore_backup.sh show <timestamp|latest>
  restore_backup.sh restore <timestamp|latest> [--dry-run]

Backups are read from:
  ${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/backups
EOF
}

count_backup_paths() {
  backup_dir="$1"

  if [ -f "$backup_dir/.backup-manifest" ]; then
    wc -l < "$backup_dir/.backup-manifest" | tr -d ' '
  else
    count=0
    while IFS= read -r _path; do
      count=$((count + 1))
    done < <(find "$backup_dir" -mindepth 1 \( -type f -o -type l -o -type d \) ! -name '.backup-manifest' ! -name '.backup-info' 2>/dev/null)
    printf '%s' "$count"
  fi
}

list_backups() {
  echo "Backup root: $BACKUP_BASE"

  if [ ! -d "$BACKUP_BASE" ]; then
    echo "No backups found."
    return 0
  fi

  found=0
  while IFS= read -r backup_dir; do
    found=1
    timestamp="$(basename "$backup_dir")"
    count="$(count_backup_paths "$backup_dir")"
    printf '%s (%s paths)\n' "$timestamp" "$count"
  done < <(find "$BACKUP_BASE" -mindepth 1 -maxdepth 1 -type d | sort -r)

  if [ "$found" -eq 0 ]; then
    echo "No backups found."
  fi
}

resolve_backup() {
  requested="$1"

  if [ ! -d "$BACKUP_BASE" ]; then
    echo "Backup root does not exist: $BACKUP_BASE" >&2
    exit 1
  fi

  if [ "$requested" = "latest" ]; then
    resolved="$(find "$BACKUP_BASE" -mindepth 1 -maxdepth 1 -type d | sort -r | head -n 1)"
    if [ -z "$resolved" ]; then
      echo "No backups found in $BACKUP_BASE" >&2
      exit 1
    fi
    printf '%s' "$resolved"
    return 0
  fi

  resolved="$BACKUP_BASE/$requested"
  if [ ! -d "$resolved" ]; then
    echo "Backup does not exist: $resolved" >&2
    exit 1
  fi

  printf '%s' "$resolved"
}

relative_backup_paths() {
  backup_dir="$1"

  if [ -f "$backup_dir/.backup-manifest" ]; then
    sed '/^$/d' "$backup_dir/.backup-manifest" | sort -u
    return 0
  fi

  find "$backup_dir" -mindepth 1 \( -type f -o -type l -o -type d \) ! -name '.backup-manifest' ! -name '.backup-info' | sort | while IFS= read -r path; do
    rel="${path#"$backup_dir/"}"
    if [ -n "$rel" ]; then
      printf '%s\n' "$rel"
    fi
  done
}

show_backup() {
  backup_dir="$1"
  echo "Backup: $(basename "$backup_dir")"
  echo "Source: $backup_dir"
  echo ""

  relative_backup_paths "$backup_dir" | while IFS= read -r rel; do
    printf '%s -> %s\n' "$backup_dir/$rel" "$HOME/$rel"
  done
}

confirm() {
  prompt="$1"
  printf '%s (y/N): ' "$prompt"
  if ! read -r answer; then
    answer=""
  fi
  case "$answer" in
    y|Y|yes|YES) return 0 ;;
    *) return 1 ;;
  esac
}

ensure_restore_backup_root() {
  if [ -z "${RESTORE_BACKUP_ROOT:-}" ]; then
    RESTORE_BACKUP_ROOT="$RESTORE_BACKUP_BASE/$(date +%Y%m%d-%H%M%S)"
  fi
}

backup_existing_destination() {
  dest="$1"
  rel="$2"

  ensure_restore_backup_root
  backup_path="$RESTORE_BACKUP_ROOT/$rel"
  suffix=1
  while [ -e "$backup_path" ] || [ -L "$backup_path" ]; do
    backup_path="$RESTORE_BACKUP_ROOT/$rel.$suffix"
    suffix=$((suffix + 1))
  done

  if [ "$DRY_RUN" -eq 1 ]; then
    echo "Would back up current $dest to $backup_path"
    return 0
  fi

  mkdir -p "$(dirname "$backup_path")"
  mv "$dest" "$backup_path"
  echo "Backed up current $dest to $backup_path"
}

copy_backup_path() {
  src="$1"
  dest="$2"

  if [ "$DRY_RUN" -eq 1 ]; then
    echo "Would restore $dest from $src"
    return 0
  fi

  mkdir -p "$(dirname "$dest")"
  cp -pR "$src" "$dest"
  echo "Restored $dest from $src"
}

restore_one_path() {
  backup_dir="$1"
  rel="$2"
  src="$backup_dir/$rel"
  dest="$HOME/$rel"

  if [ -L "$dest" ]; then
    if [ "$ALLOW_SYMLINK_RESTORE" -ne 1 ]; then
      echo "Skipping symlink without confirmation: $dest"
      return 0
    fi

    if [ "$DRY_RUN" -eq 1 ]; then
      echo "Would remove symlink $dest"
    else
      rm "$dest"
      echo "Removed symlink $dest"
    fi
    copy_backup_path "$src" "$dest"
    return 0
  fi

  if [ -e "$dest" ]; then
    if ! confirm "Replace existing $dest with backup $src?"; then
      echo "Skipping existing $dest"
      return 0
    fi

    backup_existing_destination "$dest" "$rel"
    copy_backup_path "$src" "$dest"
    return 0
  fi

  copy_backup_path "$src" "$dest"
}

restore_backup() {
  backup_dir="$1"

  echo "Backup: $(basename "$backup_dir")"
  echo "Source: $backup_dir"
  if [ "$DRY_RUN" -eq 1 ]; then
    echo "Mode: dry-run"
  fi

  symlink_count=0
  while IFS= read -r rel; do
    dest="$HOME/$rel"
    if [ -L "$dest" ]; then
      symlink_count=$((symlink_count + 1))
    fi
  done < <(relative_backup_paths "$backup_dir")

  if [ "$symlink_count" -gt 0 ]; then
    if [ "$DRY_RUN" -eq 1 ]; then
      ALLOW_SYMLINK_RESTORE=1
      echo "Would remove $symlink_count symlink destination(s)."
    elif confirm "Restore will remove $symlink_count symlink destination(s). Proceed"; then
      ALLOW_SYMLINK_RESTORE=1
    else
      ALLOW_SYMLINK_RESTORE=0
    fi
  fi

  relative_backup_paths "$backup_dir" | while IFS= read -r rel; do
    restore_one_path "$backup_dir" "$rel"
  done
}

if [ "$#" -lt 1 ]; then
  usage
  exit 2
fi

command="$1"
shift

case "$command" in
  list)
    if [ "$#" -ne 0 ]; then
      usage
      exit 2
    fi
    list_backups
    ;;
  show)
    if [ "$#" -ne 1 ]; then
      usage
      exit 2
    fi
    show_backup "$(resolve_backup "$1")"
    ;;
  restore)
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
      usage
      exit 2
    fi
    requested="$1"
    shift
    if [ "$#" -eq 1 ]; then
      case "$1" in
        --dry-run) DRY_RUN=1 ;;
        *) usage; exit 2 ;;
      esac
    fi
    restore_backup "$(resolve_backup "$requested")"
    ;;
  *)
    usage
    exit 2
    ;;
esac
