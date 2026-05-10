# OpenCode Instructions

Follow `llm/instructions/base.md` as the source policy.

Use subagents and skills when they reduce context noise or enforce a useful specialist lens. Prefer shared skills for repeatable workflows and OpenCode command shims for quick invocation.

When a command shim matches a shared skill, follow the skill's workflow as the source of truth.
