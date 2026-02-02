# Git Quick Reference

Fast lookup for common git commands and operations.

## Daily Operations

```bash
# Status and info
git status                          # Working tree status
git status --short                  # Compact status
git log --oneline -10              # Recent commits
git diff                           # Unstaged changes
git diff --staged                  # Staged changes
git branch -a                      # All branches

# Basic workflow
git add path/to/file               # Stage specific file
git commit -m "message"            # Commit with message
git push                           # Push to remote
git pull                           # Fetch and merge

# Branching
git checkout -b feature/name       # Create and switch to branch
git checkout branch-name           # Switch to branch
git branch -d branch-name          # Delete local branch
git push origin --delete branch    # Delete remote branch
```

## Undoing Changes

```bash
# Unstage
git restore --staged <file>        # Unstage file
git reset HEAD <file>              # Alternative unstage

# Discard changes
git restore <file>                 # Discard working changes
git checkout -- <file>             # Alternative discard

# Undo commits
git reset --soft HEAD~1            # Undo commit, keep changes
git reset --hard HEAD~1            # Undo commit, discard changes
git revert <commit>                # Create new commit undoing changes

# Amend last commit
git commit --amend                 # Modify last commit
git commit --amend --no-edit       # Amend without changing message
```

## Stashing

```bash
git stash                          # Stash changes
git stash push -m "description"    # Stash with message
git stash list                     # List stashes
git stash pop                      # Apply and remove latest stash
git stash apply                    # Apply without removing
git stash apply stash@{2}          # Apply specific stash
git stash drop stash@{2}           # Delete specific stash
git stash clear                    # Delete all stashes
git stash show -p                  # Show stash diff
```

## Branches

```bash
# List
git branch                         # Local branches
git branch -r                      # Remote branches
git branch -a                      # All branches
git branch -v                      # With last commit

# Create
git branch feature-name            # Create branch
git checkout -b feature-name       # Create and switch

# Rename
git branch -m old-name new-name    # Rename branch
git branch -m new-name             # Rename current branch

# Delete
git branch -d branch-name          # Delete merged branch
git branch -D branch-name          # Force delete branch

# Tracking
git checkout -b local origin/remote  # Create from remote
git branch -u origin/branch        # Set upstream
```

## Merging

```bash
# Merge
git merge branch-name              # Merge branch into current
git merge --no-ff branch-name      # Force merge commit
git merge --squash branch-name     # Squash all commits

# Abort
git merge --abort                  # Cancel merge

# Conflicts
git diff                           # See conflicts
git checkout --ours <file>         # Use our version
git checkout --theirs <file>       # Use their version
git add <file>                     # Mark as resolved
```

## Rebasing

```bash
# Rebase
git rebase main                    # Rebase current onto main
git rebase -i HEAD~5               # Interactive rebase last 5
git rebase --continue              # Continue after resolving
git rebase --skip                  # Skip current commit
git rebase --abort                 # Cancel rebase

# Interactive commands
# p, pick = use commit
# r, reword = use commit, edit message
# e, edit = use commit, stop for amending
# s, squash = use commit, meld into previous
# f, fixup = like squash, discard message
# d, drop = remove commit
```

## Remote Operations

```bash
# Remotes
git remote -v                      # List remotes
git remote add name url            # Add remote
git remote remove name             # Remove remote
git remote rename old new          # Rename remote

# Fetch
git fetch                          # Fetch all remotes
git fetch origin                   # Fetch specific remote
git fetch --prune                  # Remove deleted remote branches

# Pull
git pull                           # Fetch and merge
git pull --rebase                  # Fetch and rebase
git pull origin main               # Pull specific branch

# Push
git push                           # Push current branch
git push -u origin branch          # Push and set upstream
git push origin branch             # Push to specific branch
git push --force-with-lease        # Force push safely
git push --all                     # Push all branches
git push --tags                    # Push all tags
```

## Viewing History

