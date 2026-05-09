# Tools

Place global OpenCode custom tools here as JavaScript or TypeScript files.

Custom tools usually import `tool` from `@opencode-ai/plugin`:

```ts
import { tool } from "@opencode-ai/plugin"

export default tool({
  description: "Describe what this tool does",
  args: {},
  async execute() {
    return "result"
  },
})
```

Avoid naming custom tools after built-in tools unless intentionally replacing that built-in behavior.

Add a `package.json` in the config directory only when a real tool or plugin needs dependencies.
