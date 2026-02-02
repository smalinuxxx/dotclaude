# Coding Conventions

**Analysis Date:** 2026-02-02

## Naming Patterns

**Files:**
- kebab-case for shell scripts (block-dangerous.sh, init-firewall.sh, test-blockers.sh)
- kebab-case for JavaScript files (gsd-check-update.js, gsd-statusline.js)
- UPPERCASE for markdown documentation (CONVENTIONS.md, TESTING.md, README.md)
- index.ts or barrel files for re-exports

**Functions:**
- camelCase for JavaScript/Node.js functions (createTestUser, configureWrapper)
- snake_case for bash function names (init_firewall, check_image) - though most bash code uses function expressions rather than function declarations
- handleEventName pattern for event handlers where applicable
- Descriptive function names that explain intent (print_banner, build_image, run_container)

**Variables:**
- camelCase for JavaScript variables (cacheDir, cacheFile, homeDir)
- UPPER_SNAKE_CASE for constants: SCRIPT_DIR, IMAGE_NAME, CONTAINER_NAME, BLOCKED_COMMANDS
- UPPER_SNAKE_CASE for shell environment variables: PATH, WRAPPER_DIR, DOCKER_DNS_RULES
- lowercase_with_underscores for local bash variables in some contexts

**Types:**
- Implicit (no TypeScript in core; markdown documents use interface-style descriptions)
- JSON configuration uses camelCase keys (update_available, installed, latest)

## Code Style

**Formatting:**
- 2-space indentation standard (seen in shell scripts, Node.js code, markdown)
- No enforced line length limit observed, but code tends to stay under 100 characters
- Consistent quote usage: single quotes in bash ('GITEOF', 'config'), double quotes for variable expansion
- Semicolons required in shell scripts: set -euo pipefail is standard at start
- Trailing newlines present in all files

**Linting:**
- No eslint or prettier config detected in codebase
- Bash code follows ShellCheck conventions (set -euo pipefail at top)
- Bash strict mode used consistently: set -euo pipefail, IFS=$'\n\t'
- No formal linting tool detected; style maintained through convention

## Import Organization

**Order (JavaScript/Node.js):**
1. Built-in Node modules (fs, path, os, child_process)
2. External packages (rarely used)
3. Destructured imports grouped together

**Pattern:**
```javascript
// Example from gsd-check-update.js
const fs = require('fs');
const path = require('path');
const os = require('os');
const { spawn } = require('child_process');
```

**Path Organization:**
- Relative paths used: ./external, ../types
- No path aliases detected
- Full paths constructed with path.join() for cross-platform compatibility

## Error Handling

**Patterns:**
- Bash: set -euo pipefail prevents silent failures (exit on error, undefined vars, pipe failures)
- Bash: 2>/dev/null to suppress error output where expected (optional operations)
- Bash: || true to allow command failure without exiting
- JavaScript: try/catch blocks for JSON parsing, file operations
- JavaScript: silent fail pattern for non-critical operations (gsd-statusline.js line 85: catch (e) { // Silent fail })
- Explicit exit codes in bash: exit 0 for success, exit 1 for errors

**Error Messages:**
- Clear, user-facing messages with context: "❌ BLOCKED: 'git push' is disabled in YOLO mode"
- Include reason when blocking operations: "Reason: Prevents accidental pushes to remote repositories"
- Error messages use emoji for visual distinction (❌, ✓, 💀)

## Logging

**Framework:**
- Bash: echo with color codes ($GREEN, $YELLOW, $RED) via ANSI escape sequences
- JavaScript: console operations (console.stdout.write for statusline)
- No structured logging framework detected
- Silent execution for background processes (/dev/null redirection)

**Patterns:**
- Status messages use colors: echo -e "${GREEN}..." for success, "${YELLOW}..." for warnings, "${RED}..." for errors
- Progress messages printed to inform user of state changes
- Background processes run with stdio: 'ignore' to avoid output leakage
- Structured output for CLI (banner, section dividers, status lists)

**Location:**
- Logging done at user-facing boundaries (main shell script, hooks)
- Not in utility functions or libraries

## Comments

**When to Comment:**
- Explain complex logic or non-obvious operations
- Document safety considerations and security decisions
- Clarify intent for maintainers: "# Exit on error, undefined vars, and pipeline failures"
- Explain workarounds and special cases

**Style:**
- Bash: # for line comments, multi-line comments as sequential lines
- JavaScript: // for single-line, /* */ for blocks
- Markdown: native markdown comments using HTML syntax (<!-- comment -->)

**Comment Examples:**
```bash
# Extract Docker DNS info BEFORE any flushing (order matters)
# Check if this is a blocked command
# Allow outbound DNS
```

## Function Design

**Size:**
- Keep functions under 50 lines where possible
- Bash functions tend to be shorter, using command pipelines
- Extract helpers for repeated patterns

**Parameters:**
- Bash: uses positional parameters ($1, $2, "$@") instead of named params
- JavaScript: use options object for 4+ parameters
- Destructuring common for options: function process({ id, name })

**Return Values:**
- Bash: return exit codes (0 for success, non-zero for failure)
- Bash: use command substitution for returning values: $(function)
- JavaScript: explicit return statements
- No implicit returns

## Module Design

**Exports:**
- Bash scripts: executable scripts with shebangs (#!/bin/bash)
- JavaScript: use require/module.exports or ES6 imports where needed
- No barrel files detected (code is primarily scripts, not libraries)

**Script Organization:**
- Declarative phase (variable definitions, color setup)
- Function definitions
- Main execution logic at bottom
- Early exit checks (help, version, error conditions)

**Example Structure (from yolo.sh):**
```bash
# 1. Setup
SCRIPT_DIR="..."
IMAGE_NAME="..."

# 2. Helper functions
print_banner() { ... }
usage() { ... }
build_image() { ... }

# 3. Main logic
main() {
  # parse args
  # execute based on flags
}
```

---

*Convention analysis: 2026-02-02*
*Update when patterns change*
