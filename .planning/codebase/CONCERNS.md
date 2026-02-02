# Codebase Concerns

**Analysis Date:** 2026-02-02

## Tech Debt

**Agent Documentation Size and Complexity:**
- Issue: Multiple agents exceed 1000+ lines of documentation (gsd-planner.md: 1386 lines, gsd-debugger.md: 1203 lines, gsd-executor.md: 784 lines), creating maintenance burden and reduced discoverability
- Files: `.claude/agents/gsd-planner.md`, `.claude/agents/gsd-debugger.md`, `.claude/agents/gsd-executor.md`, `.claude/agents/gsd-project-researcher.md`
- Impact: Difficult for future agents to locate specific guidance; harder to maintain consistency across agent instructions; increased onboarding time for understanding system behavior
- Fix approach: Modularize agent documentation by extracting common patterns into reusable reference documents (e.g., extract "task design patterns" to shared reference), move detailed examples to separate workflow files, consolidate redundant sections across agents

**Context Window Pressure Management:**
- Issue: Planner relies on heuristic "50% context target" for plan scope (`.claude/agents/gsd-planner.md` lines 49-62), but no automated enforcement or measurement of actual context usage
- Files: `.claude/agents/gsd-planner.md`, `.claude/agents/gsd-executor.md`
- Impact: Plans may silently exceed capacity and trigger Claude completion mode, degrading quality; no visibility into whether 50% guideline is actually being followed
- Fix approach: Implement automated context estimation during plan generation (count tokens in context files, frontmatter, and task descriptions), add warning when approaching 40% usage, provide metrics in plan frontmatter

**Unfinished Agent Skill System:**
- Issue: Git expert agent declares 10 planned skills (`.claude/agents/README.md` lines 98-107), but only 2 are implemented (commit and git skills in `.claude/skills/`)
- Files: `.claude/agents/README.md`, `.claude/agents/git-expert.md`, `.claude/skills/commit/SKILL.md`, `.claude/skills/git/SKILL.md`
- Impact: Documentation overpromises on capabilities; future maintainers may assume skills exist and reference them in workflows; user expectations set incorrectly
- Fix approach: Either implement remaining 8 skills or remove them from roadmap; if keeping as TODOs, move to separate ROADMAP.md with explicit "not yet implemented" status

**Dependency on External Execution Context:**
- Issue: Multiple agents (planner, executor, verifier) assume external orchestrators provide `.planning/STATE.md` and execution context, but error handling for missing files is minimal
- Files: `.claude/agents/gsd-executor.md` lines 32-41, `.claude/agents/gsd-planner.md` lines 997-1020
- Impact: If orchestrator fails to initialize state, agents may silently use incorrect context or fail mid-execution; poor error messages for debugging
- Fix approach: Add comprehensive validation step at agent start that checks for required files and provides actionable error messages with recovery paths

## Known Bugs

**Git Push Blocking Hook Overly Restrictive:**
- Symptoms: `git push` is blocked unconditionally via `.claude/hooks/block-git-push.sh`, but workflow occasionally needs legitimate pushes for shared branches
- Files: `.claude/hooks/block-git-push.sh`, `.claude/settings.json`
- Trigger: Any attempt to run `git push` command
- Workaround: Temporarily disable hook by removing from `.claude/settings.json` hooks list, or use manual git push outside Claude context
- Issue: Hook uses simple regex match on `^git push` without considering force flags or branch safety checks; blocks even safe operations

**Post-Task Commit Hook Signal Missing:**
- Symptoms: Auto-commit hook (`post-task-commit.sh` lines 6-14) checks for uncommitted changes but relies on user response; if user doesn't respond or context resets, changes may be lost without clear indication
- Files: `.claude/hooks/post-task-commit.sh`
- Trigger: When Claude finishes tasks and hook fires (Stop event)
- Workaround: Manually check `git status` and commit if needed
- Issue: Hook output is non-binding; changes could accumulate across sessions without being committed

## Security Considerations

**YOLO Mode with Dangerously-Skip-Permissions:**
- Risk: Running `claude --dangerously-skip-permissions` in Docker container bypasses all CLI confirmation prompts; even with sandbox, risk of unintended destructive commands if agent behaves unexpectedly
- Files: `/workspace/yolo.sh` lines 147-150, `/workspace/YOLO.md` section "The Danger"
- Current mitigation: Docker container isolation, network firewall (iptables), read-only git config mount, non-root user execution
- Recommendations: Add audit logging of all executed commands within container, implement command whitelist instead of blacklist-only approach, add confirmation checkpoint for high-risk operations (git reset, rm -rf, etc.)

