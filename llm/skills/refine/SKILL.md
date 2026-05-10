---
name: refine
description: Improve LLM agents, skills, commands, or project guidance after repeated mistakes, missing checks, unclear workflow, or real task friction.
---

# Refine LLM Workflow

Use this workflow when real usage reveals weak instructions, missing project conventions, repeated agent mistakes, poor reviews, missing checks, or workflow friction.

## Goal

Find the smallest durable change that makes future agents more reliable. Do not add instructions everywhere.

## Steps

1. Identify the target scope: global `llm/`, repository-wide guidance, or path-scoped guidance.
2. Gather evidence from the task, review findings, failed checks, repeated user corrections, missing conventions, or ambiguous handoffs.
3. Classify the need:
   - Always applies to every agent: persistent instruction or `AGENTS.md`.
   - Repeatable procedure: skill.
   - Context-heavy specialist work: subagent.
   - Repeated output shape: template/reference.
   - Deterministic setup/linking: script.
   - One-time product/code work: ticket or normal task.
4. Choose the narrowest durable home. Do not mutate global guidance for project-local quirks.
5. Propose the edit before applying unless the user explicitly asked to apply changes.
6. Keep edits concise, specific, and actionable.

## Output

```markdown
## Workflow Refinement

### Findings
- <observed issue and evidence>

### Proposed Changes
- **Target file**: <path>
- **Problem**: <issue>
- **Proposed edit**: <summary>
- **Reason**: <why this helps future agents>
- **Scope**: <global | repo | path>
- **Blast radius**: <affected tools/agents/skills>

### Approval Needed
- <edit/action or "None">
```

## Verification

After editing workflow files, validate names, frontmatter, script syntax, config parsing, and generated target files when applicable.
