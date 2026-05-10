---
name: commit
description: Stage and commit current changes with diff review, secret checks, focused verification, and a concise commit message.
---

# Commit

Use this workflow only when the user explicitly asks to commit or directly invokes this skill.

## Steps

1. Inspect git status, current branch, staged diff, unstaged diff, untracked files, upstream state, and recent commit message style.
2. Stop and ask before committing on detached `HEAD`, an unexpected default branch, or a branch that is behind or diverged from upstream.
3. Identify files relevant to the requested change. Separate already staged, unstaged, and untracked work.
4. Stop if likely secrets, credentials, private keys, local-only files, or ambiguous unrelated changes would be staged or committed.
5. Stage only relevant files with explicit paths. Avoid broad `git add .` unless the user explicitly asked to stage everything and inspection shows it is safe.
6. Base the commit message on the staged diff only. Do not imply unstaged or untracked files are included.
7. Run focused verification when practical before committing.
8. Create one commit with a concise message focused on intent.
9. Report the commit hash, included files/change groups, remaining unstaged or untracked work, and final status.

## Guardrails

- Do not amend unless the user explicitly requested it.
- Do not use `--no-verify` unless the user explicitly requested it.
- Do not push unless the user explicitly requested it.
- Do not create an empty commit unless explicitly requested.
- If hooks fail, fix in-scope issues and create a new commit; do not amend a failed commit attempt.
