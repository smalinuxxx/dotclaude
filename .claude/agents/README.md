# Git Expert Agent - Complete Documentation

## Overview

The Git Expert Agent is a comprehensive, production-ready git operations system for Claude Code that provides intelligent git workflows, safety checks, and automated commit management.

## What's Included

### 📁 Files Created

| File | Purpose | Size |
|------|---------|------|
| `git-expert.md` | Main agent definition | ~35 KB |
| `GIT-EXPERT-QUICKSTART.md` | Quick start guide | ~18 KB |
| `HOOK-SETUP-GUIDE.md` | Hook configuration guide | ~15 KB |
| `README.md` | This file | - |

### 🔧 Components

1. **Git Expert Agent** (`git-expert.md`)
   - Core agent with safety-first git operations
   - Intelligent decision-making
   - Integration with 10 specialized skills (2 implemented, 8 planned)

2. **Quick Start Guide** (`GIT-EXPERT-QUICKSTART.md`)
   - 30-second workflows
   - Common commands
   - Decision guides (merge vs rebase, when to squash)
   - Pro tips and troubleshooting

3. **Hook Setup Guide** (`HOOK-SETUP-GUIDE.md`)
   - Auto-commit hook configuration
   - Advanced hook patterns
   - Troubleshooting
   - Security best practices

4. **Auto-Commit Hook** (`.claude/hooks/post-task-commit.sh`)
   - Runs when Claude finishes tasks
   - Prompts for commit if changes detected
   - Non-blocking, safe operation

## Quick Start

### 1. Verify Installation

All files should already be in place:

```bash
# Check agent files
ls -la .claude/agents/git-expert*

# Check hook
ls -la .claude/hooks/post-task-commit.sh

# Check configuration
cat .claude/settings.json
```

### 2. Test the Agent

Simply ask Claude about git operations:

```
"Commit my changes"
"Create a feature branch for authentication"
"Help me resolve merge conflicts"
"Create a pull request"
```

### 3. Verify Hook is Active

Make a change and ask Claude to complete a task:

```bash
echo "test" >> test.txt
```

Then ask Claude something like "read this README". When Claude finishes, the hook should detect uncommitted changes and prompt you.

## Available Skills

The git-expert agent leverages these skills:

### ✅ Implemented Skills

1. **commit** - `.claude/skills/commit/SKILL.md`
   - Comprehensive commit workflow
   - Conventional commit formatting
   - Co-authorship attribution
   - Prompt archival

2. **git** - `.claude/skills/git/SKILL.md`
   - Full git command support
   - Live repository context
   - Safety guardrails
   - Workflow guides

### 📋 Planned Skills

3. **branch-operations** - Advanced branch management
4. **merge-strategies** - Intelligent merging & conflict resolution
5. **history-rewriting** - Safe history manipulation
6. **pr-workflow** - Pull request lifecycle
7. **release-management** - Version tagging & releases
8. **hooks-management** - Git hooks setup
9. **repo-maintenance** - Repository optimization
10. **git-flow** - Git Flow workflows

## Features

### Safety-First Operations

The agent NEVER:
- ❌ Uses `git add -A` or `git add .`
- ❌ Force pushes without `--force-with-lease`
- ❌ Skips git hooks unless explicitly requested
- ❌ Performs destructive operations without confirmation
- ❌ Amends commits without being asked

The agent ALWAYS:
- ✅ Checks repository state first
- ✅ Stages specific files
- ✅ Includes co-authorship
- ✅ Verifies operations succeeded
- ✅ Provides next steps

### Auto-Commit Hook

When enabled (default), the hook:
1. Detects uncommitted changes after Claude finishes
2. Prompts: "📝 Uncommitted changes detected. Would you like to commit them?"
3. Waits for your response (non-blocking)
4. Invokes git-expert if you accept

**Hook Configuration:**
- Location: `.claude/hooks/post-task-commit.sh`
- Trigger: `Stop` event (when Claude finishes)
- Status: ✅ Enabled by default

