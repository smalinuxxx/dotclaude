# Architecture

**Analysis Date:** 2026-02-02

## Pattern Overview

**Overall:** Multi-agent orchestration system with specialized Claude agent instances coordinating project execution

**Key Characteristics:**
- Parallel agent spawning with dedicated context isolation per focus area
- Workflow-driven orchestration with checkpoints and state management
- Document-based inter-agent communication (minimal context transfer)
- Template-driven planning and execution for consistency
- Hook-based safety layers (git push blocking, command filtering)

## Layers

**Orchestration Layer:**
- Purpose: Route commands to specialized agents, coordinate execution, manage state
- Location: `.claude/commands/gsd/`
- Contains: Command definitions (.md files) that invoke workflows
- Depends on: Workflows, agents, planning state
- Used by: User CLI commands (`/gsd:*`)

**Workflow Layer:**
- Purpose: Define multi-step processes with human checkpoints and decision points
- Location: `.claude/get-shit-done/workflows/`
- Contains: Process definitions with step-by-step execution logic
- Depends on: Agent templates, state management, task spawning
- Used by: Orchestration commands

**Agent Layer:**
- Purpose: Execute specialized work in isolated context (codebase mapper, planner, executor, debugger, etc.)
- Location: `.claude/agents/`
- Contains: Agent system prompts defining role, responsibilities, and behavior
- Depends on: Tools (Read, Write, Bash, Grep, Glob), codebase documents
- Used by: Workflows (via Task tool spawning)

**Planning Document Layer:**
- Purpose: Persistent storage of project decisions, roadmaps, phases, plans
- Location: `.planning/`
- Contains: PROJECT.md (roadmap), MILESTONE.md (scope), PHASE.md (phases), PLAN.md (execution plans), STATE.md (current position)
- Depends on: Codebase analysis documents
- Used by: All agents for context and decision-making

**Codebase Analysis Layer:**
- Purpose: Static reference documents about existing codebase
- Location: `.planning/codebase/`
- Contains: STACK.md, INTEGRATIONS.md, ARCHITECTURE.md, STRUCTURE.md, CONVENTIONS.md, TESTING.md, CONCERNS.md
- Depends on: Source code analysis
- Used by: Planner and executor agents to follow patterns and conventions

**Skills Layer:**
- Purpose: Reusable capabilities encapsulated for agent use
- Location: `.claude/skills/`
- Contains: Skill modules (git, commit)
- Depends on: External tools (git, npm)
- Used by: Agents for specialized operations

**Hook Layer:**
- Purpose: Safety and automation hooks that intercept Claude operations
- Location: `.claude/hooks/`
- Contains: Command blockers (block-git-push.sh), post-task hooks (post-task-commit.sh), status line hooks
- Depends on: Bash, git
- Used by: Settings.json hooks configuration

## Data Flow

**Project Initialization (map-codebase → new-project → roadmap):**

1. User invokes `/gsd:map-codebase` command
2. Orchestrator spawns 4 parallel codebase-mapper agents with different focuses
3. Each mapper analyzes codebase and writes directly to `.planning/codebase/` (tech, arch, quality, concerns)
4. Orchestrator collects confirmations (not document contents) and commits codebase map
5. User proceeds to `/gsd:new-project`
6. Project-researcher agent reads codebase documents and researches domain ecosystem
7. Roadmap-creator agent reads codebase + research and creates PROJECT.md (phases/roadmap)

**Milestone Execution (plan-phase → execute-phase → verify-phase):**

1. User invokes `/gsd:plan-phase` for a specific phase
2. Planner agent reads PROJECT.md, PHASE.md, codebase documents (ARCHITECTURE.md, CONVENTIONS.md)
3. Planner creates PLAN.md with tasks, verification, success criteria
4. User invokes `/gsd:execute-phase`
5. Executor agent reads PLAN.md, STATE.md, codebase documents (STRUCTURE.md, CONVENTIONS.md, TESTING.md)
6. Executor runs tasks sequentially, creates per-task commits, produces SUMMARY.md
7. User invokes `/gsd:verify-phase`
8. Verifier agent runs acceptance tests against SUMMARY.md and success criteria
9. If verification fails, planner enters gap-closure mode to refine plan

**State Management:**

