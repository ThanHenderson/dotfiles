# Commands

Place global OpenCode command files here as `*.md` files. The file name becomes the slash command name.

Command files use YAML frontmatter followed by the prompt template:

```md
---
description: Run tests with coverage
agent: build
---
Run the full test suite and summarize any failures.
```

Do not add a command until there is a repeated workflow worth encoding globally.
