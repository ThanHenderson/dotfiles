---
name: review
description: Review code, working tree changes, branches, or PRs for correctness, regressions, security risks, and missing tests.
---

# Review

Use this workflow for working tree reviews, PR reviews, branch reviews, or targeted code reviews.

## Steps

1. Determine the review scope from the user request or current git state.
2. Inspect changed files and relevant surrounding code, not just the diff.
3. Review through these lenses where relevant: Domain Owner, Correctness, Testing, Interfaces, Maintainability, Operability, and Security.
4. Use the Security lens when changes touch authentication, authorization, secrets, dependencies, input handling, or sensitive data.
5. Prioritize functional correctness, behavior regressions, data loss, security, concurrency, and missing test coverage.
6. Classify findings as `Critical`, `Suggestion`, or `Nit`.
7. Ignore style-only comments unless they obscure a real bug or maintenance hazard.
8. Compute a verdict: `critical_findings`, `suggestions_only`, or `clean`.
9. If there are no findings, say so and mention residual risks or checks not run.

## Finding Levels

- `Critical`: must fix before human review, merge, release, or relying on the change.
- `Suggestion`: useful improvement that is not blocking.
- `Nit`: small polish; omit unless it is genuinely helpful and low-noise.

## Review Discipline

- Ground findings in the diff, surrounding code, requirements, or observed test output.
- Do not raise speculative issues without a concrete risk.
- Treat relevant failing checks as `Critical` unless clearly unrelated.
- Do not ask for broad unrelated refactors.

## Output

Lead with findings ordered by severity. Each finding should include level, lens, file reference, issue, impact, and a concrete fix direction.

End with `Verdict: <clean | suggestions_only | critical_findings>`.
