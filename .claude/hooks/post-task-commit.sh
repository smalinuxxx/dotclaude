#!/bin/bash
# Post-task auto-commit hook
# Automatically offers to commit changes when Claude Code finishes all tasks

# Only run if there are changes
if ! git diff --quiet || ! git diff --cached --quiet || [ -n "$(git ls-files --others --exclude-standard)" ]; then
    # Check if we're not in the middle of a merge/rebase
    if [ ! -f .git/MERGE_HEAD ] && [ ! -d .git/rebase-merge ] && [ ! -d .git/rebase-apply ]; then
        # Signal to Claude that there are uncommitted changes
        echo "📝 Uncommitted changes detected. Would you like to commit them?"

        # Return exit code 0 to allow the operation (non-blocking)
        # The message above will be shown to the user
        exit 0
    fi
fi

# No changes or in middle of operation - silent pass
exit 0
