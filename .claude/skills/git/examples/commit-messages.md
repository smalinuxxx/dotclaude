# Git Commit Message Guide

Best practices and conventions for writing clear, useful commit messages.

## The Seven Rules

1. **Separate subject from body with a blank line**
2. **Limit the subject line to 50 characters**
3. **Capitalize the subject line**
4. **Do not end the subject line with a period**
5. **Use the imperative mood in the subject line**
6. **Wrap the body at 72 characters**
7. **Use the body to explain what and why vs. how**

## Basic Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

## Conventional Commits

### Types

- **feat**: A new feature
- **fix**: A bug fix
- **docs**: Documentation only changes
- **style**: Changes that don't affect code meaning (whitespace, formatting)
- **refactor**: Code change that neither fixes a bug nor adds a feature
- **perf**: Performance improvement
- **test**: Adding missing tests or correcting existing tests
- **build**: Changes to build system or dependencies
- **ci**: Changes to CI configuration files and scripts
- **chore**: Other changes that don't modify src or test files
- **revert**: Reverts a previous commit

### Scope (Optional)

The scope specifies what part of the codebase is affected:

- `auth`: Authentication system
- `api`: API layer
- `ui`: User interface
- `db`: Database
- `config`: Configuration
- etc.

### Subject Line

- Use imperative mood: "Add feature" not "Added feature"
- No capitalization for first word after type
- No period at the end
- Keep it concise but descriptive

### Body (Optional but recommended)

- Explain **what** changed and **why**, not **how**
- Wrap at 72 characters
- Separate from subject with blank line
- Can have multiple paragraphs

### Footer (Optional)

- Reference issues: `Fixes #123` or `Closes #456`
- Breaking changes: `BREAKING CHANGE: ...`
- Other metadata

## Examples

### Simple Fix

```
fix(auth): prevent token expiration edge case

Users were logged out incorrectly when system time changed during
their session. Now using server timestamp for all time comparisons.

Fixes #234
```

### New Feature

```
feat(dashboard): add real-time activity feed

Implement WebSocket connection for live updates. Users now see
activity as it happens without refreshing the page.

- Add WebSocket client connection
- Implement activity event handlers
- Add UI component for activity stream
- Include reconnection logic for dropped connections

Closes #567
```

### Breaking Change

```
feat(api)!: change authentication endpoint structure

BREAKING CHANGE: The /auth endpoint now returns tokens in a different
format. Clients must update to handle the new response structure.

Before:
  { token: "abc123" }

After:
  {
    accessToken: "abc123",
    refreshToken: "def456",
    expiresIn: 3600
  }

Migration guide: docs/migration/v2-auth.md
```

### Refactoring

```
refactor(payments): extract stripe integration to service

Move stripe-specific code out of the payment controller into a
dedicated service class. This improves testability and makes it
easier to support multiple payment providers.

No functional changes.
```

### Documentation

```
docs(api): update authentication examples

Add examples for OAuth flow and refresh token usage. Fix outdated
endpoint URLs.
```

### Performance Improvement

```
perf(database): optimize user query with indexes

Add composite index on (user_id, created_at) to speed up timeline
queries. Reduces query time from ~800ms to ~50ms for users with
large datasets.
```

### Test Addition

```
test(auth): add coverage for password reset flow

Add integration tests for:
- Valid reset token
- Expired reset token
- Invalid reset token
- Rate limiting

Increases auth test coverage from 76% to 94%.
```

## Good vs. Bad Examples

### ❌ Bad Examples

```
Update stuff
```

*Too vague - what was updated?*

```
Fixed bug
```

*Which bug? What was the problem?*

```
WIP
```

*Not descriptive at all*

```
feat(api): add new endpoint and fix some bugs and update docs and refactor code
```

*Too much in one commit - should be separate commits*

```
Fix authentication bug that was causing users to get logged out unexpectedly when the session token expired due to an edge case in the time comparison logic
```

*Subject line too long*

```
added user profile page
```

*Not imperative mood, should be "Add user profile page"*

```
feat: implementing the new dashboard feature.
```

*Has a period, not imperative mood*

### ✅ Good Examples

```
feat(profile): add user avatar upload

Allow users to upload and crop profile pictures. Images are
automatically resized to 200x200 and optimized for web.

Closes #123
```

```
fix(cart): prevent duplicate items on fast clicks

Add debouncing to "Add to Cart" button to prevent duplicate entries
when users double-click. Also show loading state during the operation.

Fixes #456
```

```
refactor: extract validation logic to utils

Move validation functions from controllers to shared utils for
better reusability and testing.
```

```
docs: add API rate limiting documentation

Document rate limits and headers returned by the API.
```

```
test(checkout): add payment failure scenarios

Cover edge cases:
- Card declined
- Network timeout
- Insufficient funds
```

## Conventional Commit Format Examples

### Feature Commits

```
feat(auth): implement OAuth 2.0 login

feat(api): add pagination to user list endpoint

feat(ui): add dark mode toggle

feat: add user notification preferences
```

### Bug Fixes

```
fix(auth): correct token refresh logic

fix(api): handle null values in user profile

fix(ui): resolve button alignment on mobile

fix: prevent memory leak in event listeners
```

### Documentation

```
docs: update installation instructions

docs(api): add examples for search endpoint

docs: fix broken links in contributing guide
```

