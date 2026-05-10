# LLM Config

Canonical AI assistant configuration for Codex, OpenCode, and Claude Code.

## Source Of Truth

- `instructions/` contains shared and tool-specific persistent instructions.
- `agents/` contains tool-neutral canonical agent definitions.
- `skills/` contains shared Agent Skills workflows used by all supported tools.
- `targets/` contains static tool-specific config files and OpenCode command shims.
- `scripts/render-agent-targets.sh` renders canonical agents into each tool's native format.

## Deployment

The dotfile bringup scripts link shared files into tool-specific home directories:

- OpenCode reads `~/.config/opencode`.
- Claude Code reads `~/.claude`.
- Codex reads `~/.codex` and shared skills from `~/.agents/skills`.

Skills are directly shared because all three tools support Agent Skills-style `SKILL.md` directories. Agents are generated because each tool uses a different agent config format.

## Workflow Names

- `orient`: map an unfamiliar project quickly.
- `review`: review changes for real risks.
- `debug`: reproduce and fix failures.
- `verify`: discover and run relevant checks.
- `commit`: stage and commit changes safely.
- `pr`: prepare and create pull requests.
- `upgrade-dep`: research and apply dependency upgrades.
- `refine`: improve shared or project-local LLM guidance after real workflow friction.
