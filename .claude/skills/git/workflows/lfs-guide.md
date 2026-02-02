# Git Large File Storage (LFS) Guide

Guide for managing large files in Git repositories using Git LFS.

## What is Git LFS?

Git LFS (Large File Storage) is an extension that replaces large files with text pointers in Git, while storing the file contents on a remote server.

**Use Git LFS for:**
- Binary assets (images, videos, audio)
- Large datasets
- Compiled binaries
- Archives
- Machine learning models

**Typical threshold:** Files larger than 1-5 MB

## Installation

### macOS
```bash
brew install git-lfs
git lfs install
```

### Ubuntu/Debian
```bash
sudo apt-get install git-lfs
git lfs install
```

### Windows
Download from https://git-lfs.github.com or:
```powershell
choco install git-lfs
git lfs install
```

### Verify Installation
```bash
git lfs version
```

## Setting Up LFS in a Repository

### New Repository

```bash
# Initialize LFS
git lfs install

# Track file types
git lfs track "*.psd"
git lfs track "*.pdf"
git lfs track "*.mp4"
git lfs track "*.zip"

# The above creates/updates .gitattributes
git add .gitattributes
git commit -m "Configure Git LFS tracking"
```

### Existing Repository

```bash
# Install LFS
git lfs install

# Track large files
git lfs track "*.png"
git lfs track "*.jpg"
git lfs track "*.bin"

# Migrate existing files to LFS
git lfs migrate import --include="*.png,*.jpg,*.bin"

# Commit changes
git add .gitattributes
git commit -m "Migrate large files to LFS"
```

## Tracking Files

### By Extension
```bash
git lfs track "*.psd"
git lfs track "*.ai"
```

### By Path
```bash
git lfs track "assets/**/*.png"
git lfs track "data/*.csv"
```

### By Specific File
```bash
git lfs track "large-dataset.db"
```

### View Tracked Patterns
```bash
git lfs track
```

### Untrack Pattern
```bash
git lfs untrack "*.txt"
```

## Working with LFS Files

### Adding LFS Files

```bash
# Files matching tracked patterns are automatically handled
git add large-file.psd
git commit -m "Add design file"
git push
```

### Checking LFS Status

```bash
# See LFS files
git lfs ls-files

# See LFS status
git lfs status

# See pointer file vs actual size
git lfs ls-files -s
```

### Fetching LFS Files

```bash
# Fetch all LFS files for current checkout
git lfs fetch

# Fetch for specific remote and ref
git lfs fetch origin main

# Fetch everything
git lfs fetch --all
```

### Pulling LFS Files

```bash
# Pull with LFS files
git pull

# Or separately
git pull
git lfs pull
```

## Migrating Existing Files

### Import Files to LFS

```bash
# Migrate specific extensions
git lfs migrate import --include="*.zip,*.tar.gz"

# Migrate specific directory
git lfs migrate import --include="media/**"

# See what would be migrated (dry run)
git lfs migrate info --above=1MB
```

### Export Files from LFS

```bash
# Convert LFS files back to regular Git
git lfs migrate export --include="*.txt"
```

## Advanced Operations

### Prune Old LFS Files

```bash
# Remove LFS files not referenced by current checkout
git lfs prune

# Prune and verify
git lfs prune --verify-remote

# Dry run to see what would be deleted
git lfs prune --dry-run
```

### Clone with LFS

```bash
# Clone with all LFS files
git clone <repo-url>

# Clone without LFS files (just pointers)
git clone --no-checkout <repo-url>
cd repo
git lfs install --skip-smudge
git checkout main

# Fetch specific LFS files later
git lfs pull --include="path/to/needed/files"
```

### Sparse Checkout with LFS

Only download LFS files you need:

```bash
# Disable automatic LFS download
git lfs install --skip-smudge

# Clone repository
git clone <repo-url>

# Fetch only specific files
git lfs fetch --include="important/*.png"
git lfs checkout important/*.png
```

## .gitattributes Configuration

Example `.gitattributes` for LFS:

```
# Images
*.png filter=lfs diff=lfs merge=lfs -text
*.jpg filter=lfs diff=lfs merge=lfs -text
*.jpeg filter=lfs diff=lfs merge=lfs -text
*.gif filter=lfs diff=lfs merge=lfs -text
*.psd filter=lfs diff=lfs merge=lfs -text
*.ai filter=lfs diff=lfs merge=lfs -text
*.svg filter=lfs diff=lfs merge=lfs -text

# Video
*.mp4 filter=lfs diff=lfs merge=lfs -text
*.mov filter=lfs diff=lfs merge=lfs -text
*.avi filter=lfs diff=lfs merge=lfs -text

# Audio
*.mp3 filter=lfs diff=lfs merge=lfs -text
*.wav filter=lfs diff=lfs merge=lfs -text

# Archives
*.zip filter=lfs diff=lfs merge=lfs -text
*.tar.gz filter=lfs diff=lfs merge=lfs -text
*.rar filter=lfs diff=lfs merge=lfs -text

# Documents
*.pdf filter=lfs diff=lfs merge=lfs -text

# Data
*.csv filter=lfs diff=lfs merge=lfs -text
*.db filter=lfs diff=lfs merge=lfs -text
*.sqlite filter=lfs diff=lfs merge=lfs -text

# Binaries
*.exe filter=lfs diff=lfs merge=lfs -text
*.dll filter=lfs diff=lfs merge=lfs -text
*.so filter=lfs diff=lfs merge=lfs -text
*.dylib filter=lfs diff=lfs merge=lfs -text

# Machine Learning
*.h5 filter=lfs diff=lfs merge=lfs -text
*.pkl filter=lfs diff=lfs merge=lfs -text
*.model filter=lfs diff=lfs merge=lfs -text
```

