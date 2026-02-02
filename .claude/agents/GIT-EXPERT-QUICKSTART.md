# Git Expert Agent - Quick Start Guide

## What is Git Expert?

The Git Expert agent is your comprehensive git operations assistant that handles everything from simple commits to complex repository workflows with intelligent decision-making and built-in safety checks.

## Quick Access

### Automatic Invocation

Just ask Claude about git operations naturally:
- "Commit my changes"
- "Create a feature branch"
- "Help me resolve these merge conflicts"
- "Create a pull request"

### Manual Invocation

Use the `/git` skill to explicitly invoke:
```
/git commit these changes
/git create a feature branch for authentication
/git help me merge main into my branch
```

## 30-Second Workflows

### Make a Commit
```
User: "Commit my changes with a message about adding login"

Git Expert:
1. ✅ Checks git status
2. ✅ Reviews changes
3. ✅ Stages specific files
4. ✅ Creates properly formatted commit
5. ✅ Includes co-authorship
6. ✅ Appends to prompt file
```

### Create Feature Branch
```
User: "Create a feature branch for dark mode"

Git Expert:
1. ✅ Ensures main is up to date
2. ✅ Creates feature/dark-mode branch
3. ✅ Switches to new branch
4. ✅ Confirms and provides next steps
```

### Resolve Conflicts
```
User: "I have merge conflicts, help!"

Git Expert:
1. ✅ Identifies conflicted files
2. ✅ Explains conflict sources
3. ✅ Suggests resolution strategy
4. ✅ Guides through resolution
5. ✅ Completes merge safely
```

### Create Pull Request
```
User: "Create a PR for my current work"

Git Expert:
1. ✅ Reviews all commits
2. ✅ Drafts PR title and description
3. ✅ Pushes branch if needed
4. ✅ Creates PR with gh CLI
5. ✅ Returns PR URL
```

## Available Skills

Git Expert has access to 10 specialized skills:

| Skill | Status | Purpose |
|-------|--------|---------|
| **commit** | ✅ Ready | Comprehensive commit operations |
| **git** | ✅ Ready | Full git workflow support |
| branch-operations | 📋 Planned | Advanced branch management |
| merge-strategies | 📋 Planned | Intelligent merging |
| history-rewriting | 📋 Planned | Safe history manipulation |
| pr-workflow | 📋 Planned | Pull request lifecycle |
| release-management | 📋 Planned | Version tagging & releases |
| hooks-management | 📋 Planned | Git hooks setup |
| repo-maintenance | 📋 Planned | Repository optimization |
| git-flow | 📋 Planned | Git Flow workflows |

## Safety Features

Git Expert NEVER:
- ❌ Runs `git add -A` or `git add .` (always stages specific files)
- ❌ Force pushes without `--force-with-lease`
- ❌ Skips git hooks unless explicitly asked
- ❌ Performs destructive operations without confirmation
- ❌ Amends commits without being asked

Git Expert ALWAYS:
- ✅ Checks repository state first
- ✅ Uses specific file paths
- ✅ Includes co-authorship attribution
- ✅ Verifies operations succeeded
- ✅ Provides clear next steps

## Common Commands

### Status & Info
```bash
git status                  # Current state
git log --oneline -5       # Recent commits
git diff                   # Unstaged changes
git diff --staged          # Staged changes
git branch -a              # All branches
```

### Daily Workflow
```bash
# Start new feature
git checkout -b feature/name

# Make changes and commit
git add path/to/file
git commit -m "feat: description"

# Push
git push -u origin feature/name

# Create PR
gh pr create
```

### Branch Management
```bash
# Create and switch
git checkout -b feature/name

# Switch branches
git checkout main

# Delete branch
git branch -d feature/name

# Update from main
git pull origin main
# or
git rebase main
```

### Undo Operations
```bash
# Undo last commit (keep changes)
git reset --soft HEAD~1

# Discard changes to file
git restore path/to/file

# Unstage file
git restore --staged path/to/file
```

### Emergency Recovery
```bash
# Find lost commits
git reflog

# Recover lost work
git checkout <commit-hash>
git checkout -b recovery-branch

# Abort operations
git merge --abort
git rebase --abort
```

## Decision Guides

### Merge vs Rebase?

**Use Merge:**
- 👥 Multiple people work on branch
- 📜 Complete history needed
- 🌳 Working on main/master
- 📢 Public shared branches

**Use Rebase:**
- 👤 Personal feature branch
- 📏 Want linear history
- 🧹 Before creating PR
- 🔧 Cleaning up commits

### When to Squash?

**Squash:**
- 🚧 Many "WIP" commits
- ✏️ Fixing typos in commits
- 🧹 Before merging PR
- 📦 Creating clean history

**Don't Squash:**
- 📚 Commits are logical chunks
- 👥 Multiple contributors
- 📤 Already pushed to shared branch
- 📖 History tells a story

## Automatic Commit Hook

### Setup Auto-Commit After Tasks

The git-expert agent includes a hook that prompts you to commit when tasks complete.

**Hook Location:** `.claude/hooks/post-task-commit.sh`

**What it does:**
1. Detects uncommitted changes after Claude finishes tasks
2. Prompts you to create a commit
3. Non-blocking - you can decline
4. Only triggers if changes exist

**Enable it:** (Already configured in `.claude/settings.json`)
```json
{
  "hooks": {
    "Stop": [{
      "hooks": [{
        "type": "command",
        "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/post-task-commit.sh",
        "statusMessage": "Checking for uncommitted changes..."
      }]
    }]
  }
}
```

### Manual Activation

If you prefer manual control, just ask:
```
"Commit my changes"
"Save this work"
"Create a commit"
```

## Commit Message Format

Git Expert uses Conventional Commits:

