# Git Expert Auto-Commit Hook Setup Guide

## Overview

This guide explains how to set up automatic commit prompts when Claude Code finishes tasks. The hook detects uncommitted changes and offers to create a commit automatically using the git-expert agent.

## How It Works

```
Claude completes tasks
        ↓
Hook detects changes
        ↓
Prompts: "Would you like to commit?"
        ↓
User accepts → Git Expert creates commit
User declines → Continue without committing
```

## Quick Setup

### 1. Verify Hook File Exists

The hook should already be created at:
```bash
.claude/hooks/post-task-commit.sh
```

Check it's executable:
```bash
ls -la .claude/hooks/post-task-commit.sh
```

If not executable:
```bash
chmod +x .claude/hooks/post-task-commit.sh
```

### 2. Configure Settings

Edit `.claude/settings.json` to add the hook:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/block-git-push.sh"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/post-task-commit.sh",
            "statusMessage": "Checking for uncommitted changes..."
          }
        ]
      }
    ]
  }
}
```

### 3. Test the Hook

Make some changes and complete a task:
```bash
# Make a change
echo "test" >> test.txt

# Ask Claude to do something
# When done, hook should prompt for commit
```

## Hook Types

Claude Code supports several hook types:

| Hook Type | When It Runs | Use Case |
|-----------|--------------|----------|
| `PreToolUse` | Before any tool call | Validation, safety checks |
| `PostToolUse` | After tool completes | Logging, notifications |
| `Stop` | When Claude stops/finishes | Auto-commit, cleanup, summary |
| `SessionStart` | When session begins | Setup, initialization |
| `SessionEnd` | When session ends | Cleanup, archival |
| `SubagentStart` | When subagent starts | Subagent tracking |
| `SubagentStop` | When subagent stops | Subagent cleanup |

## Hook Script Explained

### The Auto-Commit Hook

**Location:** `.claude/hooks/post-task-commit.sh`

```bash
#!/bin/bash
# Post-task auto-commit hook
# Automatically offers to commit changes when Claude Code finishes all tasks

# Only run if there are changes
if ! git diff --quiet || ! git diff --cached --quiet || [ -n "$(git ls-files --others --exclude-standard)" ]; then
    # Check if we're not in the middle of a merge/rebase
    if [ ! -f .git/MERGE_HEAD ] && [ ! -d .git/rebase-merge ] && [ ! -d .git/rebase-apply ]; then
        # Signal to Claude that there are uncommitted changes
        echo "📝 Uncommitted changes detected. Would you like to commit them?"

        # Return exit code 0 to allow the operation (non-blocking)
        exit 0
    fi
fi

# No changes or in middle of operation - silent pass
exit 0
```

**What it checks:**
1. ✅ Are there unstaged changes? (`git diff --quiet`)
2. ✅ Are there staged changes? (`git diff --cached --quiet`)
3. ✅ Are there untracked files? (`git ls-files --others`)
4. ✅ Are we in a merge/rebase? (checks git state files)

**What it does:**
- ✅ Non-blocking (exit 0) - doesn't interrupt Claude
- ✅ Only triggers when changes exist
- ✅ Skips during merge/rebase operations
- ✅ Shows friendly message

## Advanced Configuration

### Conditional Activation

Only run hook in certain directories:

```bash
#!/bin/bash
# Only run in specific projects
PROJECT_DIR=$(basename "$CLAUDE_PROJECT_DIR")

if [[ "$PROJECT_DIR" =~ ^(my-app|my-lib|my-tool)$ ]]; then
    # Run hook logic
    if ! git diff --quiet; then
        echo "📝 Uncommitted changes detected. Would you like to commit them?"
    fi
fi
exit 0
```

### Auto-Stage and Commit

For automated workflows (use with caution):

```bash
#!/bin/bash
# Auto-commit on task completion (AUTOMATIC - NO PROMPT)
# WARNING: This commits without asking!

if ! git diff --quiet || ! git diff --cached --quiet; then
    # Stage all changes
    git add -A

    # Create automated commit
    git commit -m "chore: auto-commit after task completion

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>" || true

    echo "✅ Changes auto-committed"
fi
exit 0
```

**⚠️ Warning:** This auto-commits without asking. Use only in trusted environments.

### Notification Integration

Send notifications when changes need committing:

```bash
#!/bin/bash
# Notify user of uncommitted changes

if ! git diff --quiet || ! git diff --cached --quiet; then
    # macOS notification
    if command -v osascript &> /dev/null; then
        osascript -e 'display notification "You have uncommitted changes" with title "Claude Code"'
    fi

    # Linux notification
    if command -v notify-send &> /dev/null; then
        notify-send "Claude Code" "You have uncommitted changes"
    fi

    echo "📝 Uncommitted changes detected. Would you like to commit them?"
fi
exit 0
```

### Smart Commit Suggestions

Analyze changes and suggest commit type:

```bash
#!/bin/bash
# Suggest commit type based on changes

if ! git diff --quiet || ! git diff --cached --quiet; then
    # Get list of changed files
    CHANGED_FILES=$(git diff --name-only HEAD)

    # Determine commit type
    if echo "$CHANGED_FILES" | grep -q "test/"; then
        SUGGESTED_TYPE="test"
    elif echo "$CHANGED_FILES" | grep -q "docs/\|README\|\.md$"; then
        SUGGESTED_TYPE="docs"
    elif echo "$CHANGED_FILES" | grep -q "package.json\|pom.xml\|build\."; then
        SUGGESTED_TYPE="chore"
    else
        SUGGESTED_TYPE="feat"
    fi

    echo "📝 Uncommitted changes detected. Suggested type: $SUGGESTED_TYPE:"
