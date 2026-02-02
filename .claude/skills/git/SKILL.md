---
name: git
description: Comprehensive git operations including commits, branches, merging, rebasing, history inspection, and conflict resolution. Use for any git workflow beyond simple file changes.
argument-hint: [operation] [args...]
allowed-tools: Bash(git *), Bash(gh *)
context: fork
agent: git-expert
---

# Git Operations Skill

Comprehensive git support for all repository operations, from basic commits to complex merge strategies.

## Current Repository Context

**Branch:** !`git branch --show-current`

**Status:** !`git status --short`

**Recent commits:** !`git log --oneline -5`

**Remotes:** !`git remote -v`

## Operation Requested

$ARGUMENTS

## Core Principles

### Safety First
- **NEVER** use destructive commands without explicit user confirmation
- **ALWAYS** check working directory status before major operations
- **NEVER** force push to main/master without explicit permission
- **NEVER** run `git add -A` or `git add .` - always stage specific files
- **NEVER** skip hooks (--no-verify) unless explicitly requested
- **NEVER** amend commits unless explicitly requested

### Commit Quality
- Follow conventional commit format when appropriate
- Keep commits atomic and focused
- Write clear, descriptive commit messages
- Include Co-Authored-By when Claude assists

### Workflow Best Practices
- Understand the current state before acting
- Use specific file paths instead of wildcards
- Preserve commit history unless explicitly asked to rewrite
- Verify operations succeeded before marking complete

## Common Operations

### Status & Inspection
- `git status` - Current working tree state
- `git log --oneline -n` - Recent commit history
- `git diff` - Unstaged changes
- `git diff --staged` - Staged changes
- `git show <commit>` - Inspect specific commit
- `git branch -a` - List all branches

### Commits
1. Check status: `git status`
2. Review changes: `git diff`
3. Stage specific files: `git add path/to/file`
4. Review staged: `git diff --staged`
5. Commit with message:
   ```bash
   git commit -m "$(cat <<'EOF'
   type: subject line

   Detailed explanation of changes.

   Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
   EOF
   )"
   ```
6. Verify: `git log -1`

### Branching
- Create: `git checkout -b feature/name`
- Switch: `git checkout branch-name`
- List: `git branch -a`
- Delete local: `git branch -d branch-name`
- Delete remote: `git push origin --delete branch-name`
- Rename: `git branch -m old-name new-name`

### Merging
1. Update target branch: `git checkout main && git pull`
2. Switch to feature: `git checkout feature-branch`
3. Merge: `git merge main` (or vice versa)
4. Resolve conflicts if needed (see workflows/conflict-resolution.md)
5. Verify: `git log --graph --oneline`

### Rebasing
1. Ensure clean working directory
2. Fetch latest: `git fetch origin`
3. Rebase: `git rebase origin/main`
4. Resolve conflicts one by one
5. Continue: `git rebase --continue`
6. Force push if needed: `git push --force-with-lease`

**NEVER use `--no-edit` with rebase commands**

### Remote Operations
- Fetch: `git fetch origin`
- Pull: `git pull origin branch-name`
- Push: `git push origin branch-name`
- Push new branch: `git push -u origin branch-name`
- Force push (careful!): `git push --force-with-lease origin branch-name`

### History & Changes
- View history: `git log --graph --oneline --all`
- Search commits: `git log --grep="search term"`
- Show file history: `git log --follow -- path/to/file`
- Find changes: `git log -S "code snippet"`
- Blame: `git blame path/to/file`
- Diff between commits: `git diff commit1..commit2`

### Stashing
- Save changes: `git stash push -m "description"`
- List stashes: `git stash list`
- Apply latest: `git stash pop`
- Apply specific: `git stash apply stash@{n}`
- Show stash: `git stash show -p stash@{n}`
- Drop stash: `git stash drop stash@{n}`

### Undoing Changes
- Unstage file: `git restore --staged path/to/file`
- Discard changes: `git restore path/to/file` (after confirmation!)
- Undo last commit (keep changes): `git reset --soft HEAD~1`
- Undo last commit (discard changes): `git reset --hard HEAD~1` (after confirmation!)
- Revert commit: `git revert <commit-hash>`

### Cherry-picking
1. Find commit hash: `git log --oneline`
2. Switch to target branch: `git checkout target-branch`
3. Cherry-pick: `git cherry-pick <commit-hash>`
4. Resolve conflicts if needed
5. Continue: `git cherry-pick --continue`