### Intelligent Decision Making

The agent helps you decide:
- **Merge vs Rebase** - Based on context and branch type
- **When to Squash** - Cleaning history vs preserving it
- **Commit Message Format** - Conventional commits with examples
- **Branch Naming** - Consistent patterns (feature/, fix/, etc.)

## Common Workflows

### Create a Commit
```
User: "Commit my changes with a message about adding authentication"

Git Expert:
1. Runs git status
2. Reviews git diff
3. Stages specific modified files
4. Creates commit with conventional format
5. Includes co-authorship
6. Verifies commit succeeded
```

### Create Feature Branch
```
User: "Create a feature branch for dark mode"

Git Expert:
1. Ensures main is up to date
2. Creates feature/dark-mode branch
3. Switches to new branch
4. Confirms and provides next steps
```

### Resolve Conflicts
```
User: "Help me resolve merge conflicts"

Git Expert:
1. Identifies conflicted files
2. Explains conflict sources
3. Suggests resolution strategy
4. Guides through resolution
5. Completes merge safely
```

### Create Pull Request
```
User: "Create a PR for my work"

Git Expert:
1. Reviews all commits
2. Drafts PR title and description
3. Pushes branch if needed
4. Creates PR with gh CLI
5. Returns PR URL
```

## Documentation Structure

```
.claude/
├── agents/
│   ├── git-expert.md              # Main agent definition
│   ├── GIT-EXPERT-QUICKSTART.md   # Quick start guide
│   ├── HOOK-SETUP-GUIDE.md        # Hook configuration
│   └── README.md                  # This file
│
├── hooks/
│   ├── post-task-commit.sh        # Auto-commit hook
│   └── block-git-push.sh          # Safety hook (existing)
│
├── skills/
│   ├── commit/
│   │   └── SKILL.md               # Commit skill
│   │
│   └── git/
│       ├── SKILL.md               # Git skill entrypoint
│       ├── README.md              # Git skill overview
│       ├── QUICKREF.md            # Command reference
│       ├── workflows/
│       │   ├── conflict-resolution.md
│       │   └── lfs-guide.md
│       └── examples/
│           ├── common-patterns.md
│           └── commit-messages.md
│
└── settings.json                  # Hook configuration
```

## Usage Examples

### Example 1: Simple Commit
```
User: Commit these changes

Claude: Let me create a commit for your changes.
[Reviews status and diffs]
[Creates commit with proper message]
✅ Committed successfully: abc123f feat: add authentication
```

### Example 2: Feature Branch Workflow
```
User: Create a branch for adding dark mode support

Claude: I'll create a feature branch for dark mode.
[Updates main branch]
[Creates feature/dark-mode branch]
✅ Branch created: feature/dark-mode
Next: Make your changes and commit them
```

### Example 3: Conflict Resolution
```
User: I have merge conflicts, help!

Claude: Let me help you resolve these conflicts.
[Identifies conflicted files: src/app.js, src/styles.css]
[Explains conflicts]
[Guides through resolution]
✅ All conflicts resolved
✅ Merge completed successfully
```

### Example 4: Pull Request Creation
```
User: Create a PR

Claude: I'll create a pull request for your branch.
[Reviews 3 commits on feature/dark-mode]
[Drafts PR description]
[Pushes branch]
[Creates PR via gh CLI]
✅ PR created: https://github.com/user/repo/pull/42
```

## Advanced Configuration

### Customize Hook Behavior

Edit `.claude/hooks/post-task-commit.sh` to:
- Change detection logic
- Add notifications
- Auto-stage files
- Skip certain file types

See `HOOK-SETUP-GUIDE.md` for examples.

### Disable Auto-Commit Hook

**Temporary:**
Comment out in `.claude/settings.json`:
```json
{
  "hooks": {
    // "Stop": [...]
  }
}
```

**Permanent:**
Remove the hook configuration and delete the script:
```bash
rm .claude/hooks/post-task-commit.sh
```

