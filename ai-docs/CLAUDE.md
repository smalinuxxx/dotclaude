# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a dotfiles repository for Claude Code configuration. It stores:
- Custom subagents (specialized AI assistants)
- Skills (reusable prompts/workflows)
- Hooks templates (lifecycle event handlers)
- Reference documentation and cheatsheets

## Repository Structure

```
/src/dotclaude/
├── .claude/                    # User-level Claude config (not project-specific)
│   └── USER_CLAUDE_BACKUP-OLD.md  # Backup of global user settings
├── agents/                     # Custom subagent definitions (create as needed)
├── skills/                     # Custom skills definitions (create as needed)
├── hooks/                      # Hook templates and examples (create as needed)
├── plans/                      # Project plans (create as needed)
├── custom_subagents.md         # Reference: subagents cheatsheet
├── WORKFLOW.md                 # Project workflow notes
└── README.md                   # Project overview
```

## Working with This Repository

### Subagents
- Store custom subagent markdown files in `agents/` directory
- Each subagent file: YAML frontmatter + system prompt in markdown body
- Subagents in this repo are project-level (`.claude/agents/` when deployed)
- To make user-level (all projects), copy to `~/.claude/agents/`
- Reference: `custom_subagents.md` contains complete subagent documentation

### Skills
- Store custom skill markdown files in `skills/` directory
- Skills are reusable prompts that run in main conversation context
- Format follows Claude Code skills specification

### Hooks
- Store hook scripts and templates in `hooks/` directory
- Hooks respond to lifecycle events (PreToolUse, PostToolUse, SubagentStart, etc.)
- Include validation scripts, linters, custom workflows

### Plans
- All planning documents go in `plans/` directory
- Use zero-padded numbering: `0001_plan_name.md`, `0002_next_plan.md`
- Multi-phase structure with scaling considerations
- Include tools/dependencies section (top 10 active open source tools)

## Documentation Management

- Each new directory should include a README.md explaining:
  - Purpose and usage
  - Relevant references to read
  - Similar open source projects/tools
- Use Obsidian for editing markdown files (configured in `.obsidian/`)

## Commit Conventions

- Prefix: `dotclaude:` for commits in this repo
- Format: `dotclaude: description`
- Include full user prompt in commit body under "User Request:" section
- Append prompts to `prompt` file (if tracking prompt history)

## Configuration Notes

- This repo contains templates/examples for Claude Code configuration
- When deploying, users copy relevant files to their project's `.claude/` or `~/.claude/`
- `.claude/USER_CLAUDE_BACKUP-OLD.md` is user's global CLAUDE.md backup (don't modify)
- Obsidian workspace configured for convenient markdown editing
