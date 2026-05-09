# OpenCode Config

This directory is intended to be symlinked to `~/.config/opencode`.

It contains global OpenCode configuration only. Project-local `.opencode/` directories are intentionally not managed here.

OpenCode discovers global extension files from these directories:

- `commands/*.md` for custom slash commands
- `skills/<name>/SKILL.md` for reusable agent skills
- `tools/*.js` or `tools/*.ts` for custom tools

Keep `opencode.jsonc` minimal until there is a concrete global preference to encode.
