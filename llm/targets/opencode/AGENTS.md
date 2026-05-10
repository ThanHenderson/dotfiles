# OpenCode Global Instructions

## Working Style

- Inspect relevant files before changing code or configuration.
- Prefer the smallest correct change over broad rewrites.
- Preserve existing conventions unless there is a concrete reason to change them.
- Be autonomous for requested tasks: diagnose, implement, verify, and report outcomes.
- Keep responses concise and focused on decisions, changes, blockers, and verification.

## Safety

- Do not overwrite, revert, or remove user changes unless explicitly asked.
- Do not run destructive commands such as `git reset --hard`, `git clean`, or force pushes unless explicitly approved.
- Do not commit generated files, local state, credentials, tokens, private keys, or machine-specific secrets.
- Treat dotfile installation scripts as potentially destructive and keep replacement behavior interactive or explicitly opted in.

## Dotfiles

- Keep platform-specific setup optional and explicit.
- Prefer portable paths based on `$HOME`, XDG variables, or tool-native defaults.
- Avoid hardcoded personal identity in shared config; use prompts, environment variables, or git config where appropriate.
- Keep package-manager ownership clear to avoid duplicate setup paths.

## Verification

- Run focused syntax checks, config validation, tests, or builds when they are available and relevant.
- If validation cannot be run locally, state what was skipped and why.

## OpenCode

Prefer shared skills for repeatable workflows. OpenCode command files in `commands/` are thin shims over those skills.

Use generated custom agents when their specialization reduces context noise or improves task quality.