- STATE.md tracks: current phase, current plan, completed tasks, accumulated decisions, blockers
- PHASE.md contains: phase objective, assumptions, scope boundaries
- PLAN.md contains: task breakdown, dependencies, checkpoint information
- SUMMARY.md records: what was executed, deviations discovered, commits created

**State Transitions:**

```
PROJECT.md (Initialized)
  → PHASE.md (Phase selected)
    → PLAN.md (Plan created)
      → (Executor runs tasks)
        → SUMMARY.md (Execution complete)
          → (Verifier validates)
            → STATE.md updated, next phase
```

## Key Abstractions

**Command (.md in .claude/commands/gsd/):**
- Purpose: Maps user intent (e.g., `/gsd:plan-phase`) to workflow execution
- Pattern: Frontmatter with orchestrator metadata, process steps with sub-workflows
- Example: `/gsd:execute-phase` defines how executor agent gets spawned with plan context

**Workflow (.md in .claude/get-shit-done/workflows/):**
- Purpose: Defines multi-step orchestration logic with decision points
- Pattern: Step-based execution with conditions, agent spawning, verification
- Example: `execute-phase.md` orchestrates loading state, spawning executor, handling checkpoints

**Agent (system prompt in .claude/agents/*):**
- Purpose: Defines an AI persona with specific role, tools, and behavior constraints
- Pattern: Role definition, responsibilities, process flow, tool usage rules
- Example: `gsd-executor.md` defines how executor loads plans, executes tasks, commits work

**Plan (PLAN.md in .planning/):**
- Purpose: Executable prompt for implementation - not a document that becomes a prompt
- Pattern: Frontmatter (metadata), objective, context (@-files), tasks, verification, success criteria
- Design principle: Plan IS the prompt, contains everything executor needs

**Template (in .claude/get-shit-done/templates/):**
- Purpose: Reusable document structure for consistent output across agents
- Pattern: Markdown with placeholders, section headers, example content
- Example: `templates/codebase/architecture.md` is the structure template for ARCHITECTURE.md

## Entry Points

**User Commands:**
- Location: `/gsd:*` commands defined in `.claude/commands/gsd/`
- Triggers: User invokes command from CLI (e.g., `/gsd:new-project`)
- Responsibilities: Parse arguments, load project state, invoke workflow

**Session Start Hook:**
- Location: `.claude/hooks/gsd-check-update.js`
- Triggers: Claude session starts
- Responsibilities: Check for framework updates, notify user if out of sync

**Pre-Tool Hook:**
- Location: `.claude/hooks/block-git-push.sh`
- Triggers: Before Bash tool executes any command
- Responsibilities: Block dangerous commands (git push, rm -rf /, sudo)

**Post-Task Hook:**
- Location: `.claude/hooks/post-task-commit.sh`
- Triggers: Agent stops (end of execution)
- Responsibilities: Check for uncommitted changes, offer to commit

## Error Handling

**Strategy:** Layered safety with blocks at entry points and recovery patterns in workflows

**Patterns:**

**Safety Blocks:**
- `.claude/hooks/block-git-push.sh` prevents accidental pushes
- `.claude/hooks/` filter dangerous commands before execution
- Hook configuration in `.claude/settings.json` applies globally

**Execution Error Recovery:**
- Executor follows "auto-fix bugs" rule: automatically handles discovered issues within same task
- Track deviations for Summary documentation
- If blocked by external service, treat as authentication gate and handle in plan

**Verification Failure Recovery:**
- Verifier identifies gaps in completed work
- Planner enters gap-closure mode to refine plan
- New execution plan addresses verified gaps

**Checkpoint Handling:**
- Executor pauses at checkpoint, returns structured message to orchestrator
- Orchestrator handles user interaction (decision, input)
- Fresh executor agent spawned to continue (not resumed)

## Cross-Cutting Concerns

**Logging:** Agent prompts include explicit instruction to track work in SUMMARY.md with commit hashes and deviations

**Validation:** Each step has verification criteria - planner defines must-haves via goal-backward methodology

**Documentation:** State tracked in .planning/ documents; agents write planning documents directly; codebase documents are reference-only (never auto-updated)

**Git Integration:** All agents respect `.planning/config.json` setting `commit_docs` to decide whether to commit planning artifacts; hooks block dangerous operations

**Context Management:** Document-based communication keeps orchestrator context low - agents write directly to disk, return only confirmations

---

*Architecture analysis: 2026-02-02*
