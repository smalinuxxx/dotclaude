# Testing Patterns

**Analysis Date:** 2026-02-02

## Test Framework

**Runner:**
- No automated test framework detected
- Testing done manually via shell scripts (test-blockers.sh, test-firewall.sh)

**Assertion Library:**
- No JavaScript test framework (no Jest, Vitest, Mocha)
- Bash scripts use command exit codes and output verification
- Manual assertions via bash conditionals and regex matching

**Run Commands:**
```bash
./yolo.sh --test                 # Run security tests (firewall + blockers)
./.devcontainer/test-firewall.sh # Run firewall validation tests
./.devcontainer/test-blockers.sh # Run command blocker validation tests
```

## Test File Organization

**Location:**
- Test scripts colocated with source: `.devcontainer/test-firewall.sh`, `.devcontainer/test-blockers.sh`
- No separate tests/ directory for unit tests
- Tests are integration-style, validating the entire system

**Naming:**
- test-[component].sh for shell script tests
- No .test.js or .test.ts files detected
- Scripts are executable with #!/bin/bash shebang

**Structure:**
```
.devcontainer/
  block-dangerous.sh          # Implementation
  test-blockers.sh            # Validation tests
  init-firewall.sh            # Implementation
  test-firewall.sh            # Validation tests
  Dockerfile                  # Docker config
```

## Test Structure

**Suite Organization:**
```bash
# From test-firewall.sh - example structure
#!/bin/bash
set -euo pipefail

# Test helper functions
test_dns_allowed() {
  # Test code
}

test_github_access() {
  # Test code
}

test_npm_access() {
  # Test code
}

# Main test execution
echo "Running firewall tests..."
test_dns_allowed && echo "✓ Test passed" || echo "✗ Test failed"
```

**Patterns:**
- Each test is a separate bash function
- Tests use conditional logic and exit codes
- Echo output for pass/fail reporting
- Tests run sequentially, not in parallel
- No beforeEach/afterEach setup; tests are independent

**Execution Pattern:**
- Tests executed directly by yolo.sh via --test flag
- Integration tests validate end-to-end system behavior
- Tests run inside Docker container to verify sandbox environment

## Mocking

**Framework:**
- No mocking framework (Jest, Sinon, Vitest)
- Bash tests use actual command execution (curl, dig, nc)
- Network tests validate real connectivity (with timeout fallback)

**Patterns:**
```bash
# From init-firewall.sh - validate curl behavior
gh_ranges=$(curl -s https://api.github.com/meta)
if [ -z "$gh_ranges" ]; then
    echo "ERROR: Failed to fetch GitHub IP ranges"
    exit 1
fi

# From test-firewall.sh - verify DNS resolution
dig +short api.github.com | grep -q '[0-9]' || echo "DNS failed"
```

**What to Test:**
- Network connectivity (DNS, HTTP)
- Command execution and blocking
- Firewall rules and iptables configuration
- File system operations (chmod, mkdir)

**What NOT to Mock:**
- External APIs (test real connectivity to validate)
- Command execution (need actual command testing)
- Firewall rules (must verify in container environment)

## Fixtures and Factories

**Test Data:**
- No fixture files detected
- Tests use inline data and real external services
- Test commands run against actual GitHub API, npmjs.org, etc.

**Example from init-firewall.sh:**
```bash
# Resolve and add other allowed domains
for domain in \
    "registry.npmjs.org" \
    "api.anthropic.com" \
    "sentry.io" \
    "statsig.anthropic.com" \
    "statsig.com" \
    "marketplace.visualstudio.com" \
    "vscode.blob.core.windows.net" \
    "update.code.visualstudio.com"; do
    echo "Resolving $domain..."
    ips=$(dig +noall +answer A "$domain" | awk '$4 == "A" {print $5}')
done
```

**Location:**
- Domain lists hard-coded in scripts
- Test expectations embedded in bash conditionals
- No separate fixtures directory

## Coverage

**Requirements:**
- No enforced coverage target
- No coverage reporting tool detected
- Testing focused on critical paths (security, network isolation, command blocking)

**Approach:**
- Behavior-driven: verify the system works as intended
- Integration-focused: test components together in Docker container
- Manual verification: developer runs tests to validate changes

**View Results:**
```bash
./yolo.sh --test
# Output shows pass/fail for each test group
```

## Test Types

**Integration Tests:**
- Firewall tests (test-firewall.sh): validate network isolation rules
- Command blocker tests (test-blockers.sh): verify dangerous commands are blocked
- Full system test: yolo.sh --test runs complete validation suite
- Tests run in actual Docker container with real iptables, networking

**Example: test-firewall.sh patterns:**
- Verify DNS works (dig commands)
- Verify allowed domains accessible (curl to GitHub, npm)
- Verify blocked domains unreachable
- Verify localhost traffic works
- Verify SSH allowed (port 22)

**Example: test-blockers.sh patterns:**
```bash
# Test that git push is blocked
if git push origin main 2>&1 | grep -q "BLOCKED"; then
    echo "✓ git push blocked"
else
    echo "✗ git push not blocked"
fi
```

**Unit Tests:**
- Not used; code is primarily scripts without isolated testable units
- Functions tested via integration tests

**E2E Tests:**
- Full system test via yolo.sh: builds container, runs tests, validates security

## Common Patterns

**Command Validation:**
```bash
# Verify command fails as expected
if ! git push origin main 2>&1 | grep -q "BLOCKED"; then
    echo "ERROR: git push was not blocked"
    exit 1
fi
```

**Network Testing:**
```bash
# Test connectivity to allowed domain
if curl -s --max-time 5 https://api.github.com/meta | jq -e '.web' >/dev/null; then
    echo "✓ GitHub API accessible"
else
    echo "✗ GitHub API blocked"
fi
```

**Exit Code Validation:**
```bash
# Tests rely on exit codes for success/failure
command_that_should_fail || exit_code=$?
if [ $exit_code -ne 1 ]; then
    echo "ERROR: Expected exit code 1, got $exit_code"
    exit 1
fi
```

**Conditional Testing:**
```bash
# From test-firewall.sh - conditional test execution
if command -v aggregate >/dev/null 2>&1; then
    # aggregate command available, test can run
    echo "Running aggregate tests..."
else
    echo "Skipping aggregate tests (not installed)"
fi
```

**Output Validation:**
```bash
# Verify command output matches expected pattern
output=$(curl -s https://api.github.com/meta | jq -r '.web[]')
if echo "$output" | grep -q '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}'; then
    echo "✓ IP ranges retrieved"
else
    echo "✗ Invalid IP range format"
fi
```

## Manual Testing Approach

**Security Validation:**
1. Build Docker image: `./yolo.sh --build`
2. Run test suite: `./yolo.sh --test`
3. Shell access for debugging: `./yolo.sh --shell`
4. Manual smoke tests: verify Claude Code functionality in container

**Test Execution Flow:**
- yolo.sh orchestrates test execution
- init-firewall.sh sets up network rules
- block-dangerous.sh sets up command wrappers
- test-firewall.sh validates network isolation
- test-blockers.sh validates command blocking
- Tests run sequentially with pass/fail output

---

*Testing analysis: 2026-02-02*
*Update when test patterns change*
