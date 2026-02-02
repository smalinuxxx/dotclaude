#!/bin/bash
# Block dangerous commands in YOLO mode
# This script sets up command blocking for git push and other harmful operations

set -euo pipefail

echo "Setting up command restrictions..."

# Create wrapper directory
WRAPPER_DIR="/home/node/.local/bin"
mkdir -p "$WRAPPER_DIR"

# Block git push by wrapping git
cat > "$WRAPPER_DIR/git" << 'GITEOF'
#!/bin/bash
# Git wrapper that blocks push operations

BLOCKED_COMMANDS=(
    "push"
    "push --force"
    "push -f"
    "push --force-with-lease"
)

# Check if this is a blocked command
for cmd in "${BLOCKED_COMMANDS[@]}"; do
    if [[ "$*" == *"$cmd"* ]]; then
        echo "❌ BLOCKED: 'git $cmd' is disabled in YOLO mode"
        echo "   Reason: Prevents accidental pushes to remote repositories"
        echo "   To push manually, exit the container and run: git push"
        exit 1
    fi
done

# Allow all other git commands
exec /usr/bin/git "$@"
GITEOF
chmod +x "$WRAPPER_DIR/git"

# Block dangerous system commands
for cmd in reboot shutdown poweroff halt init; do
    cat > "$WRAPPER_DIR/$cmd" << EOF
#!/bin/bash
echo "❌ BLOCKED: '$cmd' is disabled in YOLO mode"
exit 1
EOF
    chmod +x "$WRAPPER_DIR/$cmd"
done

# Block rm -rf / variations (additional safety)
cat > "$WRAPPER_DIR/rm" << 'RMEOF'
#!/bin/bash
# rm wrapper that blocks dangerous patterns

# Check for dangerous patterns
for arg in "$@"; do
    case "$arg" in
        /|/bin|/boot|/dev|/etc|/home|/lib|/lib64|/opt|/proc|/root|/run|/sbin|/srv|/sys|/tmp|/usr|/var)
            echo "❌ BLOCKED: Refusing to remove system directory: $arg"
            exit 1
            ;;
    esac
done

# Check for -rf / or --recursive / patterns
if [[ "$*" =~ (^|[[:space:]])-[a-zA-Z]*r[a-zA-Z]*f[a-zA-Z]*[[:space:]]+/([[:space:]]|$) ]] || \
   [[ "$*" =~ (^|[[:space:]])-[a-zA-Z]*f[a-zA-Z]*r[a-zA-Z]*[[:space:]]+/([[:space:]]|$) ]] || \
   [[ "$*" =~ --recursive[[:space:]]+/([[:space:]]|$) ]]; then
    echo "❌ BLOCKED: Refusing to recursively remove root filesystem"
    exit 1
fi

exec /bin/rm "$@"
RMEOF
chmod +x "$WRAPPER_DIR/rm"

# Prepend wrapper dir to PATH in shell configs
for rcfile in /home/node/.bashrc /home/node/.zshrc; do
    if [[ -f "$rcfile" ]] && ! grep -q "YOLO_WRAPPER" "$rcfile"; then
        echo '' >> "$rcfile"
        echo '# YOLO_WRAPPER: Prepend safe wrappers to PATH' >> "$rcfile"
        echo 'export PATH="/home/node/.local/bin:$PATH"' >> "$rcfile"
    fi
done

# Also export for current session
export PATH="$WRAPPER_DIR:$PATH"

echo "✓ Command restrictions active:"
echo "  - git push: BLOCKED"
echo "  - rm (dangerous patterns): BLOCKED"
echo "  - System shutdown commands: BLOCKED"
echo ""