## Bandwidth and Storage

### Check Storage Usage

```bash
# GitHub example
gh api /repos/:owner/:repo/git/lfs
```

### Reduce Bandwidth

```bash
# Only fetch files for current branch
git config lfs.fetchrecentalways false
git config lfs.fetchrecentrefsdays 0

# Fetch on demand
git lfs install --skip-smudge
```

## Troubleshooting

### Large Files Rejected

**Error:** "File exceeds GitHub's 100 MB limit"

**Solution:**
```bash
# Track with LFS before committing
git lfs track "large-file.bin"
git add .gitattributes
git add large-file.bin
git commit -m "Add large file with LFS"
```

### Files Not Tracked

**Problem:** Files committed as regular Git objects

**Solution:**
```bash
# Remove from Git history
git rm --cached large-file.zip

# Track with LFS
git lfs track "*.zip"

# Re-add
git add .gitattributes large-file.zip
git commit -m "Move to LFS"
```

### Pointer Files Instead of Content

**Problem:** File shows text like "version https://git-lfs.github.com/spec/v1"

**Solution:**
```bash
# Pull LFS content
git lfs pull

# Or checkout specific files
git lfs checkout path/to/file
```

### Slow Clone/Pull

**Problem:** Downloading many large LFS files

**Solutions:**
```bash
# Option 1: Shallow clone
git clone --depth 1 <repo-url>

# Option 2: Skip LFS, fetch later
GIT_LFS_SKIP_SMUDGE=1 git clone <repo-url>

# Option 3: Use sparse checkout
git lfs install --skip-smudge
git sparse-checkout set path/to/needed/files
git lfs pull --include="path/to/needed/files"
```

### Out of Storage Quota

**Solutions:**
1. Prune old files: `git lfs prune`
2. Remove unnecessary files from LFS
3. Use `.lfsconfig` to exclude patterns
4. Upgrade storage plan (GitHub, GitLab, etc.)

### Corrupted LFS Objects

```bash
# Verify LFS objects
git lfs fsck

# Re-download corrupted objects
git lfs fetch --all
git lfs checkout
```

## LFS with Different Hosts

### GitHub

- Free tier: 1 GB storage, 1 GB/month bandwidth
- Paid: 50 GB storage, 50 GB/month bandwidth
- Additional: $5/month per 50 GB pack

### GitLab

- Free tier: 10 GB storage
- Paid: More storage available

### Bitbucket

- Includes 1 GB LFS storage
- Additional storage available

### Self-hosted

Configure custom LFS server:
```bash
git config lfs.url https://lfs.example.com
```

## Best Practices

1. **Track patterns, not individual files**
   ```bash
   git lfs track "*.psd"  # Good
   git lfs track "file.psd"  # Less flexible
   ```

2. **Commit .gitattributes first**
   ```bash
   git lfs track "*.bin"
   git add .gitattributes
   git commit -m "Configure LFS"
   # Then add the large files
   ```

3. **Don't mix LFS and regular for same type**
   - Track all `.png` or none, not some

4. **Use meaningful commit messages**
   ```bash
   git commit -m "Add product photos (LFS)"
   ```

5. **Regular pruning**
   ```bash
   git lfs prune  # Monthly or after major changes
   ```

6. **Document LFS usage**
   - Add note in README about LFS requirement
   - List tracked extensions
   - Provide clone instructions

7. **Size threshold**
   - Generally track files > 1 MB
   - Adjust based on team bandwidth and storage

## Migration Checklist

Migrating existing repository to LFS:

- [ ] Install Git LFS locally
- [ ] Identify large files: `git lfs migrate info --above=1MB`
- [ ] Back up repository
- [ ] Configure tracking: `git lfs track "*.ext"`
- [ ] Migrate files: `git lfs migrate import --include="*.ext"`
- [ ] Test clone in new directory
- [ ] Verify file sizes: `git lfs ls-files -s`
- [ ] Force push if needed: `git push --force-with-lease`
- [ ] Notify team to re-clone or run `git lfs pull`
- [ ] Update documentation

## LFS Configuration Reference

### Local Config (.git/config)

```ini
[lfs]
    repositoryformatversion = 0
    fetchrecentalways = false
    fetchrecentrefsdays = 7
    fetchrecentremoterefs = true
    concurrenttransfers = 8
    activitytimeout = 30
    dialtimeout = 30
    keepalive = 30
```

### Global Config (~/.gitconfig)

```ini
[filter "lfs"]
    clean = git-lfs clean -- %f
    smudge = git-lfs smudge -- %f
    process = git-lfs filter-process
    required = true
```

## Scripts and Automation

### Find Large Files

```bash
#!/bin/bash
# find-large-files.sh - Find files over 1MB
find . -type f -size +1M -not -path "./.git/*" | while read file; do
    size=$(du -h "$file" | cut -f1)
    echo "$size $file"
done | sort -h
```

### Batch Track Files

```bash
#!/bin/bash
# track-large-files.sh - Auto-track files over threshold
THRESHOLD_MB=1
find . -type f -size +${THRESHOLD_MB}M -not -path "./.git/*" | while read file; do
    ext="${file##*.}"
    git lfs track "*.${ext}"
done
git add .gitattributes
```

## Further Reading

- Official docs: https://git-lfs.github.com
- GitHub LFS: https://docs.github.com/en/repositories/working-with-files/managing-large-files
- GitLab LFS: https://docs.gitlab.com/ee/topics/git/lfs/
- Atlassian LFS guide: https://www.atlassian.com/git/tutorials/git-lfs
