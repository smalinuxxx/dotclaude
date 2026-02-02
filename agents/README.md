# Custom Subagents

Custom subagent definitions for Claude Code. Each subagent is a specialized AI assistant with specific tools, prompts, and permissions.

## Purpose

Store reusable subagent templates that can be:
- Deployed to project-level: `.claude/agents/` (project-specific)
- Deployed to user-level: `~/.claude/agents/` (available in all projects)
- Shared with team via version control

## Usage

### Deploy to Current Project
```bash
# Copy to project's .claude/agents/ directory
cp agents/code-improver.md /path/to/project/.claude/agents/

# Or create symlink
ln -s $(pwd)/agents/code-improver.md /path/to/project/.claude/agents/
```

### Deploy User-Level (All Projects)
```bash
# Copy to user's global Claude directory
cp agents/code-improver.md ~/.claude/agents/

# Available in all Claude Code sessions
```

### Use in Claude Code

After deploying, restart Claude Code or use `/agents` to load immediately.

**Automatic delegation:**
```
Claude will auto-delegate based on subagent description
```

**Explicit invocation:**
```
Use the code-improver agent to analyze this module
Have code-improver review recent changes
```

## Available Subagents

### code-improver
- **Purpose:** Scan files, suggest readability/performance/best practice improvements
- **Model:** Sonnet
- **Tools:** Read-only (Read, Grep, Glob, Bash)
- **Auto-triggers:** After code changes, code quality reviews

## Creating New Subagents

Use `/agents` command in Claude Code or create manually:

```markdown
---
name: agent-name
description: When Claude should use this agent. Include "use proactively" for auto-delegation
tools: Read, Grep, Glob, Bash
model: sonnet|opus|haiku|inherit
---

System prompt here. Guides agent behavior.
```

See `custom_subagents.md` in repo root for complete documentation.

## References

- [Claude Code Subagents Documentation](https://code.claude.com/docs/custom-subagents)
- [Custom Subagents Cheatsheet](custom_subagents.md) - Full configuration reference
- [Claude Code Skills](https://code.claude.com/docs/skills) - Alternative to subagents
- [Hooks Documentation](https://code.claude.com/docs/hooks) - Lifecycle event handlers

## Similar Projects

- [aider](https://github.com/paul-gauthier/aider) - AI pair programming
- [cursor](https://cursor.sh/) - AI-first code editor
- [continue.dev](https://github.com/continuedev/continue) - Open-source Copilot alternative
- [codeium](https://codeium.com/) - Free AI code assistant
- [tabnine](https://www.tabnine.com/) - AI code completion

## Tools for Code Quality

- **Linters:** pylint, eslint, rubocop, golangci-lint
- **Formatters:** black, prettier, gofmt, rustfmt
- **Static Analysis:** sonarqube, semgrep, bandit, shellcheck
- **Security:** snyk, dependabot, trivy
- **Performance:** py-spy, perf, valgrind
