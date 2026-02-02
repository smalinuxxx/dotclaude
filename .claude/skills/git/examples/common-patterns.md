# Common Git Patterns and Workflows

Real-world examples of git workflows and patterns.

## Feature Branch Workflow

Standard workflow for developing features:

```bash
# Start new feature
git checkout main
git pull origin main
git checkout -b feature/user-authentication

# Work on feature (repeat as needed)
# ... make changes ...
git add src/auth/login.ts
git commit -m "feat(auth): add login form component"

# ... more changes ...
git add src/auth/auth-service.ts
git commit -m "feat(auth): implement authentication service"

# Keep feature branch updated
git checkout main
git pull origin main
git checkout feature/user-authentication
git merge main
# or: git rebase main

# Push feature branch
git push -u origin feature/user-authentication

# Create pull request (using gh CLI)
gh pr create --title "Add user authentication" --body "$(cat <<'EOF'
## Summary
- Implement login form component
- Add authentication service
- Add session management

## Test plan
- [ ] Test login with valid credentials
- [ ] Test login with invalid credentials
- [ ] Test session persistence
- [ ] Test logout functionality

🤖 Generated with Claude Code
EOF
)"

# After PR is merged, cleanup
git checkout main
git pull origin main
git branch -d feature/user-authentication
git push origin --delete feature/user-authentication
```

## Hotfix Workflow

Quick fixes for production issues:

```bash
# Create hotfix branch from main
git checkout main
git pull origin main
git checkout -b hotfix/fix-payment-bug

# Make the fix
git add src/payment/processor.ts
git commit -m "fix(payment): correct currency conversion calculation"

# Test thoroughly
npm test

# Merge back to main
git checkout main
git merge hotfix/fix-payment-bug

# Tag the release
git tag -a v1.2.3 -m "Hotfix: Payment currency conversion"
git push origin main --tags

# Also merge to develop if you use GitFlow
git checkout develop
git merge hotfix/fix-payment-bug
git push origin develop

# Cleanup
git branch -d hotfix/fix-payment-bug
```

## Release Branch Workflow

Prepare a release:

```bash
# Create release branch
git checkout develop
git pull origin develop
git checkout -b release/v2.0.0

# Version bump and changelog
npm version minor  # Updates package.json
# Edit CHANGELOG.md with release notes
git add CHANGELOG.md package.json
git commit -m "chore: bump version to 2.0.0"

# Bug fixes during release preparation
git add src/utils/helpers.ts
git commit -m "fix: correct date formatting edge case"

# Final tests
npm run test:e2e
npm run build

# Merge to main
git checkout main
git merge release/v2.0.0
git tag -a v2.0.0 -m "Release version 2.0.0"
git push origin main --tags

# Merge back to develop
git checkout develop
git merge release/v2.0.0
git push origin develop

# Cleanup
git branch -d release/v2.0.0
```

## Code Review Pattern

Incorporating review feedback:

```bash
# Reviewer requests changes
# Make updates based on feedback
git add src/components/Button.tsx
git commit -m "refactor: use semantic HTML button element"

git add src/components/Button.test.tsx
git commit -m "test: add accessibility tests"

# Push updates
git push origin feature/new-button-component

# Reviewer approves, squash before merging (if desired)
git rebase -i HEAD~3  # Squash the review fix commits

# Or let GitHub/GitLab squash on merge
gh pr merge --squash
```

## Syncing Fork Pattern

Keep your fork up to date:

```bash
# Add upstream remote (one-time setup)
git remote add upstream https://github.com/original/repo.git
git remote -v

# Fetch upstream changes
git fetch upstream

# Sync main branch
git checkout main
git merge upstream/main
git push origin main

# Update your feature branch
git checkout feature/my-contribution
git rebase main  # or: git merge main
git push --force-with-lease origin feature/my-contribution
```

## Stash and Context Switching

Quick context switch without committing:

```bash
# Working on feature A, urgent bug comes in
git stash push -m "WIP: Feature A - half done with form validation"

# Switch context
git checkout main
git pull
git checkout -b hotfix/critical-bug
# ... fix bug ...
git add .
git commit -m "fix: resolve critical authentication bug"
git push

# Return to feature A
git checkout feature-a
git stash pop
# Continue working
```

## Collaborative Feature Pattern

Multiple developers on same feature:

```bash
# Developer 1: Create feature branch
git checkout -b feature/new-dashboard
git push -u origin feature/new-dashboard

# Developer 2: Join the feature
git fetch origin
git checkout -b feature/new-dashboard origin/feature/new-dashboard

# Both work and push regularly
# Developer 1:
git add src/dashboard/overview.tsx
git commit -m "feat: add dashboard overview component"
git pull origin feature/new-dashboard  # Get Developer 2's changes
git push origin feature/new-dashboard

# Developer 2:
git add src/dashboard/stats.tsx
git commit -m "feat: add statistics widget"
git pull origin feature/new-dashboard  # Get Developer 1's changes
git push origin feature/new-dashboard

# Regular syncing
git pull origin feature/new-dashboard  # Before starting work
git push origin feature/new-dashboard  # After completing work
```

