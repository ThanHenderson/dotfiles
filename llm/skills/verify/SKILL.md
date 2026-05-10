---
name: verify
description: Discover and run the smallest meaningful checks for a task or change; summarize test, lint, typecheck, or build results.
---

# Verify

Use this workflow after edits or when the user asks what checks should run.

## Steps

1. Discover commands from manifests, task runners, CI config, README, and existing scripts.
2. Select focused checks for changed files or behavior before broad checks.
3. Identify acceptance criteria from the user request, issue, plan, or implementation summary.
4. Map each acceptance criterion to concrete evidence.
5. Run checks when allowed and practical.
6. Summarize failures with only relevant excerpts.
7. Mark each criterion `passed`, `failed`, or `unknown`.
8. Recommend follow-up when checks are unavailable, too broad, blocked, or when evidence is incomplete.

## Evidence Rules

- Do not claim checks passed unless you observed the output.
- Do not treat file existence as proof unless the criterion is only file creation.
- If a criterion cannot be verified locally, mark it `unknown` and explain what evidence is needed.
- Distinguish implementation claims from verified facts.

## Output

- Commands discovered.
- Commands run.
- Acceptance criteria with `passed`, `failed`, or `unknown` evidence.
- Overall result: `passed`, `failed`, or `inconclusive`.
- Failure details and next action.