```
<type>(<scope>): <subject>

<body>

<footer>

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

**Types:**
- `feat:` - New feature
- `fix:` - Bug fix
- `docs:` - Documentation
- `style:` - Code formatting
- `refactor:` - Code restructuring
- `test:` - Test changes
- `chore:` - Build/tools

**Examples:**
```
feat(auth): add JWT token generation

Implement authentication with JWT tokens including:
- Token generation on login
- Token validation middleware
- Refresh token support

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

```
fix(api): handle null response from database

Add null check before processing database results
to prevent TypeError in edge cases.

Fixes #123

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

## Branch Naming Conventions

Use clear prefixes:

```
feature/user-authentication
feature/dark-mode-support
feat/add-export-button

fix/login-redirect-loop
fix/memory-leak-in-parser
bugfix/crash-on-empty-input

hotfix/critical-security-patch
hotfix/production-db-connection

refactor/simplify-state-management
refactor/extract-common-utils

docs/update-api-documentation
docs/add-setup-instructions

test/add-integration-tests
test/improve-coverage

chore/upgrade-dependencies
chore/configure-ci-pipeline
```

## Troubleshooting

### "Detached HEAD state"
```bash
# Save your work
git checkout -b recovery-branch

# Or discard and return
git checkout main
```

### "Cannot push - rejected"
```bash
# Pull first
git pull --rebase origin branch-name

# Then push
git push
```

### "Merge conflict in multiple files"
```bash
# See conflicted files
git status

# For each file:
# 1. Open and edit
# 2. Remove <<<<<<< ======= >>>>>>> markers
# 3. git add filename

# Complete merge
git merge --continue
```

### "Accidentally committed to main"
```bash
# Undo commit (keep changes)
git reset --soft HEAD~1

# Create proper branch
git checkout -b feature/my-feature

# Commit there
git commit
```

### "Lost my changes!"
```bash
# Find them in reflog
git reflog

# Recover
git checkout HEAD@{2}
git checkout -b recovery
```

## Pro Tips

### 1. Check Before You Leap
Always run before major operations:
```bash
git status              # What's changed?
git log --oneline -5    # Where am I?
git branch -a           # What branches exist?
```

### 2. Commit Early, Commit Often
Small, focused commits are easier to:
- Review
- Revert
- Cherry-pick
- Understand later

### 3. Use Descriptive Branch Names
```
❌ fix-bug
❌ new-feature
❌ tmp

✅ fix/user-login-redirect
✅ feature/add-dark-mode
✅ refactor/extract-auth-logic
```

### 4. Write Good Commit Messages
```
❌ "fixed stuff"
❌ "updates"
❌ "WIP"

✅ "feat(auth): add password reset flow"
✅ "fix(ui): correct button alignment on mobile"
✅ "refactor(api): simplify error handling"
```

### 5. Review Before Committing
```bash
# See what you're committing
git diff --staged

# See file names
git status
```

### 6. Keep Branches Updated
```bash
# Regularly sync with main
git checkout feature-branch
git pull origin main
# or
git rebase main
```

## Quick Reference Card

| Task | Command |
|------|---------|
| Create branch | `git checkout -b feature/name` |
| Switch branch | `git checkout branch-name` |
| Stage files | `git add path/to/file` |
| Commit | `git commit -m "message"` |
| Push | `git push -u origin branch` |
| Pull | `git pull origin main` |
| Merge | `git merge branch-name` |
| Rebase | `git rebase main` |
| Stash | `git stash push -m "msg"` |
| Stash pop | `git stash pop` |
| Undo commit | `git reset --soft HEAD~1` |
| Discard changes | `git restore file` |
| Abort merge | `git merge --abort` |
| Create PR | `gh pr create` |
| View history | `git log --oneline` |
| See changes | `git diff` |

## Files & Resources

### Agent Files
- **Main Agent:** `.claude/agents/git-expert.md`
- **This Guide:** `.claude/agents/GIT-EXPERT-QUICKSTART.md`

### Skills
- **Commit Skill:** `.claude/skills/commit/SKILL.md`
- **Git Skill:** `.claude/skills/git/SKILL.md`
- **Quick Ref:** `.claude/skills/git/QUICKREF.md`

### Workflows
- **Conflict Resolution:** `.claude/skills/git/workflows/conflict-resolution.md`
- **Git LFS Guide:** `.claude/skills/git/workflows/lfs-guide.md`

### Examples
- **Common Patterns:** `.claude/skills/git/examples/common-patterns.md`
- **Commit Messages:** `.claude/skills/git/examples/commit-messages.md`

### Hooks
- **Auto-Commit Hook:** `.claude/hooks/post-task-commit.sh`
- **Hook Config:** `.claude/settings.json`

## Getting Help

### Ask Git Expert
```
"How do I...?"
"What's the best way to...?"
"Can you explain...?"
"Help me with..."
```

### Example Questions
- "How do I undo my last commit?"
- "What's the difference between merge and rebase?"
- "How do I resolve merge conflicts?"
- "How do I create a pull request?"
- "How do I rename a branch?"
- "How do I delete a remote branch?"
- "How do I find when a bug was introduced?"

### Command Help
```bash
git help <command>     # Open full documentation
git <command> -h       # Quick help
```

## Next Steps

1. **Try a simple commit:** "Commit my current changes"
2. **Create a feature branch:** "Create a branch for [feature]"
3. **Practice merging:** "Merge main into my feature branch"
4. **Make a PR:** "Create a pull request for my work"
5. **Explore skills:** Read through `.claude/skills/git/QUICKREF.md`

---

**Remember:** Git Expert is here to help! Ask questions, request explanations, and don't hesitate to ask for guidance on complex workflows.

🚀 **Ready to start? Just ask Claude to help with git operations!**