### Add Custom Skills

To extend the git-expert agent:

1. Create new skill in `.claude/skills/your-skill/`
2. Add SKILL.md with frontmatter
3. Reference in `git-expert.md` skills list
4. Document in skill's README

## Troubleshooting

### Hook Not Running

```bash
# Check hook is executable
ls -la .claude/hooks/post-task-commit.sh
# Should show: -rwxr-xr-x

# Make executable
chmod +x .claude/hooks/post-task-commit.sh

# Test hook directly
./.claude/hooks/post-task-commit.sh
```

### Git Operations Failing

```bash
# Check git status
git status

# Verify git config
git config user.name
git config user.email

# Check remote
git remote -v
```

### Agent Not Responding

Try invoking explicitly:
```
/git commit my changes
/git help with branches
```

## Best Practices

### 1. Commit Messages

Follow conventional commits:
```
feat(scope): add new feature
fix(scope): resolve bug
docs: update documentation
refactor: restructure code
test: add tests
chore: maintenance tasks
```

### 2. Branch Naming

Use clear prefixes:
```
feature/user-authentication
fix/login-redirect-bug
hotfix/critical-security-patch
refactor/simplify-api
docs/update-readme
```

### 3. Before Major Operations

Always:
1. Check status: `git status`
2. Check branch: `git branch --show-current`
3. Check uncommitted: `git diff --stat`
4. Create backup if risky: `git branch backup-$(date +%Y%m%d)`

### 4. Merge vs Rebase

**Merge when:**
- Working on shared/main branches
- Multiple contributors
- Want complete history

**Rebase when:**
- Personal feature branches
- Want linear history
- Before creating PR

## Security Considerations

### Hook Safety

- Hooks are non-blocking (exit 0)
- No auto-commits without prompt
- Respects git state (merge/rebase in progress)
- Limited to project directory

### Git Safety

- No force push to protected branches
- Specific file staging only
- Hook preservation
- Confirmation for destructive ops

## Resources

### Quick Links

- **Main Agent:** `git-expert.md`
- **Quick Start:** `GIT-EXPERT-QUICKSTART.md`
- **Hook Setup:** `HOOK-SETUP-GUIDE.md`
- **Commit Skill:** `.claude/skills/commit/SKILL.md`
- **Git Skill:** `.claude/skills/git/SKILL.md`
- **Git Quick Ref:** `.claude/skills/git/QUICKREF.md`

### External Resources

- [Pro Git Book](https://git-scm.com/book)
- [GitHub CLI Manual](https://cli.github.com/manual/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/)

## Support

### Getting Help

Ask Claude:
```
"How do I use the git expert agent?"
"Help me configure the auto-commit hook"
"What's the difference between merge and rebase?"
"Show me how to create a pull request"
```

### Debugging

1. Check files exist and are executable
2. Verify settings.json syntax
3. Test hooks directly
4. Review git status and config
5. Check Claude Code logs

## Next Steps

1. **Try a simple commit:** "Commit my current changes"
2. **Create a branch:** "Create a feature branch for [feature]"
3. **Explore workflows:** Read `GIT-EXPERT-QUICKSTART.md`
4. **Configure hooks:** Read `HOOK-SETUP-GUIDE.md`
5. **Review skills:** Explore `.claude/skills/git/`

## Version History

- **v1.0.0** (2026-02-02)
  - Initial release
  - Git expert agent with safety features
  - Auto-commit hook integration
  - 2 implemented skills, 8 planned
  - Comprehensive documentation

## Contributing

To extend this agent:

1. **Add new skills** in `.claude/skills/`
2. **Update skill list** in `git-expert.md`
3. **Document workflows** in skill README files
4. **Add examples** to quick start guide
5. **Test thoroughly** with various git scenarios

## License

Part of Claude Code skills and agents collection.

---

**Ready to start?** Just ask Claude about git operations, and the git-expert agent will help guide you through safe, intelligent git workflows!

🚀 **Happy coding!**