**Secrets Exposure in YOLO Mode:**
- Risk: While YOLO documentation warns about `.env` file leaks, the block-git-push.sh and post-task-commit.sh hooks don't prevent accidental commits of secret files
- Files: `/workspace/.claude/hooks/block-git-push.sh`, `/workspace/.claude/hooks/post-task-commit.sh`, `/workspace/YOLO.md` line 58
- Current mitigation: `.gitignore` file exists but hook doesn't validate against it
- Recommendations: Pre-commit hook should check for common secret patterns (API_KEY=, PASSWORD=, TOKEN=) before allowing commit, add support for `.gitignore` validation

**Hook Script Input Validation:**
- Risk: `gsd-check-update.js` spawns background process with dynamically interpolated file paths and cache directory creation without validation
- Files: `.claude/hooks/gsd-check-update.js` lines 29-31, 12-22
- Current mitigation: Path construction uses `path.join()` which normalizes paths
- Recommendations: Add explicit validation that resolved paths are within expected directories (no path traversal), sanitize cache directory creation to prevent symlink attacks

## Performance Bottlenecks

**Update Check Network Call on Every Session:**
- Problem: `gsd-check-update.js` spawns background npm process checking `npm view get-shit-done-cc version` every Claude session start
- Files: `.claude/hooks/gsd-check-update.js` lines 44-46
- Cause: Runs on each session without cache validity check; can add 5-15 seconds latency if npm registry is slow
- Improvement path: Implement proper cache expiration (check only once per day), make timeout more aggressive (currently 10 seconds), consider making check opt-in rather than default

**Large Agent Documentation Slows Discovery:**
- Problem: Agent files range from 256 to 1386 lines; searching for specific guidance requires scanning massive documents
- Files: `.claude/agents/gsd-planner.md`, `.claude/agents/gsd-debugger.md`, etc.
- Cause: Each agent bundles role, philosophy, process, examples, and troubleshooting in single file
- Improvement path: Split into modular files (agent-name-ROLE.md, agent-name-PROCESS.md, agent-name-EXAMPLES.md), maintain index file for cross-references

**Context Window Calculation Missing:**
- Problem: No automated measurement of actual context usage; planner relies on manual estimation
- Files: `.claude/agents/gsd-planner.md` lines 49-62
- Cause: Claude API doesn't expose real-time token counting during execution
- Improvement path: Implement pre-execution estimation script that reads all context files and estimates tokens, add token budget tracking to PLAN.md frontmatter

## Fragile Areas

**Phase Planning Dependency on Accurate Frontmatter:**
- Files: `.claude/agents/gsd-planner.md` (lines 800-900), `.planning/phases/` structure
- Why fragile: Task execution order depends on `depends_on` array in frontmatter; if dependency graph is incorrect or missing tasks in ordering, execution will fail silently with out-of-order task completion
- Safe modification: Always validate dependency graph visually (topological sort test) before executing plans; add explicit verification step in planner that lists all tasks in execution order
- Test coverage: No automated tests validating dependency graph correctness; manual verification only

**State.md as Single Point of Truth:**
- Files: `.planning/STATE.md`
- Why fragile: All agents read from this single file to understand project position; if corrupted or outdated, all downstream operations become unreliable
- Safe modification: Add checksums/versioning to STATE.md, implement state validation step at start of each agent, maintain backup of previous STATE versions
- Test coverage: No automated validation that STATE.md matches actual execution progress

**Agent Checkpoint Protocol Without Explicit Acknowledgment:**
- Files: `.claude/agents/gsd-executor.md` (lines 83-100), `.claude/agents/gsd-debugger.md` (lines 500+)
- Why fragile: When agents return CHECKPOINT messages to orchestrator, there's no guaranteed acknowledgment that orchestrator received them; if message is lost, agent won't resume properly
- Safe modification: Add explicit checkpoint tracking in STATE.md with timestamps, implement checkpoint acknowledgment requirement before resuming
- Test coverage: No tests for checkpoint lifecycle

## Scaling Limits

**Docker Image Rebuild on Each Session:**
- Current capacity: Image built once, reused; but version changes require rebuild
- Limit: If CLAUDE_CODE_VERSION changes, entire image rebuilds; time scales with dependencies
- Scaling path: Implement layer caching better (separate Claude code version layer from base), use Docker compose for faster rebuilds, add image versioning to track changes

