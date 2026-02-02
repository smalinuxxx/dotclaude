#!/bin/bash
# Test command blocking configuration
# Run inside the container to verify dangerous commands are blocked

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "Testing Command Blockers..."
echo ""

PASS=0
FAIL=0

test_blocked_command() {
    local desc="$1"
    local cmd="$2"

    echo -n "Testing: $desc ... "

    # Run command and capture exit code
    if eval "$cmd" >/dev/null 2>&1; then
        echo -e "${RED}FAIL - Command should be blocked!${NC}"
        ((FAIL++))
    else
        # Check if it was blocked by our wrapper (exit code should be 1)
        if [ $? -eq 1 ]; then
            echo -e "${GREEN}PASS - Blocked as expected${NC}"
            ((PASS++))
        else
            echo -e "${YELLOW}WARN - Blocked but unexpected exit code${NC}"
            ((PASS++))
        fi
    fi
}

test_allowed_command() {
    local desc="$1"
    local cmd="$2"

    echo -n "Testing: $desc ... "

    if eval "$cmd" >/dev/null 2>&1; then
        echo -e "${GREEN}PASS - Allowed as expected${NC}"
        ((PASS++))
    else
        echo -e "${RED}FAIL - Command should be allowed!${NC}"
        ((FAIL++))
    fi
}

echo "========================================"
echo "Testing BLOCKED commands:"
echo "========================================"

# Git push variants
test_blocked_command "git push" "git push"
test_blocked_command "git push --force" "git push --force"
test_blocked_command "git push -f" "git push -f"
test_blocked_command "git push --force-with-lease" "git push --force-with-lease"

# System commands
test_blocked_command "reboot" "reboot"
test_blocked_command "shutdown" "shutdown now"
test_blocked_command "poweroff" "poweroff"

# Dangerous rm
test_blocked_command "rm -rf /" "rm -rf /"
test_blocked_command "rm -rf /etc" "rm -rf /etc"
test_blocked_command "rm -rf /usr" "rm -rf /usr"

echo ""
echo "========================================"
echo "Testing ALLOWED commands:"
echo "========================================"

# Safe git commands
test_allowed_command "git status" "git status"
test_allowed_command "git log" "git log --oneline -1"
test_allowed_command "git diff" "git diff"

# Safe file operations
test_allowed_command "ls" "ls -la"
test_allowed_command "echo" "echo 'test'"

echo ""
echo "========================================"
echo "Wrapper verification:"
echo "========================================"

echo -n "Checking git wrapper ... "
if which git | grep -q "/home/node/.local/bin/git"; then
    echo -e "${GREEN}PASS - Using wrapper${NC}"
    ((PASS++))
else
    echo -e "${RED}FAIL - Not using wrapper!${NC}"
    ((FAIL++))
fi

echo -n "Checking PATH order ... "
if echo "$PATH" | grep -q "^/home/node/.local/bin"; then
    echo -e "${GREEN}PASS - Wrappers first in PATH${NC}"
    ((PASS++))
else
    echo -e "${RED}FAIL - Wrappers not first in PATH!${NC}"
    ((FAIL++))
fi

echo ""
echo "========================================"
echo "Summary:"
echo "========================================"
echo -e "${GREEN}$PASS passed${NC}, ${RED}$FAIL failed${NC}"

if [ $FAIL -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✓ All tests passed! Command blockers working correctly.${NC}"
    exit 0
else
    echo ""
    echo -e "${RED}✗ Some tests failed. Check blocker configuration.${NC}"
    exit 1
fi