## Advanced Workflows

### Interactive Rebase
**Purpose:** Clean up commit history, squash commits, reorder, edit messages

```bash
git rebase -i HEAD~n  # where n is number of commits
```

**NEVER use -i flag directly** - it requires interactive input which is not supported.

For commit cleanup, use specific commands:
- Squash last 2 commits: `git reset --soft HEAD~2 && git commit`
- Amend message: `git commit --amend -m "new message"`

### Bisect (Find bad commit)
1. Start: `git bisect start`
2. Mark bad: `git bisect bad`
3. Mark known good: `git bisect good <commit>`
4. Test each commit git checks out
5. Mark: `git bisect good` or `git bisect bad`
6. End: `git bisect reset`

### Worktrees (Multiple working directories)
- Add: `git worktree add ../path branch-name`
- List: `git worktree list`
- Remove: `git worktree remove ../path`

### Submodules
- Add: `git submodule add <url> path`
- Initialize: `git submodule init`
- Update: `git submodule update --remote`
- Status: `git submodule status`

## GitHub CLI Integration

When GitHub URLs or PR/issue numbers are provided:

### Pull Requests
- View: `gh pr view <number>`
- Create: `gh pr create --title "..." --body "..."`
- List: `gh pr list`
- Checkout: `gh pr checkout <number>`
- Review: `gh pr review <number>`
- Merge: `gh pr merge <number>`
- Diff: `gh pr diff <number>`
- Comments: `gh pr view <number> --comments`

### Issues
- View: `gh issue view <number>`
- Create: `gh issue create --title "..." --body "..."`
- List: `gh issue list`
- Close: `gh issue close <number>`

### Releases
- List: `gh release list`
- Create: `gh release create v1.0.0`
- View: `gh release view v1.0.0`

## Handling Complex Scenarios

### Merge Conflicts
See [workflows/conflict-resolution.md](workflows/conflict-resolution.md) for detailed steps.

### Large File Handling
See [workflows/lfs-guide.md](workflows/lfs-guide.md) for Git LFS setup.

### Common Patterns
See [examples/common-patterns.md](examples/common-patterns.md) for workflow examples.

## Pre-flight Checks

Before any major operation:

1. **Check status**: `git status`
2. **Check branch**: `git branch --show-current`
3. **Check unpushed commits**: `git log origin/$(git branch --show-current)..HEAD`
4. **Check uncommitted changes**: `git diff --stat`
5. **Check stashes**: `git stash list`

## Safety Guardrails

### Destructive Operations (require explicit confirmation)
- `git reset --hard`
- `git clean -f`
- `git push --force` (use `--force-with-lease` instead)
- `git branch -D`
- `git restore .` or `git checkout .`

### Protected Branches
Before force-pushing to main/master, **WARN** the user and require confirmation.

### Hook Preservation
**NEVER** use `--no-verify` unless explicitly requested. Hooks exist for a reason.

## Troubleshooting

### Common Issues

**Detached HEAD:**
```bash
git checkout -b new-branch  # Save work
# or
git checkout main  # Discard and return
```

**Merge conflicts:**
1. `git status` - See conflicted files
2. Edit files, remove conflict markers
3. `git add <resolved-files>`
4. `git merge --continue` or `git rebase --continue`

**Pushed wrong commit:**
```bash
git revert <commit-hash>  # Safe option
# or
git reset --hard HEAD~1 && git push --force-with-lease  # Dangerous!
```

**Lost commits:**
```bash
git reflog  # Find lost commit
git checkout <commit-hash>
git checkout -b recovery-branch
```

## Output Format

After completing operations:

1. **Summary** of what was done
2. **Current state** (branch, status)
3. **Next steps** if applicable
4. **Warnings** if any risky operations occurred

## Additional Resources

- **Conflict Resolution Guide**: [workflows/conflict-resolution.md](workflows/conflict-resolution.md)
- **Git LFS Guide**: [workflows/lfs-guide.md](workflows/lfs-guide.md)
- **Common Patterns**: [examples/common-patterns.md](examples/common-patterns.md)
- **Commit Message Guide**: [examples/commit-messages.md](examples/commit-messages.md)

---

**Remember**: Git operations can be destructive. When in doubt:
1. Check current state
2. Consider creating a backup branch
3. Use `--dry-run` when available
4. Verify results after each step