**Hook Processing Synchronous Blocking:**
- Current capacity: Each hook (block-git-push, post-task-commit) runs synchronously in tool execution path
- Limit: If hook contains network call or slow operation, it blocks Claude's next action
- Scaling path: Make hooks fully asynchronous (fire-and-forget for non-blocking hooks), add timeout to prevent hanging

**Planning Document Accumulation:**
- Current capacity: Plans generated per phase; no cleanup of old/obsolete plans
- Limit: Over many phases, `.planning/phases/` directory grows; searching becomes slow
- Scaling path: Implement archived phases directory, add plan cleanup script that archives completed phases, implement symbolic link system for current working phase

## Dependencies at Risk

**NPM Package: get-shit-done-cc**
- Risk: Framework depends on published npm package for updates; if package namespace changes or maintainer abandons it, updates break
- Impact: Update checking fails silently (already mitigated by try/catch), newer versions not discovered
- Migration plan: If package deprecated, implement local version source control in monorepo instead of npm, or fork package

**Docker Base Image Stability:**
- Risk: `.devcontainer/Dockerfile` uses upstream image without pinned version; image changes could break container
- Impact: YOLO mode container might fail to build if upstream has breaking changes
- Migration plan: Pin specific image digest instead of tag, implement image build caching

**Node.js Version in Hook Scripts:**
- Risk: Hook scripts assume Node.js availability; version mismatches could cause execution errors
- Impact: Hooks fail silently if Node version incompatible with script syntax
- Migration plan: Add explicit Node version check in hooks, provide fallback shell implementations

## Missing Critical Features

**No Automated Testing of Agents:**
- Problem: No test suite validating agent behavior; agents are modified but never verified to work end-to-end
- Blocks: Can't safely refactor agents; can't catch regressions when changing orchestrator behavior
- Recommendation: Create agent test harness that validates core workflows (plan creation, execution, verification) with mock orchestrator

**No Rollback Mechanism for Failed Phases:**
- Problem: If phase execution fails, no built-in way to revert to previous working state
- Blocks: Users stuck in broken states, must manually fix .planning/STATE.md
- Recommendation: Implement phase rollback command that reverts STATE.md to previous checkpoint and suggests recovery steps

**No Conflict Detection Between Concurrent Agent Operations:**
- Problem: If two agents modify .planning/ files simultaneously, conflicts possible but not detected
- Blocks: Multi-agent workflows (e.g., debugging while planning) not safe
- Recommendation: Add file locking or version checking before writes, implement conflict resolution in orchestrator

**Missing Agent Communication Protocol:**
- Problem: Agents don't coordinate with each other; no way for one agent to signal blockers to another
- Blocks: Parallel phase execution not possible; dependency tracking limited to task level
- Recommendation: Implement agent-to-agent signaling via .planning/signals/ directory with structured message format

## Test Coverage Gaps

**Phase Verification Logic Untested:**
- What's not tested: Goal-backward verification method used by verifier agent (`.claude/agents/gsd-verifier.md` lines 400-500)
- Files: `.claude/agents/gsd-verifier.md`
- Risk: Verification logic may have edge cases (e.g., circular dependencies, orphaned requirements) that aren't caught
- Priority: High - verification determines if phases pass or fail

**Hook Execution Under Error Conditions:**
- What's not tested: Behavior of hooks when commands fail, when files are missing, when jq parsing fails
- Files: `.claude/hooks/block-git-push.sh`, `.claude/hooks/post-task-commit.sh`
- Risk: Hooks could silently fail without informing user or agent
- Priority: Medium - affects safety and user experience

**YOLO Mode Network Firewall Rules:**
- What's not tested: Whether firewall rules actually block/allow intended traffic; if rules are too permissive or too restrictive
- Files: `/workspace/yolo.sh` (lines 125-136 test commands), `/workspace/YOLO.md` (security section)
- Risk: Network isolation might not work as advertised; undiscovered backdoors possible
- Priority: High - security-critical

**Dependency Graph Cycle Detection:**
- What's not tested: Whether planner correctly detects circular task dependencies
- Files: `.claude/agents/gsd-planner.md` (dependency graph section)
- Risk: Circular dependencies could cause infinite loops or deadlocks
- Priority: High - execution blocker

---

*Concerns audit: 2026-02-02*
