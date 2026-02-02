#!/bin/bash
# .claude/hooks/block-git-push.sh

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command')

if echo "$COMMAND" | grep -qE '^git push'; then
  jq -n '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: "git push is blocked by project policy. Please push manually from your terminal."
    }
  }'
  exit 0
fi

exit 0
