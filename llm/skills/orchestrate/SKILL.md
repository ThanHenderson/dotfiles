---
name: orchestrate
description: Coordinate complex tasks through delegated agents while keeping the main conversation focused on scope, decisions, and concise results.
---

# Orchestrate

Use this workflow when the user wants delegated execution or a task benefits from separating substantial investigation and execution into worker contexts.

## Steps

1. Establish the user's objective, constraints, and acceptance criteria from the available context.
2. Delegate initial exploration when the work is not understood well enough to assign. Ask for boundaries, dependencies, and recommended tasks rather than a full repository tour.
3. Keep a compact task ledger: assignment, owner, dependencies, status, and evidence still needed.
4. Assign bounded tasks to available agents with clear ownership and expected deliverables. Run independent tasks in parallel; sequence dependent tasks and edits to overlapping files.
5. Collect concise handoffs, resolve decisions, and route failures or missing evidence back to workers. Delegate integration and conflict resolution when needed.
6. Have workers verify the integrated result against the acceptance criteria. Use an independent reviewer for substantial changes and send actionable findings back for correction.
7. Continue until the requested outcome is supported by evidence or a specific blocker requires user input. Report unresolved criteria explicitly.

## Coordinator Boundaries

- Keep the main agent responsible for scope, decomposition, assignments, decisions, and acceptance of results.
- Delegate repository exploration, detailed reading, implementation, debugging, testing, review, and integration. Do not take over execution merely because workers are running.
- Limit direct work to small coordination checks or targeted inspection needed to resolve a decision. Avoid loading broad searches, full diffs, or verbose logs into the main conversation.
- Prefer existing specialized agents when available: `researcher`, `implementer`, `debugger`, `reviewer`, and `verifier`. Otherwise give an available worker the relevant role and constraints.
- Use actual subagent contexts. If delegation is unavailable, explain the limitation before substituting substantial execution in the main context.
- Keep delegation within the user's scope and existing permissions. A worker assignment does not authorize additional external actions.

## Assignments And Handoffs

- Give each worker the objective, relevant context or file references, ownership boundary, dependencies, acceptance criteria, and required report. Prefer a focused context over copying the entire conversation when supported.
- Make shared workspace behavior explicit. Workers must preserve user changes and other workers' edits; serialize overlapping writes or use isolated workspaces with an assigned integration owner.
- Ask workers to return outcomes, changed files or relevant references, verification commands and observed results, blockers, and decisions needed. Keep raw logs and detailed investigation in worker contexts or referenced artifacts.
- Reuse a worker for follow-up in the same area when its context remains useful. Start a fresh worker for unrelated work or when accumulated context makes a focused handoff preferable.
- Distinguish implementation claims from verification evidence. Resolve conflicting reports through targeted investigation; do not repeat all worker checks in the main context.
- Respect available concurrency and nesting limits. Delegate concrete work to workers rather than creating unnecessary layers of coordinators.

## Output

- Outcome against the user's objective.
- Integrated changes or findings with relevant file references.
- Acceptance criteria with `passed`, `failed`, or `unknown` evidence from worker verification.
- Remaining blockers, risks, and decisions needed.
