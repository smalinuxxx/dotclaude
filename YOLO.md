# YOLO Mode Cheatsheet

> Run Claude Code autonomously in a sandboxed Docker container with network isolation and command blocking.

## Table of Contents

- [Quick Start](#quick-start)
- [What is YOLO Mode?](#what-is-yolo-mode)
- [Security Model](#security-model)
- [Installation](#installation)
- [Usage](#usage)
- [Network Isolation](#network-isolation)
- [Command Blocking](#command-blocking)
- [File Structure](#file-structure)
- [Troubleshooting](#troubleshooting)
- [Advanced Configuration](#advanced-configuration)
- [FAQ](#faq)

---

## Quick Start

```bash
# 1. First time setup (builds Docker image)
./yolo.sh

# 2. Run with a specific task
./yolo.sh "fix the login bug"

# 3. Continue previous session
./yolo.sh --continue

# 4. Debug shell access
./yolo.sh --shell
```

---

## What is YOLO Mode?

**YOLO Mode** = **Y**ou **O**nly **L**ive **O**nce mode - runs Claude Code with `--dangerously-skip-permissions` flag, allowing it to execute commands autonomously without asking for permission each time.

### The Problem
Normal Claude Code asks for permission for every single command:
```
❯ Would you like me to run: npm install
  [y]es / [n]o / [a]lways / [v]iew
```

This becomes tedious for repetitive tasks.

### The Solution
YOLO mode bypasses all permission prompts but runs in a **secured sandbox** to prevent disasters.

### The Danger
Running `--dangerously-skip-permissions` on your host system can:
- Delete important files
- Leak secrets (`.env`, credentials)
- Push to wrong git branches
- Install malicious packages
- Brick your system configuration

### The Safe Way
This setup combines YOLO speed with sandbox safety:

| Layer | Protection |
|-------|------------|
| **Docker Container** | Filesystem isolation |
| **Network Firewall** | Blocks all but whitelisted domains |
| **Command Blocking** | Prevents `git push`, system commands |
| **Read-only Mounts** | Git config is read-only |
| **Non-root User** | Runs as `node` user |

---

## Security Model

### Three Layers of Protection

#### 1. Container Isolation
```
┌─────────────────────────────────────┐
│ Host System (Your Computer)        │
│  ├─ /home/you/important-stuff      │  ← PROTECTED
│  ├─ ~/.ssh/                        │  ← PROTECTED
│  └─ ~/.aws/                        │  ← PROTECTED
│                                     │
│  ┌───────────────────────────────┐ │
│  │ Docker Container (Sandbox)    │ │
│  │  ├─ /workspace (mounted)      │ │  ← ISOLATED
│  │  ├─ ~/.claude (mounted)       │ │  ← ISOLATED
│  │  └─ Other files (ephemeral)   │ │  ← DESTROYED on exit
│  └───────────────────────────────┘ │
└─────────────────────────────────────┘
```

#### 2. Network Firewall (iptables)
```bash
# Default policy: DROP everything
iptables -P OUTPUT DROP

# Whitelist specific services
✓ api.github.com         # Git operations
✓ registry.npmjs.org     # npm packages
✓ api.anthropic.com      # Claude API
✓ statsig.anthropic.com  # Analytics
✗ Everything else        # BLOCKED
```

**Verification:** Container cannot reach `example.com` or any non-whitelisted domain.

#### 3. Command Blocking
Dangerous commands are wrapped with blockers:

```bash
# Blocked: git push
$ git push origin main
❌ BLOCKED: 'git push' is disabled in YOLO mode
   Reason: Prevents accidental pushes to remote repositories
   To push manually, exit the container and run: git push

# Blocked: System directories
$ rm -rf /
❌ BLOCKED: Refusing to remove system directory: /

# Blocked: System shutdown
$ sudo reboot
❌ BLOCKED: 'reboot' is disabled in YOLO mode
```

---

## Installation

### Prerequisites

1. **Docker** - [Install Docker](#installing-docker)
2. **Claude Code** - Already installed on host (for config in `~/.claude`)

### Installing Docker

<details>
<summary><b>Ubuntu/Debian</b></summary>

```bash
# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list

# Install Docker
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add your user to docker group (logout/login required)
sudo usermod -aG docker $USER
```
</details>

<details>
<summary><b>macOS</b></summary>

```bash
# Install Docker Desktop
brew install --cask docker

# Or download from https://www.docker.com/products/docker-desktop
```
</details>

<details>
<summary><b>Windows</b></summary>

Download and install [Docker Desktop for Windows](https://www.docker.com/products/docker-desktop)
</details>

### Setup Files

```bash
# Clone or download the .devcontainer folder and yolo.sh
.
├── .devcontainer/
│   ├── Dockerfile
│   ├── devcontainer.json
│   ├── init-firewall.sh
│   └── block-dangerous.sh
└── yolo.sh

# Make executable
chmod +x yolo.sh
chmod +x .devcontainer/*.sh
```

---

## Usage

### Basic Commands

```bash
# Start interactive session
./yolo.sh

# Run with specific prompt
./yolo.sh "implement user authentication"

# Pass Claude Code flags
./yolo.sh --continue          # Continue last session
./yolo.sh --resume            # Resume from checkpoint
./yolo.sh --model opus        # Use different model

# Rebuild Docker image
./yolo.sh --build

# Debug mode (shell access)
./yolo.sh --shell

# Run without YOLO (keep permission prompts)
./yolo.sh --no-yolo
```

### Workflow Examples

#### Example 1: Bug Fix
```bash
./yolo.sh "Find and fix the bug causing login failures"
```

Claude will autonomously:
1. Search through code
2. Identify the issue
3. Apply fixes
4. Run tests
5. Commit changes (but NOT push)

#### Example 2: Feature Implementation
```bash
./yolo.sh "Add password reset functionality with email verification"
```

Claude will:
1. Create necessary files
2. Implement email service integration
3. Add routes/controllers
4. Write tests
5. Update documentation

#### Example 3: Refactoring
```bash
./yolo.sh "Refactor the authentication module to use dependency injection"
```

---

## Network Isolation

### How It Works

The `init-firewall.sh` script runs on container startup and:

1. **Fetches GitHub IP ranges** from GitHub API
2. **Resolves DNS** for allowed domains
3. **Creates iptables rules** to block everything except whitelist
4. **Verifies firewall** by testing blocked/allowed domains

### Allowed Domains

| Domain | Purpose | Reason |
|--------|---------|--------|
| `api.github.com` | Git operations | Clone, fetch, pull |
| `github.com` | Git SSH | SSH git operations |
| `registry.npmjs.org` | npm registry | Install packages |
| `api.anthropic.com` | Claude API | AI requests |
| `statsig.anthropic.com` | Analytics | Usage telemetry |
| `statsig.com` | Analytics backend | Telemetry |
| `sentry.io` | Error tracking | Error reporting |
| `marketplace.visualstudio.com` | VS Code extensions | Extension downloads |

### Testing Network Isolation

```bash
# Inside container
./yolo.sh --shell

# These should FAIL
curl https://example.com              # ❌ Blocked
curl https://malicious-site.com       # ❌ Blocked
curl https://random-api.com           # ❌ Blocked

# These should SUCCEED
curl https://api.github.com/zen       # ✓ Allowed
curl https://registry.npmjs.org       # ✓ Allowed
curl https://api.anthropic.com        # ✓ Allowed
```

### Adding Custom Domains

Edit `.devcontainer/init-firewall.sh`:

```bash
for domain in \
    "registry.npmjs.org" \
    "api.anthropic.com" \
    "your-custom-domain.com"; do    # Add your domain here
    echo "Resolving $domain..."
    # ... rest of the code
done
```

Then rebuild:
```bash
./yolo.sh --build
```

---

## Command Blocking

### Blocked Commands

#### Git Operations

| Command | Status | Reason |
|---------|--------|--------|
| `git push` | ❌ BLOCKED | Prevent accidental remote pushes |
| `git push --force` | ❌ BLOCKED | Prevent destructive pushes |
| `git push -f` | ❌ BLOCKED | Prevent force pushes |
| `git push --force-with-lease` | ❌ BLOCKED | Prevent force pushes |
| `git commit` | ✓ ALLOWED | Local commits are safe |
| `git add` | ✓ ALLOWED | Staging is safe |
| `git fetch` | ✓ ALLOWED | Reading remote is safe |
| `git pull` | ✓ ALLOWED | Pulling is safe |

#### System Commands

| Command | Status | Reason |
|---------|--------|--------|
| `reboot` | ❌ BLOCKED | Can't reboot host from container |
| `shutdown` | ❌ BLOCKED | Can't shutdown host |
| `poweroff` | ❌ BLOCKED | Can't poweroff host |
| `halt` | ❌ BLOCKED | Can't halt host |
| `init` | ❌ BLOCKED | Can't change init state |

#### Dangerous rm Patterns

| Command | Status | Reason |
|---------|--------|--------|
| `rm -rf /` | ❌ BLOCKED | Would delete system |
| `rm -rf /etc` | ❌ BLOCKED | Would break container |
| `rm -rf /usr` | ❌ BLOCKED | Would break system |
| `rm -rf /workspace/node_modules` | ✓ ALLOWED | Safe workspace cleanup |
| `rm file.txt` | ✓ ALLOWED | Normal file deletion |

### How Blocking Works

The `block-dangerous.sh` script creates wrapper scripts in `/home/node/.local/bin/` that intercept commands:

```bash
# Wrapper example for 'git'
/home/node/.local/bin/git → checks args → blocks or forwards to /usr/bin/git
```

This path is prepended to `$PATH` so wrappers execute first:
```bash
PATH=/home/node/.local/bin:/usr/bin:/bin
     └─ Wrappers here        └─ Real commands here
```

### Manually Pushing from Host

When you want to push (after reviewing changes):

```bash
# Exit the container (Ctrl+D or exit)
exit

# Review changes on host
git log --oneline -5
git diff origin/main

# Push from host (not blocked)
git push origin feature-branch
```

---

## File Structure

```
project/
├── .devcontainer/                    # Container configuration
│   ├── Dockerfile                    # Image definition
│   ├── devcontainer.json             # VS Code integration (optional)
│   ├── init-firewall.sh              # Network isolation setup
│   └── block-dangerous.sh            # Command blocking setup
│
├── yolo.sh                           # Main entry script
├── YOLO.md                           # This documentation
│
└── your-project-files/               # Your actual project
    ├── src/
    ├── package.json
    └── ...
```

### File Descriptions

#### `yolo.sh`
Main wrapper script that:
- Builds Docker image if needed
- Mounts current directory to `/workspace`
- Mounts `~/.claude` for config
- Starts container with security capabilities
- Runs Claude Code with `--dangerously-skip-permissions`

#### `.devcontainer/Dockerfile`
Defines the container image:
- Base: Node 20
- User: `node` (non-root)
- Tools: git, gh, npm, Claude Code CLI
- Shells: bash, zsh with oh-my-zsh
- Network: iptables, ipset for firewall

#### `.devcontainer/init-firewall.sh`
Network isolation script:
- Fetches GitHub IP ranges
- Resolves allowed domain IPs
- Configures iptables rules
- Verifies firewall works
- Runs on container startup

#### `.devcontainer/block-dangerous.sh`
Command blocking script:
- Creates wrapper scripts for dangerous commands
- Prepends wrappers to PATH
- Blocks git push, rm -rf /, system commands
- Runs after firewall initialization

#### `.devcontainer/devcontainer.json`
VS Code Dev Containers configuration (optional):
- Defines build args
- Sets up mounts
- Configures environment variables
- Installs VS Code extensions

---

## Troubleshooting

### Container Won't Start

```bash
# Check Docker is running
docker ps

# Check for port conflicts
docker ps -a | grep claude-yolo

# Remove stale containers
docker rm -f $(docker ps -aq --filter "name=claude-yolo")

# Rebuild from scratch
./yolo.sh --build
```

### Network Issues

```bash
# Debug shell
./yolo.sh --shell

# Check firewall rules
sudo iptables -L -n -v

# Test specific domain
curl -v https://api.github.com

# Check DNS resolution
nslookup api.github.com

# See firewall logs
journalctl -f | grep iptables
```

### Command Still Blocked

```bash
# Verify wrapper is active
which git
# Should show: /home/node/.local/bin/git

# Check PATH order
echo $PATH
# Should start with: /home/node/.local/bin

# View wrapper content
cat /home/node/.local/bin/git

# Bypass wrapper (use with caution)
/usr/bin/git push  # Still blocked by network firewall
```

### Git Push Still Needed

You have two options:

**Option 1: Exit and push from host (recommended)**
```bash
# Inside container
exit

# On host
git push origin main
```

**Option 2: Temporarily allow push (not recommended)**
```bash
# Inside container debug shell
./yolo.sh --shell

# Remove wrapper temporarily
rm /home/node/.local/bin/git

# Push (will still fail due to network firewall)
git push
```

### Image Build Fails

```bash
# Check disk space
df -h

# Clean Docker cache
docker system prune -af

# Build with no cache
docker build --no-cache -t claude-yolo .devcontainer/

# Check build logs
./yolo.sh --build 2>&1 | tee build.log
```

### Permission Denied Errors

```bash
# Check file ownership
ls -la .devcontainer/

# Make scripts executable
chmod +x .devcontainer/*.sh
chmod +x yolo.sh

# Check Docker group membership
groups | grep docker

# If not in docker group
sudo usermod -aG docker $USER
# Then logout/login
```

---

## Advanced Configuration

### Environment Variables

Set these before running `./yolo.sh`:

```bash
# Use specific Claude Code version
export CLAUDE_CODE_VERSION="1.2.3"
./yolo.sh

# Set timezone
export TZ="America/New_York"
./yolo.sh

# Increase Node memory
export NODE_OPTIONS="--max-old-space-size=8192"
./yolo.sh
```

### Custom Claude Config

The container mounts `~/.claude` from your host, so you can configure Claude normally:

```bash
# On host, edit Claude config
nano ~/.claude/config.json

# Settings apply inside container automatically
```

### Persistent Command History

Container uses a Docker volume for bash history:

```bash
# View volume
docker volume ls | grep claude-code-bashhistory

# Backup history
docker run --rm -v claude-code-bashhistory-xxx:/data -v $PWD:/backup \
  alpine tar czf /backup/history-backup.tar.gz -C /data .

# Restore history
docker run --rm -v claude-code-bashhistory-xxx:/data -v $PWD:/backup \
  alpine tar xzf /backup/history-backup.tar.gz -C /data
```

### Using with VS Code

Instead of running `./yolo.sh`, you can use VS Code Dev Containers:

```bash
# In VS Code
# 1. Open Command Palette (Cmd/Ctrl+Shift+P)
# 2. Run: "Dev Containers: Open Folder in Container"
# 3. Select your project folder
# 4. VS Code will build and open the container

# Inside VS Code integrated terminal, run:
claude --dangerously-skip-permissions
```

### Adding Custom Tools

Edit `.devcontainer/Dockerfile`:

```dockerfile
# Add Python
RUN apt-get update && apt-get install -y python3 python3-pip

# Add Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Add your tools
RUN npm install -g typescript webpack prettier
```

Then rebuild:
```bash
./yolo.sh --build
```

### Multiple Projects

Run different containers for different projects:

```bash
# Project 1
cd ~/project1
./yolo.sh

# Project 2 (in another terminal)
cd ~/project2
./yolo.sh

# Both run isolated from each other
```

---

## FAQ

### Q: Is YOLO mode safe?
**A:** Yes, when run in this containerized setup with network isolation and command blocking. Running `--dangerously-skip-permissions` directly on your host is NOT safe.

### Q: Can Claude still damage my files?
**A:** Only files in the current directory (mounted to `/workspace`). Your home directory, system files, and other projects are isolated. Use git to easily revert unwanted changes.

### Q: Why can't I push to GitHub?
**A:** Safety measure to prevent accidental pushes. Exit the container and push from your host after reviewing changes.

### Q: Can I disable network isolation?
**A:** Not recommended. If you must, comment out the firewall initialization in `yolo.sh` or run with `--no-yolo` and manually approve network commands.

### Q: Does this work on M1/M2 Macs?
**A:** Yes, Docker handles ARM architecture automatically. Node 20 base image supports ARM64.

### Q: Can I use this in CI/CD?
**A:** Not recommended. YOLO mode is for local development. For CI/CD, use normal Claude Code with explicit commands.

### Q: How much disk space does this use?
**A:** Docker image is ~1-2GB. Each container instance shares the image, so running multiple projects doesn't multiply space usage.

### Q: Can Claude install npm packages?
**A:** Yes, `registry.npmjs.org` is whitelisted. Claude can run `npm install`, `yarn add`, etc.

### Q: Can Claude access my .env files?
**A:** Only `.env` files in your project directory. Files outside the mounted workspace are inaccessible.

### Q: What happens when I exit?
**A:** Container is destroyed (`--rm` flag), but your workspace files persist. Next run starts a fresh container.

### Q: Can I run multiple terminals in the same container?
**A:** No, each `./yolo.sh` starts a new container. Use `tmux` or `screen` inside the container for multiple sessions.

---

## See Also

### Documentation
- [Claude Code Official Docs](https://docs.anthropic.com/en/docs/claude-code)
- [Claude Code Sandboxing Guide](https://docs.anthropic.com/en/docs/claude-code/security#sandboxing)
- [Docker Security Best Practices](https://docs.docker.com/engine/security/)

### Similar Projects
- [claucker](https://github.com/dnouri/claucker) - Containerized Claude Code with YOLO mode
- [claude-yolo](https://github.com/eastlondoner/claude-yolo) - YOLO wrapper modifying Claude CLI
- [cco](https://github.com/eastlondoner/cco) - Another sandbox approach

### Articles
- [YOLO Mode: When You're Tired of Claude Asking Permission](https://dev.to/rajeshroyal/yolo-mode-when-youre-tired-of-claude-asking-permission-for-everything-2daf)
- [Sandbox Mode: YOLO Speed Meets Actual Security](https://dev.to/rajeshroyal/sandbox-mode-yolo-speed-meets-actual-security-36m9)
- [Claude Code on Loop: The Ultimate YOLO Mode](https://mfyz.com/claude-code-on-loop-autonomous-ai-coding/)

---

## License

This setup is based on Anthropic's official devcontainer configuration. See individual component licenses:
- Claude Code: Anthropic Terms of Service
- Docker: Apache 2.0
- Scripts: MIT (modify as needed)

---

## Contributing

Improvements welcome! Common additions:
- Additional network whitelist domains
- More command blockers
- Tool installations
- Alternative base images
- Windows/WSL2 support improvements

---

**⚠️ Remember:** YOLO mode is powerful but potentially destructive. Always:
- Use version control (git)
- Review commits before pushing
- Keep backups of important data
- Test in disposable environments first
- Never run on production systems

**Happy coding! 🚀**
