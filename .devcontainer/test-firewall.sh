#!/bin/bash
# Test firewall configuration
# Run inside the container to verify network isolation

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "Testing Network Isolation..."
echo ""

# Test blocked domains
BLOCKED_DOMAINS=(
    "https://example.com"
    "https://google.com"
    "https://malicious-site.com"
    "https://random-api.io"
)

# Test allowed domains
ALLOWED_DOMAINS=(
    "https://api.github.com/zen"
    "https://registry.npmjs.org"
    "https://api.anthropic.com"
)

echo "========================================"
echo "Testing BLOCKED domains (should fail):"
echo "========================================"
BLOCKED_PASS=0
BLOCKED_FAIL=0

for url in "${BLOCKED_DOMAINS[@]}"; do
    echo -n "Testing $url ... "
    if curl -s --connect-timeout 3 --max-time 5 "$url" >/dev/null 2>&1; then
        echo -e "${RED}FAIL - Should be blocked!${NC}"
        ((BLOCKED_FAIL++))
    else
        echo -e "${GREEN}PASS - Blocked as expected${NC}"
        ((BLOCKED_PASS++))
    fi
done

echo ""
echo "========================================"
echo "Testing ALLOWED domains (should work):"
echo "========================================"
ALLOWED_PASS=0
ALLOWED_FAIL=0

for url in "${ALLOWED_DOMAINS[@]}"; do
    echo -n "Testing $url ... "
    if curl -s --connect-timeout 5 --max-time 10 "$url" >/dev/null 2>&1; then
        echo -e "${GREEN}PASS - Accessible${NC}"
        ((ALLOWED_PASS++))
    else
        echo -e "${RED}FAIL - Should be accessible!${NC}"
        ((ALLOWED_FAIL++))
    fi
done

echo ""
echo "========================================"
echo "Summary:"
echo "========================================"
echo -e "Blocked domains: ${GREEN}$BLOCKED_PASS passed${NC}, ${RED}$BLOCKED_FAIL failed${NC}"
echo -e "Allowed domains: ${GREEN}$ALLOWED_PASS passed${NC}, ${RED}$ALLOWED_FAIL failed${NC}"

if [ $BLOCKED_FAIL -eq 0 ] && [ $ALLOWED_FAIL -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✓ All tests passed! Firewall is working correctly.${NC}"
    exit 0
else
    echo ""
    echo -e "${RED}✗ Some tests failed. Check firewall configuration.${NC}"
    exit 1
fi
