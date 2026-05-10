---
name: upgrade-dep
description: Research, apply, and verify dependency upgrades or API migrations with changelog/docs awareness.
---

# Upgrade Dependency

Use this workflow for dependency upgrades, version bumps, API migrations, or library behavior questions tied to an upgrade.

## Steps

1. Identify the current package manager, dependency declaration, lockfile, and affected code paths.
2. Research release notes, migration guides, or upstream docs for breaking changes.
3. Update dependency metadata and lockfiles with the project's package manager.
4. Update application code only where required by the version change.
5. Run focused verification for affected code and dependency integrity.

## Output

- Current and target versions.
- Relevant breaking changes or migration notes.
- Files changed.
- Verification result and residual risks.
