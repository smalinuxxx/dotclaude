#!/bin/bash
set -euo pipefail

# YOLO Mode - Run Claude Code in sandboxed Docker container
# Usage: ./yolo.sh [options] [claude-args...]

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGE_NAME="claude-yolo"
CONTAINER_NAME="claude-yolo-$$"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_banner() {
    echo -e "${YELLOW}"
    echo "╔═══════════════════════════════════════════╗"
    echo "║         YOLO MODE - Claude Code           ║"
    echo "║   Sandboxed • Network Isolated • Safe     ║"
    echo "╚═══════════════════════════════════════════╝"
    echo -e "${NC}"
}

usage() {
    cat << EOF
Usage: ./yolo.sh [options] [claude-args...]

Options:
  --build       Force rebuild Docker image
  --shell       Open shell instead of Claude
  --test        Run firewall and blocker tests
  --no-yolo     Run without --dangerously-skip-permissions
  -h, --help    Show this help

Examples:
  ./yolo.sh                    # Start Claude in YOLO mode
  ./yolo.sh "fix the bug"      # Start with a prompt
  ./yolo.sh --continue         # Continue last session
  ./yolo.sh --shell            # Debug shell access
  ./yolo.sh --test             # Run security tests
EOF
}

build_image() {
    echo -e "${GREEN}Building Docker image...${NC}"
    docker build \
        --build-arg TZ="${TZ:-$(cat /etc/timezone 2>/dev/null || echo 'UTC')}" \
        --build-arg CLAUDE_CODE_VERSION="${CLAUDE_CODE_VERSION:-latest}" \
        -t "$IMAGE_NAME" \
        "$SCRIPT_DIR/.devcontainer"
}

check_image() {
    if ! docker image inspect "$IMAGE_NAME" &>/dev/null; then
        echo -e "${YELLOW}Image not found. Building...${NC}"
        build_image
    fi
}

run_container() {
    local cmd=("$@")

    docker run -it --rm \
        --name "$CONTAINER_NAME" \
        --cap-add=NET_ADMIN \
        --cap-add=NET_RAW \
        --hostname yolo \
        -e "TERM=${TERM:-xterm-256color}" \
        -e "CLAUDE_CONFIG_DIR=/home/node/.claude" \
        -e "NODE_OPTIONS=--max-old-space-size=4096" \
        -v "$PWD:/workspace:delegated" \
        -v "${HOME}/.claude:/home/node/.claude" \
        -w /workspace \
        "$IMAGE_NAME" \
        "${cmd[@]}"
}

# Parse arguments
FORCE_BUILD=false
SHELL_MODE=false
TEST_MODE=false
YOLO_MODE=true
CLAUDE_ARGS=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        --build)
            FORCE_BUILD=true
            shift
            ;;
        --shell)
            SHELL_MODE=true
            shift
            ;;
        --test)
            TEST_MODE=true
            shift
            ;;
        --no-yolo)
            YOLO_MODE=false
            shift
            ;;
        -h|--help)
            usage
            exit 0
            ;;
        *)
            CLAUDE_ARGS+=("$1")
            shift
            ;;
    esac
done

# Main
print_banner

if [[ "$FORCE_BUILD" == true ]]; then
    build_image
else
    check_image
fi

if [[ "$TEST_MODE" == true ]]; then
    echo -e "${GREEN}Running security tests...${NC}"
    run_container /bin/bash -c "
        sudo /usr/local/bin/init-firewall.sh &&
        /usr/local/bin/block-dangerous.sh &&
        echo '' &&
        echo '==================== FIREWALL TESTS ====================' &&
        /usr/local/bin/test-firewall.sh &&
        echo '' &&
        echo '==================== BLOCKER TESTS ====================' &&
        /usr/local/bin/test-blockers.sh
    "
elif [[ "$SHELL_MODE" == true ]]; then
    echo -e "${GREEN}Starting debug shell...${NC}"
    run_container /bin/bash -c "sudo /usr/local/bin/init-firewall.sh && /usr/local/bin/block-dangerous.sh && exec zsh"
else
    echo -e "${GREEN}Starting Claude Code in YOLO mode...${NC}"
    echo -e "${YELLOW}Network: Isolated (GitHub, npm, Anthropic only)${NC}"
    echo -e "${YELLOW}Git push: Blocked${NC}"
    echo ""

    if [[ "$YOLO_MODE" == true ]]; then
        CLAUDE_CMD="claude --dangerously-skip-permissions"
    else
        CLAUDE_CMD="claude"
    fi

    # Build the full command
    FULL_CMD="sudo /usr/local/bin/init-firewall.sh && /usr/local/bin/block-dangerous.sh && exec $CLAUDE_CMD"

    if [[ ${#CLAUDE_ARGS[@]} -gt 0 ]]; then
        # Escape args for shell
        for arg in "${CLAUDE_ARGS[@]}"; do
            FULL_CMD+=" $(printf '%q' "$arg")"
        done
    fi

    run_container /bin/bash -c "$FULL_CMD"
fi