fi
exit 0
```

## Troubleshooting

### Hook Not Running

**Check hook is executable:**
```bash
ls -la .claude/hooks/post-task-commit.sh
# Should show: -rwxr-xr-x
```

**Make it executable:**
```bash
chmod +x .claude/hooks/post-task-commit.sh
```

**Verify settings.json syntax:**
```bash
cat .claude/settings.json | python3 -m json.tool
# Should show formatted JSON without errors
```

### Hook Runs But Nothing Happens

**Test the hook directly:**
```bash
./.claude/hooks/post-task-commit.sh
# Should print message if changes exist
```

**Check git state:**
```bash
git status
# Should show changes
```

**Check for git directory:**
```bash
ls -la .git
# Should exist
```

### Hook Gives Errors

**Check bash availability:**
```bash
which bash
# Should show: /bin/bash or /usr/bin/bash
```

**Test with bash explicitly:**
```bash
bash -x ./.claude/hooks/post-task-commit.sh
# Shows detailed execution trace
```

**Check git commands:**
```bash
git diff --quiet; echo $?
# Should return 0 (no changes) or 1 (changes exist)
```

## Multiple Hooks

### Running Multiple Post-Task Hooks

You can chain multiple hooks:

```json
{
  "hooks": {
    "PostConversationTurn": [
      {
        "type": "command",
        "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/post-task-commit.sh"
      },
      {
        "type": "command",
        "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/run-tests.sh"
      },
      {
        "type": "command",
        "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/update-docs.sh"
      }
    ]
  }
}
```

### Execution Order

Hooks run in the order listed. Use exit codes to control flow:
- `exit 0` - Success, continue to next hook
- `exit 1` - Error, stop hook chain (but don't block Claude)

## Best Practices

### 1. Keep Hooks Fast

Hooks should complete quickly:
```bash
# ✅ Good - Quick check
if ! git diff --quiet; then
    echo "Changes detected"
fi

# ❌ Bad - Slow operation
find . -name "*.js" -exec eslint {} \;
```

### 2. Make Hooks Non-Blocking

Always exit 0 to avoid blocking Claude:
```bash
# ✅ Good - Non-blocking
echo "📝 Changes detected"
exit 0

# ❌ Bad - Could block
exit 1  # Only use for critical errors
```

### 3. Handle Edge Cases

Check for special git states:
```bash
# Check for merge in progress
if [ -f .git/MERGE_HEAD ]; then
    echo "⚠️ Merge in progress, skipping auto-commit"
    exit 0
fi

# Check for rebase in progress
if [ -d .git/rebase-merge ]; then
    echo "⚠️ Rebase in progress, skipping auto-commit"
    exit 0
fi
```

### 4. Provide Clear Messages

Use emojis and clear text:
```bash
echo "📝 Uncommitted changes detected"  # Good
echo "Changes found"                    # Less clear
```

### 5. Log Hook Activity

For debugging:
```bash
# Log to file
{
    echo "[$(date)] Hook executed"
    echo "Changes: $(git status --short | wc -l) files"
} >> .claude/hooks/hook.log
```

## Example Workflows

### Workflow 1: Prompt to Commit
```
User: "Add login feature"
Claude: [Implements feature]
Hook: "📝 Uncommitted changes detected. Would you like to commit them?"
User: "Yes, commit these changes"
Claude: [Uses git-expert to create commit]
```

### Workflow 2: Skip Commit
```
User: "Add login feature"
Claude: [Implements feature]
Hook: "📝 Uncommitted changes detected. Would you like to commit them?"
User: "No, I'll commit later"
Claude: [Continues without committing]
```

### Workflow 3: Auto-Commit (if configured)
```
User: "Add login feature"
Claude: [Implements feature]
Hook: [Auto-commits changes]
Hook: "✅ Changes auto-committed"
User: [Sees commit was created]
```

## Security Considerations

### Safe Practices

✅ **Do:**
- Keep hooks in `.claude/hooks/` directory
- Use absolute paths with `$CLAUDE_PROJECT_DIR`
- Validate git state before operations
- Exit 0 for non-critical issues
- Log hook activity for debugging

❌ **Don't:**
- Run untrusted scripts
- Auto-commit without user knowledge (unless explicitly configured)
- Skip git safety checks
- Use `git add -A` without careful consideration
- Modify files outside project directory

### Hook Permissions

Hooks should be executable only by owner:
```bash
chmod 755 .claude/hooks/*.sh
# Or more restrictive:
chmod 700 .claude/hooks/*.sh
```

## Disabling the Hook

### Temporary Disable

Comment out in `settings.json`:
```json
{
  "hooks": {
    // "PostConversationTurn": [...]
  }
}
```

### Remove Hook

Delete the hook configuration from `settings.json` and optionally delete the script:
```bash
rm .claude/hooks/post-task-commit.sh
```

## Resources

### Related Files
- **Hook Script:** `.claude/hooks/post-task-commit.sh`
- **Configuration:** `.claude/settings.json`
- **Git Expert Agent:** `.claude/agents/git-expert.md`
- **Commit Skill:** `.claude/skills/commit/SKILL.md`

### Documentation
- **Quick Start:** `.claude/agents/GIT-EXPERT-QUICKSTART.md`
- **Git Skill:** `.claude/skills/git/SKILL.md`
- **Git Quick Ref:** `.claude/skills/git/QUICKREF.md`

### External Links
- [Claude Code Hooks Documentation](https://docs.claude.ai/code/hooks)
- [Git Hooks Documentation](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks)

## Support

If you encounter issues:
1. Check the troubleshooting section above
2. Test the hook script directly
3. Verify settings.json syntax
4. Check Claude Code logs
5. Ask Claude: "Help me debug the auto-commit hook"

---

**Ready to enable auto-commit?** Just ensure the hook is executable and add it to your `settings.json`!