## Bisect for Bug Hunting

Find the commit that introduced a bug:

```bash
# Bug exists now, but worked in v1.0.0
git bisect start
git bisect bad HEAD  # Current version is bad
git bisect good v1.0.0  # This tag was good

# Git checks out a commit in between
# Test the code
npm test

# Mark result
git bisect good  # If tests pass
# or
git bisect bad   # If tests fail

# Repeat until found
# Git will eventually say: "X is the first bad commit"

# Review the problematic commit
git show <commit-hash>

# End bisect session
git bisect reset

# Revert the bad commit or fix it
git revert <commit-hash>
# or
git checkout -b fix/bug-from-commit-X
```

## Clean History Pattern

Squash commits before merging:

```bash
# Feature branch with messy history
git log --oneline
# a1b2c3d fix typo
# d4e5f6g add tests
# g7h8i9j WIP checkpoint
# j0k1l2m feat: implement feature

# Interactive rebase to squash
git rebase -i HEAD~4

# In editor, change 'pick' to 'squash' (or 's') for commits to squash:
# pick j0k1l2m feat: implement feature
# squash g7h8i9j WIP checkpoint
# squash d4e5f6g add tests
# squash a1b2c3d fix typo

# Edit the commit message in next screen
# Save and close

# Force push (since history changed)
git push --force-with-lease origin feature/my-feature
```

## Cherry-pick Pattern

Apply specific commits to another branch:

```bash
# Commit on feature branch that should go to main
git log --oneline feature/experimental
# a1b2c3d fix: critical security patch
# d4e5f6g feat: experimental feature (not ready)

# Apply just the fix to main
git checkout main
git cherry-pick a1b2c3d
git push origin main

# Or cherry-pick range
git cherry-pick commit1^..commit5  # Includes commit1 through commit5
```

## Submodule Management Pattern

Working with git submodules:

```bash
# Add submodule
git submodule add https://github.com/vendor/library.git lib/vendor
git commit -m "Add vendor library as submodule"

# Clone repo with submodules
git clone --recursive https://github.com/user/repo.git
# or
git clone https://github.com/user/repo.git
git submodule init
git submodule update

# Update submodule to latest
cd lib/vendor
git checkout main
git pull
cd ../..
git add lib/vendor
git commit -m "Update vendor library submodule"

# Update all submodules
git submodule update --remote

# Remove submodule
git submodule deinit lib/vendor
git rm lib/vendor
rm -rf .git/modules/lib/vendor
git commit -m "Remove vendor library submodule"
```

## Monorepo Pattern

Managing multiple projects in one repository:

```bash
# Structure:
# /packages
#   /api
#   /web
#   /mobile
#   /shared

# Work on specific package
cd packages/web
git add .
git commit -m "feat(web): add new landing page"

# Changes affect multiple packages
git add packages/api/src/schema.ts
git add packages/web/src/types.ts
git add packages/mobile/src/types.ts
git commit -m "feat: update user schema across all packages"

# Sparse checkout for large monorepos
git sparse-checkout init --cone
git sparse-checkout set packages/web packages/shared
# Now only web and shared are checked out
```

## Refactoring Pattern

Large refactoring with safe steps:

```bash
# Create refactor branch
git checkout -b refactor/modernize-auth

# Small, atomic commits for each step
git add src/auth/types.ts
git commit -m "refactor(auth): extract types to separate file"

git add src/auth/utils.ts
git commit -m "refactor(auth): extract utility functions"

git add src/auth/service.ts
git commit -m "refactor(auth): update service to use new structure"

git add src/auth/index.ts
git commit -m "refactor(auth): update exports"

# Each commit compiles and passes tests
npm test  # After each commit

# If something breaks, easy to find which commit
git bisect start
git bisect bad
git bisect good HEAD~10
```

## Backup Before Risky Operation

Create safety net:

```bash
# Before complex rebase/merge
git branch backup-before-rebase

# Do risky operation
git rebase -i HEAD~20

# If it goes wrong
git reset --hard backup-before-rebase

# If it went well, delete backup
git branch -D backup-before-rebase
```

## Working with Multiple Remotes

Contribute to multiple forks:

```bash
# Setup
git remote -v
git remote add upstream https://github.com/original/repo.git
git remote add colleague https://github.com/colleague/repo.git

# Fetch from all
git fetch --all

# See all branches
git branch -a

# Create local branch from colleague's work
git checkout -b review-colleague colleague/feature-x

# Merge colleague's work with upstream changes
git fetch upstream
git merge upstream/main

# Push to your fork
git push origin review-colleague
```