```bash
# Log
git log                            # Full log
git log --oneline                  # Compact log
git log --graph --oneline --all    # Graph of all branches
git log -p                         # Show diffs
git log --follow -- file           # File history
git log --author="Name"            # By author
git log --since="2 weeks ago"      # By date
git log --grep="pattern"           # Search commits

# Show
git show <commit>                  # Show commit
git show <commit>:<file>           # Show file at commit
git show HEAD~2                    # Show 2 commits ago

# Diff
git diff                           # Unstaged changes
git diff --staged                  # Staged changes
git diff commit1 commit2           # Between commits
git diff branch1 branch2           # Between branches
git diff --stat                    # Summary only
```

## Tags

```bash
# Create
git tag v1.0.0                     # Lightweight tag
git tag -a v1.0.0 -m "message"     # Annotated tag
git tag -a v1.0.0 <commit>         # Tag specific commit

# List
git tag                            # All tags
git tag -l "v1.*"                  # Pattern match

# Push
git push origin v1.0.0             # Push specific tag
git push --tags                    # Push all tags

# Delete
git tag -d v1.0.0                  # Delete local tag
git push origin --delete v1.0.0    # Delete remote tag

# Checkout
git checkout v1.0.0                # Checkout tag
git checkout -b branch v1.0.0      # Create branch from tag
```

## Cherry-picking

```bash
git cherry-pick <commit>           # Apply commit
git cherry-pick <commit1> <commit2>  # Multiple commits
git cherry-pick <start>..<end>     # Range of commits
git cherry-pick --continue         # Continue after conflict
git cherry-pick --abort            # Cancel cherry-pick
```

## Clean Up

```bash
# Remove files
git clean -n                       # Dry run
git clean -f                       # Remove untracked files
git clean -fd                      # Remove files and directories
git clean -fdx                     # Include ignored files

# Prune
git remote prune origin            # Remove stale remote branches
git fetch --prune                  # Fetch and prune

# Garbage collection
git gc                             # Cleanup repository
git gc --aggressive                # Aggressive cleanup
```

## Finding Things

```bash
# Search
git grep "pattern"                 # Search working tree
git grep "pattern" branch          # Search branch
git log --grep="pattern"           # Search commit messages
git log -S "code"                  # Search code changes (pickaxe)

# Blame
git blame <file>                   # Show line authors
git blame -L 10,20 <file>          # Specific lines

# Bisect
git bisect start                   # Start bisect
git bisect bad                     # Mark current as bad
git bisect good <commit>           # Mark commit as good
git bisect reset                   # End bisect
```

## Configuration

```bash
# User
git config --global user.name "Name"
git config --global user.email "email@example.com"

# Editor
git config --global core.editor vim

# Aliases
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit

# View config
git config --list                  # All settings
git config user.name              # Specific setting
git config --global --edit        # Edit global config
```

## Advanced

```bash
# Reflog
git reflog                         # Show ref history
git reflog show branch             # Branch history
git checkout HEAD@{2}              # Checkout from reflog

# Archive
git archive --format=zip HEAD > project.zip
git archive --format=tar --prefix=proj/ HEAD | gzip > proj.tar.gz

# Worktrees
git worktree add ../path branch    # Add worktree
git worktree list                  # List worktrees
git worktree remove ../path        # Remove worktree

# Submodules
git submodule add <url> path       # Add submodule
git submodule init                 # Initialize submodules
git submodule update               # Update submodules
git submodule update --remote      # Update to latest
```

## GitHub CLI (gh)

```bash
# PRs
gh pr create                       # Create PR
gh pr list                         # List PRs
gh pr view 123                     # View PR
gh pr checkout 123                 # Checkout PR
gh pr merge 123                    # Merge PR
gh pr diff 123                     # Show PR diff

# Issues
gh issue create                    # Create issue
gh issue list                      # List issues
gh issue view 456                  # View issue
gh issue close 456                 # Close issue

# Repo
gh repo view                       # View repository
gh repo clone owner/repo           # Clone repository
gh repo fork                       # Fork repository
```

