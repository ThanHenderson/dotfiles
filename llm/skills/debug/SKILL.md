---
name: debug
description: Diagnose failing tests, stack traces, logs, regressions, or bug reports; reproduce, isolate root cause, fix, and verify.
---

# Debug

Use this workflow when the user provides an error, failing command, failing test, log, bug report, stuck branch, dirty worktree, partial commit, unclear review feedback, or abandoned handoff.

## Steps

1. Preserve the original symptom and exact failure evidence.
2. Reproduce the failure when feasible with the narrowest command.
3. Trace from symptom to root cause through relevant code and configuration.
4. Patch the smallest root-cause fix.
5. Rerun the focused failing check and any adjacent checks needed for confidence.

## Recovery Mode

When work is stuck or local state is messy:

1. Inspect current branch, worktree, dirty state, staged files, and recent commits.
2. Identify the failure category: test/build failure, incomplete implementation, review feedback not addressed, merge/rebase conflict, dirty tree with unrelated changes, or unclear requirements.
3. Present recovery options from least risky to most invasive.
4. Prefer continuing from current state, addressing latest review feedback, splitting unrelated changes, creating a new branch from current state, or asking for clarification.
5. Ask before stashing, discarding, deleting branches/worktrees, force-pushing, rebasing, or rewriting history.

## Output

- Symptom and reproduction status.
- Root cause.
- Fix applied or recommended.
- Recovery options when local state is stuck or messy.
- Verification result.