## Tag Management Pattern

Semantic versioning with tags:

```bash
# Create annotated tag
git tag -a v1.2.3 -m "Release version 1.2.3: Bug fixes and improvements"

# Tag specific commit
git tag -a v1.2.2 9fceb02 -m "Release version 1.2.2"

# Push tags
git push origin v1.2.3
# or all tags
git push origin --tags

# List tags
git tag -l "v1.*"

# Show tag details
git show v1.2.3

# Delete tag
git tag -d v1.2.3
git push origin --delete v1.2.3

# Checkout tag
git checkout v1.2.3
git checkout -b fix-on-1.2.3 v1.2.3  # Create branch from tag
```

## Worktree Pattern

Multiple working directories:

```bash
# Main work in main directory
pwd  # /home/user/project

# Need to review PR while keeping current work
git worktree add ../project-pr-123 pr-123-branch

# Work in separate directory
cd ../project-pr-123
# Make changes, test, etc.

# Both directories share same repository
# Commits in either affect the shared .git

# List worktrees
git worktree list

# Remove worktree
git worktree remove ../project-pr-123
# or
rm -rf ../project-pr-123
git worktree prune
```

## Partial Clone Pattern

Clone large repos efficiently:

```bash
# Shallow clone (recent history only)
git clone --depth 1 https://github.com/user/large-repo.git

# Fetch more history later
git fetch --deepen=100

# Partial clone (recent commits, download objects as needed)
git clone --filter=blob:none https://github.com/user/large-repo.git

# Shallow clone single branch
git clone --depth 1 --single-branch --branch main https://github.com/user/repo.git
```

## Archive Pattern

Export code without git history:

```bash
# Create zip archive of current state
git archive --format=zip --output=project-v1.0.0.zip HEAD

# Archive specific branch
git archive --format=zip --output=feature.zip feature-branch

# Archive with prefix
git archive --format=tar --prefix=myproject/ HEAD | gzip > myproject.tar.gz

# Archive specific directory
git archive --format=zip --output=docs.zip HEAD:docs/
```

## Maintenance Patterns

### Clean Up Merged Branches

```bash
# List merged branches
git branch --merged main

# Delete merged branches (except main/develop)
git branch --merged main | grep -v "main\|develop" | xargs git branch -d

# Delete remote merged branches
git branch -r --merged main | grep -v "main\|develop" | sed 's/origin\///' | xargs -I {} git push origin --delete {}
```

### Optimize Repository

```bash
# Garbage collection
git gc --aggressive --prune=now

# Check repository integrity
git fsck --full

# Count objects
git count-objects -vH

# Remove untracked files
git clean -fd
git clean -fdx  # Including ignored files
```

### Find Large Files in History

```bash
# Find large files
git rev-list --objects --all \
  | git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
  | sed -n 's/^blob //p' \
  | sort --numeric-sort --key=2 \
  | tail -10

# Remove large file from history (careful!)
git filter-branch --tree-filter 'rm -f path/to/large/file' HEAD
```

## Anti-patterns to Avoid

### ❌ Don't: Commit directly to main

```bash
# Bad
git checkout main
git add .
git commit -m "quick fix"
git push
```

### ✅ Do: Use feature branches

```bash
# Good
git checkout -b fix/issue-123
git add specific-file.js
git commit -m "fix: resolve issue #123"
git push -u origin fix/issue-123
# Create PR
```

### ❌ Don't: Force push to shared branches

```bash
# Bad
git push --force origin main
```

### ✅ Do: Use --force-with-lease on your branches

```bash
# Good
git push --force-with-lease origin feature/my-work
```

### ❌ Don't: Commit sensitive data

```bash
# Bad
git add .env
git add credentials.json
```

### ✅ Do: Use .gitignore and check before committing

```bash
# Good
echo ".env" >> .gitignore
echo "credentials.json" >> .gitignore
git add .gitignore
git status  # Verify no sensitive files
```

## Quick Reference

| Task                          | Command                                           |
| :---------------------------- | :------------------------------------------------ |
| Start feature                 | `git checkout -b feature/name`                    |
| Save WIP                      | `git stash push -m "description"`                 |
| Update from main              | `git rebase main`                                 |
| Squash commits                | `git rebase -i HEAD~n`                            |
| Undo last commit (keep files) | `git reset --soft HEAD~1`                         |
| Undo last commit (lose files) | `git reset --hard HEAD~1`                         |
| See what changed              | `git diff`                                        |
| See commit history            | `git log --oneline --graph`                       |
| Find a commit                 | `git log --grep="search"`                         |
| Apply specific commit         | `git cherry-pick <hash>`                          |
| Create backup branch          | `git branch backup-$(date +%Y%m%d)`               |
| Delete merged branches        | `git branch --merged \| grep -v main \| xargs -d` |
