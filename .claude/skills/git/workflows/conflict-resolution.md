# Git Conflict Resolution Guide

Comprehensive guide for resolving merge and rebase conflicts.

## Understanding Conflicts

Conflicts occur when:
- Same lines modified in different branches
- File deleted in one branch, modified in another
- File renamed in one branch, modified in another
- Binary files changed in both branches

## Conflict Markers

```
<<<<<<< HEAD
Your current branch changes
=======
Incoming branch changes
>>>>>>> branch-name
```

- `<<<<<<< HEAD` - Start of your changes
- `=======` - Separator
- `>>>>>>> branch-name` - End of incoming changes

## Resolution Process

### Step 1: Identify Conflicted Files

```bash
git status
```

Look for files marked as "both modified" or "deleted by us/them".

### Step 2: Understand the Conflict

```bash
# View the conflict in context
git diff

# See changes from both sides
git show :1:path/to/file  # Common ancestor
git show :2:path/to/file  # Your version (HEAD)
git show :3:path/to/file  # Their version (incoming)
```

### Step 3: Choose Resolution Strategy

**Option A: Keep your changes**
```bash
git checkout --ours path/to/file
git add path/to/file
```

**Option B: Keep their changes**
```bash
git checkout --theirs path/to/file
git add path/to/file
```

**Option C: Manual merge**
1. Open file in editor
2. Find conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
3. Edit to combine changes appropriately
4. Remove all conflict markers
5. Save file
6. Stage: `git add path/to/file`

**Option D: Use merge tool**
```bash
git mergetool path/to/file
```

### Step 4: Verify Resolution

```bash
# Check no markers remain
grep -r "<<<<<<< HEAD" .
grep -r ">>>>>>>" .

# Review the resolved changes
git diff --staged

# Check status
git status
```

### Step 5: Complete the Merge/Rebase

**For merge:**
```bash
git commit
# Editor opens with default merge message
# Save and close
```

**For rebase:**
```bash
git rebase --continue
# May need to resolve more conflicts
# Repeat process for each conflicted commit
```

## Common Conflict Scenarios

### Scenario 1: Simple Text Conflict

**Conflict:**
```javascript
<<<<<<< HEAD
const apiUrl = 'https://api.prod.example.com';
=======
const apiUrl = 'https://api-v2.example.com';
>>>>>>> feature-branch
```

**Resolution:**
```javascript
const apiUrl = 'https://api-v2.example.com'; // Use new URL
```

### Scenario 2: Both Sides Added Code

**Conflict:**
```python
<<<<<<< HEAD
def process_user(user):
    validate_user(user)
    return save_user(user)
=======
def process_user(user):
    log_user_action(user)
    return create_user(user)
>>>>>>> feature-branch
```

**Resolution (combine both):**
```python
def process_user(user):
    validate_user(user)
    log_user_action(user)
    return save_user(user)
```

### Scenario 3: File Deleted vs Modified

**Your branch:** Deleted `old-file.js`
**Their branch:** Modified `old-file.js`

**Resolution A (keep deletion):**
```bash
git rm old-file.js
```

**Resolution B (keep modification):**
```bash
git add old-file.js
```

### Scenario 4: Renamed File Conflict

**Your branch:** Renamed `user.js` → `user-model.js`
**Their branch:** Modified `user.js`

**Resolution:**
```bash
# Apply their changes to the renamed file
git show :3:user.js > user-model.js
git add user-model.js
git rm user.js
```

## Advanced Conflict Resolution

### Rerere (Reuse Recorded Resolution)

Enable rerere to automatically resolve conflicts you've solved before:

```bash
git config --global rerere.enabled true
```

Git remembers how you resolved conflicts and auto-applies the same resolution.

### Three-Way Diff

Show all three versions side by side:

```bash
git diff --ours path/to/file    # Your changes
git diff --theirs path/to/file  # Their changes
git diff --base path/to/file    # Common ancestor
```

### Cherry-pick Conflicts

When cherry-picking causes conflicts:

```bash
# Resolve conflicts as usual, then:
git cherry-pick --continue

# Or abort:
git cherry-pick --abort
```

### Rebase Conflicts

During interactive rebase with conflicts:

```bash
# After resolving each conflict:
git add resolved-files
git rebase --continue

# Skip this commit (careful!):
git rebase --skip

# Abort entire rebase:
git rebase --abort
```

## Conflict Prevention

### Before Merging/Rebasing

1. **Update both branches:**
   ```bash
   git checkout main
   git pull origin main
   git checkout feature-branch
   git pull origin feature-branch
   ```

2. **Check for potential conflicts:**
   ```bash
   git merge --no-commit --no-ff main
   git diff --cached
   git merge --abort  # Undo the test merge
   ```

3. **Use smaller, frequent merges:**
   - Merge main into feature branch regularly
   - Keep feature branches short-lived
   - Break large features into smaller branches

### Communication

- Coordinate with team on overlapping work
- Review PRs promptly to avoid divergence
- Use feature flags instead of long-lived branches

## Aborting Operations

**Abort merge:**
```bash
git merge --abort
```

**Abort rebase:**
```bash
git rebase --abort
```

**Abort cherry-pick:**
```bash
git cherry-pick --abort
```

**Reset to before operation:**
```bash
git reset --hard ORIG_HEAD
```

## Conflict Resolution Checklist

- [ ] Run `git status` to see all conflicted files
- [ ] Understand what each side changed and why
- [ ] Choose appropriate resolution strategy
- [ ] Remove all conflict markers (`<<<<<<<`, `=======`, `>>>>>>>`)
- [ ] Test the code (run tests, build, etc.)
- [ ] Stage resolved files with `git add`
- [ ] Verify no conflicts remain (`git status`)
- [ ] Complete operation (`git commit` or `git rebase --continue`)
- [ ] Push changes if appropriate

## When to Ask for Help

Some conflicts require domain knowledge:

- **Business logic conflicts** - Need to understand requirements
- **API contract changes** - Need to understand system design
- **Database schema conflicts** - Need to understand data model
- **Complex algorithmic changes** - Need to understand intent

When in doubt, ask the user or team members who made the conflicting changes.

## Tools and Utilities

### GUI Merge Tools

Configure a merge tool:
```bash
# VS Code
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait $MERGED'

# Meld
git config --global merge.tool meld

# KDiff3
git config --global merge.tool kdiff3
```

Use the tool:
```bash
git mergetool
```

### Diff Tools

```bash
# Use custom diff tool
git difftool path/to/file

# Compare specific versions
git difftool HEAD~1 HEAD path/to/file
```

## Post-Resolution Best Practices

1. **Test thoroughly** - Conflicts can introduce subtle bugs
2. **Review the merge commit** - Use `git show` to verify
3. **Update documentation** - If APIs or behavior changed
4. **Communicate** - Let team know about complex resolutions
5. **Learn** - Understand why the conflict happened

## Common Mistakes to Avoid

- ❌ Accepting all of one side without understanding both
- ❌ Leaving conflict markers in the code
- ❌ Not testing after resolution
- ❌ Forgetting to `git add` resolved files
- ❌ Using `--force` push without `--force-with-lease`
- ❌ Resolving conflicts in binary files manually

## Emergency Recovery

If you mess up a conflict resolution:

```bash
# Find the commit before the merge/rebase
git reflog

# Reset to that commit
git reset --hard HEAD@{n}

# Or create a new branch from there
git checkout -b recovery HEAD@{n}
```

Remember: Git rarely loses data. The reflog keeps track of everything for about 30-90 days.
