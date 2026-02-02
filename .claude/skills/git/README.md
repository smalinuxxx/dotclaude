# Git Skill

Comprehensive git operations support for Claude Code.

## Overview

This skill provides expert-level git support, leveraging the `git-expert` agent for complex operations. It covers everything from basic commits to advanced workflows like rebasing, conflict resolution, and repository maintenance.

## Structure

```
git/
├── SKILL.md                           # Main skill entrypoint with live repo context
├── QUICKREF.md                        # Quick reference for common commands
├── README.md                          # This file
├── workflows/
│   ├── conflict-resolution.md         # Detailed merge conflict guide
│   └── lfs-guide.md                   # Git LFS setup and usage
└── examples/
    ├── common-patterns.md             # Real-world workflow examples
    └── commit-messages.md             # Commit message best practices
```

## Usage

### Automatic Invocation

Claude will use this skill automatically when you mention git operations:

- "Create a new branch for this feature"
- "Help me resolve these merge conflicts"
- "How do I rebase my branch?"
- "Show me the commit history"

### Manual Invocation

You can also invoke the skill directly:

```
/git create a feature branch

/git help with merge conflicts

/git show me how to squash commits
```

## What This Skill Covers

### Core Operations
- **Status & Inspection**: Check repo state, view history, inspect commits
- **Commits**: Stage files, write good commit messages, amend commits
- **Branching**: Create, switch, rename, and delete branches
- **Merging**: Merge branches, resolve conflicts, abort merges
- **Rebasing**: Rebase branches, interactive rebase, conflict resolution

### Advanced Features
- **Stashing**: Save and restore work-in-progress
- **Cherry-picking**: Apply specific commits to other branches
- **Bisecting**: Find the commit that introduced a bug
- **Worktrees**: Multiple working directories from one repo
- **Submodules**: Manage dependencies as git repositories

### Workflows
- **Feature Branch Workflow**: Standard development pattern
- **Hotfix Workflow**: Quick production fixes
- **Release Workflow**: Preparing releases
- **Fork Sync**: Keeping forks up to date

### GitHub Integration
- Pull requests with `gh` CLI
- Issue management
- Repository operations
- CI/CD integration

### Best Practices
- Conventional commit messages
- Safe git operations (never destructive without confirmation)
- Clean history management
- Team collaboration patterns

## Safety Features

This skill includes multiple safety guardrails:

- ✅ **Never** runs destructive commands without confirmation
- ✅ **Never** skips git hooks unless explicitly requested
- ✅ **Never** uses `git add -A` or `git add .` (always specific files)
- ✅ **Never** force pushes to main/master without warning
- ✅ **Always** checks repo state before major operations
- ✅ **Always** includes Claude co-author attribution

## Dynamic Context

The skill automatically injects current repository state:

- Current branch
- Working tree status
- Recent commits
- Configured remotes

This ensures Claude has full context about your repository when helping with git operations.

## Supporting Documentation

### Quick Reference (QUICKREF.md)
Fast lookup for common commands:
- Daily operations cheat sheet
- Emergency recovery commands
- Useful aliases
- Common workflows

### Conflict Resolution Guide (workflows/conflict-resolution.md)
Comprehensive guide covering:
- Understanding conflict markers
- Resolution strategies
- Common conflict scenarios
- Advanced techniques like rerere
- Prevention tips

### Git LFS Guide (workflows/lfs-guide.md)
Complete documentation for large file handling:
- Installation and setup
- Tracking file patterns
- Migrating existing files
- Performance optimization
- Troubleshooting

### Common Patterns (examples/common-patterns.md)
Real-world workflow examples:
- Feature branch workflow
- Hotfix patterns
- Release preparation
- Code review workflows
- Fork synchronization
- Monorepo management

### Commit Messages (examples/commit-messages.md)
Best practices for commit messages:
- Conventional commit format
- The seven rules of great commits
- Good vs. bad examples
- Team conventions
- Automation with commitlint

## Integration with Git Expert Agent

This skill runs in a **forked context** using the `git-expert` agent, which means:

1. **Isolated execution**: Git operations run in a dedicated context
2. **Specialized tools**: The agent has full access to git and gh commands
3. **Expert knowledge**: Pre-configured with git best practices
4. **Safety checks**: Built-in guardrails for destructive operations

## Configuration

The skill is configured in `SKILL.md` frontmatter:

```yaml
name: git
description: Comprehensive git operations...
context: fork
agent: git-expert
allowed-tools: Bash(git *), Bash(gh *)
```

## Examples

### Example 1: Creating a Feature Branch

**You:** Create a feature branch for adding dark mode

**Claude (using /git skill):**
1. Checks current state
2. Updates main branch
3. Creates `feature/dark-mode` branch
4. Confirms switch and provides next steps

### Example 2: Resolving Conflicts

**You:** Help me resolve these merge conflicts

**Claude (using /git skill):**
1. Identifies conflicted files
2. Explains the conflict sources
3. Suggests resolution strategy
4. Guides through resolution
5. Verifies all markers removed
6. Completes the merge

### Example 3: Creating a Pull Request

**You:** Create a PR for my current branch

**Claude (using /git skill):**
1. Reviews branch commits
2. Checks for uncommitted changes
3. Drafts PR title and description
4. Pushes branch if needed
5. Creates PR with `gh pr create`
6. Returns PR URL

## Additional Features

### String Substitution

The skill supports dynamic variables:
- `$ARGUMENTS`: Passed arguments
- `${CLAUDE_SESSION_ID}`: Current session ID

### Command Injection

The skill uses `!`command\`` syntax to inject live data:
- Current branch: `!`git branch --show-current``
- Status: `!`git status --short``
- Recent commits: `!`git log --oneline -5``

## Tips for Best Results

1. **Be specific**: "Rebase my feature branch onto main" is better than "fix my branch"
2. **Provide context**: Mention if you're in the middle of a merge or rebase
3. **Ask for explanations**: "Why should I rebase instead of merge?"
4. **Request safety checks**: "Show me what will happen before doing it"

## File Sizes

```
SKILL.md                     ~12 KB  (Main skill with dynamic context)
QUICKREF.md                  ~15 KB  (Command reference)
workflows/conflict-resolution.md  ~23 KB  (Detailed conflict guide)
workflows/lfs-guide.md       ~18 KB  (Complete LFS documentation)
examples/common-patterns.md  ~17 KB  (Workflow examples)
examples/commit-messages.md  ~16 KB  (Commit best practices)
----------------------------------------
Total                        ~88 KB  (Comprehensive git knowledge)
```

## Contributing

This skill follows the [Agent Skills](https://agentskills.io) open standard. To extend:

1. Add new workflow guides to `workflows/`
2. Add new examples to `examples/`
3. Update `SKILL.md` to reference new files
4. Keep `QUICKREF.md` updated with new commands

## Related Skills

Consider combining with:
- **commit**: Specialized commit workflow skill
- **review-pr**: Pull request review skill
- **deploy**: Deployment workflow skill

## Support

For issues or questions:
- Check `QUICKREF.md` for quick command lookup
- Reference specific guides in `workflows/` and `examples/`
- The skill automatically uses the git-expert agent for complex operations

## License

Part of Claude Code skills collection.