## Git LFS

```bash
# Setup
git lfs install                    # Install LFS
git lfs track "*.psd"              # Track file type
git lfs track                      # List tracked patterns

# Operations
git lfs ls-files                   # List LFS files
git lfs fetch                      # Fetch LFS files
git lfs pull                       # Pull LFS files
git lfs prune                      # Cleanup old files

# Migration
git lfs migrate import --include="*.zip"  # Migrate to LFS
git lfs migrate export --include="*.txt"  # Migrate from LFS
```

## Shortcuts and Aliases

Add to `~/.gitconfig`:

```ini
[alias]
    # Short forms
    st = status
    co = checkout
    br = branch
    ci = commit

    # Useful combinations
    unstage = restore --staged
    undo = reset --soft HEAD~1
    amend = commit --amend --no-edit

    # Logging
    lg = log --graph --oneline --decorate --all
    ll = log --oneline -10
    last = log -1 HEAD --stat

    # Diffs
    d = diff
    ds = diff --staged

    # Branches
    branches = branch -a
    cleanmerged = !git branch --merged | grep -v '\\*\\|main\\|develop' | xargs -n 1 git branch -d

    # Status
    s = status --short --branch

    # Show
    show-files = diff-tree --no-commit-id --name-only -r
```

## Common Workflows

### Feature branch
```bash
git checkout main
git pull
git checkout -b feature/new-thing
# ... work ...
git add .
git commit -m "feat: add new thing"
git push -u origin feature/new-thing
```

### Quick fix
```bash
git stash
git checkout main
git pull
git checkout -b fix/urgent-issue
# ... fix ...
git commit -am "fix: urgent issue"
git push -u origin fix/urgent-issue
git checkout -
git stash pop
```

### Update feature branch
```bash
git checkout main
git pull
git checkout feature/branch
git merge main
# or: git rebase main
```

### Squash commits
```bash
git rebase -i HEAD~3
# Change 'pick' to 'squash' for commits to combine
git push --force-with-lease
```

## Emergency Commands

```bash
# Lost work?
git reflog                         # Find lost commits
git checkout <commit>              # Recover

# Wrong branch?
git stash
git checkout correct-branch
git stash pop

# Committed to wrong branch?
git reset --soft HEAD~1            # Undo commit
git stash
git checkout correct-branch
git stash pop
git commit

# Pushed wrong thing?
git revert <commit>                # Safe: create reverting commit
# or
git reset --hard HEAD~1
git push --force-with-lease        # Dangerous: rewrites history
```

## Getting Help

```bash
git help <command>                 # Open man page
git <command> --help               # Same as above
git <command> -h                   # Quick help
```

## Common Flags

```bash
-a, --all                          # All branches/files
-b                                 # Create branch
-d, --delete                       # Delete
-f, --force                        # Force operation
-m, --message                      # Commit message
-n, --dry-run                      # Preview without executing
-p, --patch                        # Interactive mode
-u, --set-upstream                 # Set tracking
-v, --verbose                      # Verbose output
--hard                             # Discard changes
--soft                             # Keep changes staged
--mixed                            # Keep changes unstaged
```

## Special References

```bash
HEAD                               # Current commit
HEAD~1                             # Parent of HEAD
HEAD~2                             # Grandparent of HEAD
HEAD^                              # Same as HEAD~1
main@{yesterday}                   # Branch yesterday
HEAD@{2}                           # 2nd prior position
main..feature                      # Commits in feature not in main
main...feature                     # Symmetric difference
```

## .gitignore Patterns

```
# Files
*.log
secret.txt

# Directories
node_modules/
build/

# Exceptions
!important.log

# Patterns
**/temp
*.cache
```

## Exit Codes

```bash
git <command>; echo $?
0   # Success
1   # Generic error
128 # Fatal error
```

---

**Tip**: Use `git <command> -h` for quick help on any command!
