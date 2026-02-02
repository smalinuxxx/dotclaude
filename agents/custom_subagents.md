# Custom Subagents Cheatsheet

Specialized AI assistants for task-specific workflows. Each runs in own context with custom prompt, specific tools, independent permissions.

## Quick Start

```bash
# Open subagents interface
/agents

# Create new user-level agent (available in all projects)
# Select: Create new agent → User-level → Generate with Claude
```

## Built-in Subagents

| Agent | Model | Tools | Purpose |
|-------|-------|-------|---------|
| **Explore** | Haiku | Read-only | Fast codebase search/analysis |
| **Plan** | Inherit | Read-only | Research during plan mode |
| **general-purpose** | Inherit | All | Complex multi-step tasks |
| **Bash** | Inherit | Bash | Terminal commands in separate context |

## Scopes & Priority

| Location | Scope | Priority | When to use |
|----------|-------|----------|-------------|
| `--agents` CLI flag | Session | 1 (highest) | Quick testing |
| `.claude/agents/` | Project | 2 | Project-specific, check into git |
| `~/.claude/agents/` | User | 3 | Personal, all projects |
| Plugin `agents/` | Plugin scope | 4 | Distributed via plugins |

## Configuration

### Basic Structure

```markdown
---
name: agent-name
description: When Claude should delegate to this agent
tools: Read, Grep, Glob, Bash
disallowedTools: Write, Edit
model: sonnet|opus|haiku|inherit
permissionMode: default|acceptEdits|dontAsk|bypassPermissions|plan
skills:
  - skill-name
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate.sh"
---

System prompt here. This guides agent behavior.
```

### Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `name` | ✓ | Unique identifier (lowercase, hyphens) |
| `description` | ✓ | When to delegate (include "use proactively" for auto-use) |
| `tools` | - | Allowlist of tools (inherits all if omitted) |
| `disallowedTools` | - | Tools to deny |
| `model` | - | `sonnet`/`opus`/`haiku`/`inherit` (default: inherit) |
| `permissionMode` | - | Permission behavior |
| `skills` | - | Preload skill content into context |
| `hooks` | - | Lifecycle hooks scoped to this agent |

### Permission Modes

- `default` - Standard prompts
- `acceptEdits` - Auto-accept file edits
- `dontAsk` - Auto-deny prompts (allowed tools still work)
- `bypassPermissions` - Skip all checks ⚠️
- `plan` - Read-only exploration

## CLI Definition

```bash
claude --agents '{
  "code-reviewer": {
    "description": "Expert code reviewer. Use proactively after code changes.",
    "prompt": "You are a senior code reviewer...",
    "tools": ["Read", "Grep", "Glob"],
    "model": "sonnet"
  }
}'
```

## Hooks

### In Frontmatter

```yaml
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate.sh"
  PostToolUse:
    - matcher: "Edit|Write"
      hooks:
        - type: command
          command: "./scripts/lint.sh"
  Stop:  # Auto-converts to SubagentStop
    - hooks:
        - type: command
          command: "./scripts/cleanup.sh"
```

### In settings.json

```json
{
  "hooks": {
    "SubagentStart": [{
      "matcher": "db-agent",
      "hooks": [{"type": "command", "command": "./setup.sh"}]
    }],
    "SubagentStop": [{
      "hooks": [{"type": "command", "command": "./cleanup.sh"}]
    }]
  }
}
```

### Hook Validation Script Example

```bash
#!/bin/bash
# Block SQL write operations

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if echo "$COMMAND" | grep -iE '\b(INSERT|UPDATE|DELETE|DROP)\b' > /dev/null; then
  echo "Blocked: Only SELECT queries allowed" >&2
  exit 2  # Exit code 2 blocks operation
fi

exit 0
```

## Usage Patterns

### Automatic Delegation

Claude auto-delegates based on description. Encourage with "use proactively" in description.

### Explicit Invocation

```
Use the test-runner subagent to fix failing tests
Have the code-reviewer subagent look at recent changes
```

### Foreground vs Background

- **Foreground**: Blocks main conversation, allows prompts/questions
- **Background**: Concurrent, pre-approve permissions, auto-deny `AskUserQuestion`
- Press **Ctrl+B** to background running task
- Disable: `CLAUDE_CODE_DISABLE_BACKGROUND_TASKS=1`

### Resume Subagents

```
Use code-reviewer to review auth module
[completes]

Continue that review and analyze authorization logic
[Claude resumes with full context]
```

### Parallel Research

```
Research authentication, database, and API modules in parallel using separate subagents
```

### Chain Subagents

```
Use code-reviewer to find performance issues, then use optimizer to fix them
```

## When to Use

### Use Subagents When:
- Task produces verbose output you don't need in main context
- Enforce specific tool restrictions/permissions
- Self-contained work returning summary
- Isolate high-volume operations (tests, logs, docs)

### Use Main Conversation When:
- Frequent back-and-forth needed
- Multiple phases share context
- Quick targeted change
- Latency matters

### Consider Skills When:
- Reusable prompts/workflows
- Run in main context (not isolated)
- Nested delegation needed (subagents can't spawn subagents)

## Disable Subagent

In `settings.json`:

```json
{
  "permissions": {
    "deny": ["Task(Explore)", "Task(my-agent)"]
  }
}
```

Or CLI:

```bash
claude --disallowedTools "Task(Explore)"
```

## Example: Read-Only Code Reviewer

```markdown
---
name: code-reviewer
description: Expert code review specialist. Use proactively after code changes.
tools: Read, Grep, Glob, Bash
model: sonnet
---

Senior code reviewer ensuring quality and security.

When invoked:
1. Run git diff for recent changes
2. Focus on modified files
3. Review immediately

Checklist:
- Code clarity, naming
- No duplication
- Error handling
- No exposed secrets
- Input validation
- Test coverage
- Performance

Feedback by priority:
- Critical (must fix)
- Warnings (should fix)
- Suggestions (consider)

Include specific fix examples.
```

## Example: DB Query Validator

```markdown
---
name: db-reader
description: Execute read-only database queries for analysis/reports
tools: Bash
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/validate-readonly.sh"
---

Database analyst with read-only access. Execute SELECT queries only.

When analyzing:
1. Identify relevant tables
2. Write efficient SELECT queries
3. Present results with context

Cannot modify data. Explain read-only limitation if write requested.
```

## Context Management

### Auto-Compaction
- Triggers at ~95% capacity
- Override: `CLAUDE_AUTOCOMPACT_PCT_OVERRIDE=50`
- Logged in transcript: `~/.claude/projects/{project}/{sessionId}/subagents/agent-{agentId}.jsonl`

### Persistence
- Transcripts persist independently from main conversation
- Survive main conversation compaction
- Session-based (resume after restart by resuming session)
- Auto-cleanup after `cleanupPeriodDays` (default: 30)

## Best Practices

1. **Focused design**: One task per subagent
2. **Detailed descriptions**: Claude uses for delegation decisions
3. **Minimal tools**: Grant only necessary permissions
4. **Version control**: Check project subagents into git
5. **Use hooks**: Validate operations conditionally
6. **Preload skills**: Inject domain knowledge at startup
7. **Test isolation**: Keep verbose output out of main context

## References

- Full docs: https://code.claude.com/docs/custom-subagents
- Hooks: `/en/hooks`
- Skills: `/en/skills`
- Plugins: `/en/plugins`
- IAM: `/en/iam`
- CLI Reference: `/en/cli-reference`
- Agent SDK: `/en/headless`
