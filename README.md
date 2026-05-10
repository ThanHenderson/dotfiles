# Dotfiles

Personal dotfiles and setup scripts for shell, terminal, editor, AI tooling, and shared CLI tools.

The primary entry point is `install_scripts/bringup.sh`. It favors interactive setup, skips existing files by default, and uses Pixi as the shared package/tool manager.

## Quick Start

```sh
git clone git@github.com:ThanHenderson/dotfiles.git ~/dotfiles
cd ~/dotfiles
sh install_scripts/bringup.sh
```

`bringup.sh` is interactive. It installs/syncs Pixi tools, links a small set of available tool configs, asks whether to link all dotfiles, optionally configures git, optionally syncs Neovim plugins, and prompts for AI CLI installs.

## Bringup Flow

- `install_scripts/setup_pixi.sh` installs Pixi if needed, links `pixi/.pixi/manifests/pixi-global.toml` into `~/.pixi/manifests/pixi-global.toml`, and runs `pixi global sync`.
- `bringup.sh` links tmux and Neovim configs early when those tools are available.
- Full dotfile linking is optional and delegates to `install_scripts/link_dotfiles.sh`.
- Git configuration is optional and prompt-driven.
- Neovim plugin sync is optional and only runs when `nvim` is available.
- AI CLI installation is optional for Cursor, Claude Code, Codex, and OpenCode.

## Linking And Backups

Dotfile linking uses manual symlinks through `link_once` in `install_scripts/link_dotfiles.sh` and `install_scripts/bringup.sh`.

Existing files are skipped by default. If interactive replacement is enabled, each conflicting file still requires confirmation before it is moved aside and replaced with a symlink.

Backups are written under:

```text
${XDG_STATE_HOME:-$HOME/.local/state}/dotfiles/backups/<timestamp>/
```

## Package Strategy

- Pixi is the default path for shared tools, runtimes, editors, language servers, and common CLI utilities.
- The Pixi global manifest lives at `pixi/.pixi/manifests/pixi-global.toml`.
- Mise is present but optional. `bringup.sh` does not run `setup_mise.sh`.
- Homebrew/native package setup is not part of the default bringup path.
- `install_scripts/setup_fedora.sh` is legacy and exits unless `RUN_LEGACY_FEDORA_SETUP=1` is set. Review and modernize it before real Fedora bringup use.

## Layout

| Path | Purpose |
| --- | --- |
| `shell/` | Shared shell startup files for profile, zsh, and bash. |
| `tmux/` | tmux configuration. |
| `nvim/` | Neovim configuration and plugin lockfile. |
| `vim/` | Fallback Vim configuration. |
| `helix/` | Helix editor configuration and themes. |
| `alacritty/` | Alacritty terminal configuration. |
| `p10k/` | Powerlevel10k prompt configuration. |
| `pixi/` | Pixi global tool manifest. |
| `mise/` | Optional Mise configuration. |
| `.claude/` | Claude agent definitions. |
| `.codex/` | Codex global instructions. |
| `opencode/` | OpenCode global config skeleton. |
| `macos/` | Optional macOS defaults script. |
| `aerospace/` | Optional AeroSpace window-manager config. |
| `install_scripts/` | Bringup, linking, Pixi setup, and legacy setup scripts. |

## Platforms

The shared Pixi, shell, terminal, and editor path is intended to work across macOS and Linux where the relevant tools are available.

macOS-specific defaults live in `macos/.macos` and should be run explicitly. AeroSpace linking only happens on Darwin when `aerospace` is installed.

Fedora setup is legacy and intentionally guarded. Do not treat it as a current fresh-machine path without reviewing it first.

## Adding A Linked Config

- Put the config in a tool-specific directory in this repo.
- Add a `link_once` entry to `install_scripts/link_dotfiles.sh`.
- Prefer optional or platform-guarded linking for platform-specific tools.
- Keep generated files, caches, secrets, credentials, and machine-local state out of git.
- Validate the config with the tool's checker when one is available.
