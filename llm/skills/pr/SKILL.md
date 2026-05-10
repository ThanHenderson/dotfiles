---
name: pr
description: Prepare and create a pull request from the current branch with branch diff review, focused verification, push, and PR summary.
---

# Pull Request

Use this workflow only when the user explicitly asks to create or prepare a PR, or directly invokes this skill.

## Steps

1. Inspect git status, current branch, upstream tracking, recent commits, and diff against the base branch.
2. Stop if the working tree has ambiguous unrelated changes, likely secrets, or no PR-worthy changes.
3. Resolve the PR base branch. Prefer the repository default branch from `gh repo view` when available, then remote HEAD, then project guidance. Ask if uncertain.
4. Analyze the whole branch using PR three-dot semantics: `git diff <base-ref>...HEAD`, `git diff --stat <base-ref>...HEAD`, and `git log --oneline <base-ref>..HEAD`.
5. Do not base the PR title or body on only the latest commit, staged diff, local work-in-progress, or a raw two-dot diff.
6. Run focused verification when practical.
7. Use the project PR template when one exists. Otherwise use the fallback template below.
8. Push the branch when needed using normal non-force push behavior.
9. Create the PR with a concise title and body summarizing user-visible changes and verification.
10. Return the PR URL.

## Fallback PR Body

```markdown
## Motivation

<purpose and goals>

## Technical Details

<what changed, based on the whole branch diff>

## Test Plan

<commands or manual checks>

## Test Result

<observed outcomes, failures, or skipped checks>
```

## Writing Rules

- Write from the final branch state, not a chronological work log.
- Report only checks that actually ran. If checks were not run, say so plainly.
- Preserve required headings and checklist items from project PR templates.
- Include issue or design links only when visible in branch context or supplied by the user.

## Guardrails

- Do not force push unless explicitly requested.
- Do not target `main` or `master` with destructive history operations.
- Do not include secrets or machine-local files.
- Never merge.
