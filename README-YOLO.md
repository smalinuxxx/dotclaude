# YOLO Mode Quick Reference

**TL;DR:** Run Claude Code autonomously in a secure sandbox.

```bash
./yolo.sh "fix all the bugs"
```

## What You Get

- ✅ Claude runs without asking permission every time
- ✅ Network isolated (only GitHub, npm, Anthropic API)
- ✅ Git push blocked (prevents accidents)
- ✅ Filesystem isolated (can't touch your home dir)
- ✅ Runs in disposable Docker container

## Quick Commands

```bash
./yolo.sh                    # Start YOLO mode
./yolo.sh "your task here"   # Run with specific task
./yolo.sh --shell            # Debug shell
./yolo.sh --build            # Rebuild image
```

## Files Overview

| File | What It Does |
|------|--------------|
| `yolo.sh` | Main script - builds & runs container |
| `.devcontainer/Dockerfile` | Container image definition |
| `.devcontainer/init-firewall.sh` | Blocks network except whitelist |
| `.devcontainer/block-dangerous.sh` | Blocks git push, rm -rf /, etc |
| `YOLO.md` | Full documentation (read this!) |

## Safety Features

| Feature | How |
|---------|-----|
| No `git push` | Wrapper script blocks it |
| No internet | iptables firewall |
| No system damage | Docker isolation |
| No secret leaks | Only workspace mounted |

## First Time Setup

```bash
# 1. Make executable
chmod +x yolo.sh
chmod +x .devcontainer/*.sh

# 2. Run (builds image automatically)
./yolo.sh

# 3. Wait ~2-3 minutes for image build

# 4. Claude starts in YOLO mode
```

## When Things Go Wrong

```bash
# Container won't start?
./yolo.sh --build

# Need to push commits?
exit                        # Exit container
git push origin main        # Push from host

# Want to test firewall?
./yolo.sh --shell
curl https://example.com    # Should fail
curl https://api.github.com # Should work
```

## Read More

- `YOLO.md` - Comprehensive documentation
- [Claude Code Docs](https://docs.anthropic.com/en/docs/claude-code)
- [Anthropic's Devcontainer](https://github.com/anthropics/claude-code/tree/main/.devcontainer)

---

**⚠️ Warning:** Never run `--dangerously-skip-permissions` on your host. Always use this sandboxed setup.