### Code Quality

```
style(auth): format code according to style guide

refactor(api): simplify error handling logic

perf(db): optimize queries with eager loading

test(auth): increase coverage for edge cases
```

### Build and Configuration

```
build: update dependencies to latest versions

build(deps): bump react from 17.0.1 to 18.0.0

ci: add automated security scanning

ci: fix failing test pipeline

chore: update .gitignore for node_modules

chore(deps): remove unused dependencies
```

## Special Cases

### Multiple Authors

```
feat(analytics): add user behavior tracking

Co-authored-by: Alice Smith <alice@example.com>
Co-authored-by: Claude Sonnet 4.5 <noreply@anthropic.com>
```

### Reverts

```
revert: feat(api): add pagination to user list

This reverts commit abc123def456. The pagination implementation
caused performance issues on large datasets.
```

### Work in Progress (Avoid in main branch)

```
wip: experiment with new caching strategy

Note: This is exploratory work and not ready for production.
```

## Commit Message Templates

### Standard Template

Create `.gitmessage`:

```
# <type>(<scope>): <subject>

# <body>

# <footer>

# Types: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
# Scope: auth, api, ui, db, config, etc.
# Subject: imperative mood, no period, max 50 chars
# Body: explain what and why (not how), wrap at 72 chars
# Footer: reference issues (Fixes #123), breaking changes
```

Configure git to use it:

```bash
git config --global commit.template ~/.gitmessage
```

### With Checklist

```
# <type>(<scope>): <subject>

# <body>

# Checklist:
# [ ] Tests added/updated
# [ ] Documentation updated
# [ ] No breaking changes (or documented)
# [ ] Follows code style guidelines

# <footer>
```

## Team Conventions

Example team-specific conventions:

### Jira Integration

```
feat(PROJ-123): add user settings page

Implement user preferences UI with save functionality.

Jira: PROJ-123
```

### Include Ticket Numbers

```
fix: resolve login timeout issue (#234)

Users experiencing timeouts on slow connections can now authenticate
successfully with increased timeout limit.
```

### Pair Programming

```
feat(api): implement rate limiting

Implemented together during pairing session to prevent API abuse.

Co-authored-by: Bob Johnson <bob@example.com>
```

## Commit Message Anti-patterns

### Things to Avoid

❌ **Vague messages**
```
Update files
Changed some code
Fixes
```

❌ **Too much detail in subject**
```
feat(api): add user authentication endpoint with JWT tokens and refresh token support and rate limiting and...
```

❌ **Implementation details in subject**
```
fix: change timeout from 30s to 60s in line 42 of auth.ts
```

Better:
```
fix(auth): increase connection timeout for slow networks

Changed timeout from 30s to 60s to accommodate users on
slow connections.
```

❌ **Multiple unrelated changes**
```
feat: add dark mode and fix login bug and update dependencies
```

Better: Split into three commits

❌ **Passive voice**
```
The authentication bug was fixed
The new feature has been added
```

Better:
```
fix(auth): resolve token validation bug
feat: add user dashboard
```

## Automation and Tooling

### Commitlint

Enforce commit message conventions:

```bash
npm install --save-dev @commitlint/cli @commitlint/config-conventional

echo "module.exports = {extends: ['@commitlint/config-conventional']}" > commitlint.config.js
```

### Husky Git Hooks

Run commitlint on commit:

```bash
npm install --save-dev husky

npx husky install
npx husky add .husky/commit-msg 'npx --no -- commitlint --edit ${1}'
```

### Commitizen

Interactive commit message builder:

```bash
npm install --save-dev commitizen cz-conventional-changelog

# Add to package.json:
{
  "config": {
    "commitizen": {
      "path": "./node_modules/cz-conventional-changelog"
    }
  }
}

# Use with:
git cz  # instead of git commit
```

## Generating Changelogs

With conventional commits, you can auto-generate changelogs:

```bash
npm install --save-dev standard-version

# Generate CHANGELOG.md and bump version
npx standard-version

# For first release
npx standard-version --first-release
```

## Language-Specific Examples

### JavaScript/TypeScript

```
feat(hooks): add useLocalStorage hook

test(utils): add coverage for date formatting

refactor(api): convert callbacks to async/await

style: apply prettier formatting
```

### Python

```
feat(models): add User model with authentication

fix(views): handle edge case in pagination

test(services): add unit tests for email service

docs(api): update docstrings for public methods
```

### Go

```
feat(server): implement graceful shutdown

fix(db): correct transaction rollback logic

perf(cache): reduce memory allocation in hot path

refactor(handlers): extract middleware to separate package
```

## Review Checklist

Before committing, verify:

- [ ] Subject line is clear and concise (<50 chars)
- [ ] Uses imperative mood ("Add" not "Added")
- [ ] Includes type prefix if using conventional commits
- [ ] Body explains what and why (if needed)
- [ ] References related issues/tickets
- [ ] No typos or grammatical errors
- [ ] Commit is atomic (one logical change)
- [ ] Tests are included/updated if needed

## Resources

- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)
- [Git commit best practices](https://chris.beams.io/posts/git-commit/)
- [Angular commit guidelines](https://github.com/angular/angular/blob/master/CONTRIBUTING.md#commit)
