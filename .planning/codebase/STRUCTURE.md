# Codebase Structure

**Analysis Date:** 2026-02-02

## Directory Layout

```
/workspace/
├── .claude/                    # Claude Code configuration and GSD framework
│   ├── agents/                 # Agent system prompts (gsd-*)
│   ├── commands/               # User-facing commands (/gsd:*)
│   ├── get-shit-done/          # Framework core and templates
│   ├── hooks/                  # Pre/post-execution safety and automation
│   ├── skills/                 # Reusable capabilities (git, commit)
│   └── settings.json           # Hook configuration
├── .planning/                  # Project planning artifacts
│   ├── codebase/               # Static analysis docs (STACK.md, ARCHITECTURE.md, etc.)
│   ├── research/               # Research findings (from research phase)
│   └── (project files)         # PROJECT.md, MILESTONES.md, PHASE.md, PLAN.md, STATE.md, SUMMARY.md
├── .devcontainer/              # YOLO Mode Docker setup
├── agents/                     # Documentation about agents (README, custom_subagents)
├── ai-docs/                    # Project-specific AI documentation
├── docs/                       # General documentation
├── plans/                      # Historical plans (archive)
├── specs/                      # Project specifications and contracts
├── tests/                      # Test files
├── YOLO.md                     # YOLO Mode setup guide
├── README.md                   # Project README
├── yolo.sh                     # YOLO Mode launcher script
└── mprocs.yaml                 # Development process manager config
```

## Directory Purposes

**.claude/ - GSD Framework Root:**
- Purpose: Contains entire GSD (Get Shit Done) framework for AI-driven project execution
- Contains: Agents, commands, workflows, templates, hooks, safety configuration
- Key files: `settings.json` (hook configuration)

**.claude/agents/ - Agent Definitions:**
- Purpose: System prompts for specialized Claude agents
- Contains: Agent .md files with role definitions, responsibilities, execution flow
- Key files:
  - `gsd-codebase-mapper.md` - Analyzes codebase, writes STACK.md, ARCHITECTURE.md, etc.
  - `gsd-planner.md` - Creates executable PLAN.md files
  - `gsd-executor.md` - Executes plans, creates commits, produces SUMMARY.md
  - `gsd-verifier.md` - Validates execution against success criteria
  - `gsd-debugger.md` - Investigates failures and produces debugging analysis
  - `gsd-project-researcher.md` - Researches domain before roadmap creation
  - `gsd-roadmapper.md` - Creates PROJECT.md with phase roadmap
  - `gsd-plan-checker.md` - Validates plans for completeness and accuracy
  - `gsd-integration-checker.md` - Verifies external integrations
  - `gsd-research-synthesizer.md` - Synthesizes research into decisions
  - `gsd-phase-researcher.md` - Deep dives on specific phases
  - `git-expert.md` - Handles complex git operations

**.claude/commands/gsd/ - User-Facing Commands:**
- Purpose: Entry points for user commands (e.g., `/gsd:new-project`, `/gsd:plan-phase`)
- Contains: Command definition files with argument hints and execution context
- Key files:
  - `new-project.md` - Initialize project with roadmap
  - `new-milestone.md` - Create milestone within project
  - `map-codebase.md` - Analyze existing codebase
  - `plan-phase.md` - Create execution plan for phase
  - `execute-phase.md` - Run phase executor
  - `verify-phase.md` - Validate phase completion
  - `research-phase.md` - Deep research for phase
  - `complete-milestone.md` - Mark milestone complete
  - `quick.md` - Quick one-off task execution

**.claude/get-shit-done/ - Framework Core:**
- Purpose: Templates, workflows, references, VERSION tracking
- Contains:
  - `templates/` - Document structure templates
  - `workflows/` - Multi-step orchestration workflows
  - `references/` - Reference documentation
  - `VERSION` - Framework version

**.claude/get-shit-done/templates/ - Document Templates:**
- Purpose: Reusable .md templates for consistent output
- Key files:
  - `codebase/` - STACK.md, ARCHITECTURE.md, STRUCTURE.md, CONVENTIONS.md, TESTING.md, INTEGRATIONS.md, CONCERNS.md
  - `project.md` - PROJECT.md template
  - `roadmap.md` - Roadmap template
  - `milestone.md` - Milestone template
  - `phase-prompt.md` - Phase definition template
  - `research.md` - Research findings template
  - `summary.md` - Execution summary template

**.claude/get-shit-done/workflows/ - Orchestration Workflows:**
- Purpose: Define multi-step processes that coordinate agents
- Contains: Step-by-step execution flows with conditional logic
- Key files:
  - `map-codebase.md` - Spawn parallel codebase mapper agents
  - `new-project.md` - Initialize project (research → roadmap creation)
  - `plan-phase.md` - Plan creation workflow
  - `execute-phase.md` - Execution orchestration
  - `verify-phase.md` - Verification workflow
  - `verify-work.md` - Validation after execution
  - `complete-milestone.md` - Milestone completion workflow

**.claude/hooks/ - Safety and Automation:**
- Purpose: Intercept and filter operations at execution time
- Contains: Bash scripts that run before/after agent operations
- Key files:
  - `block-git-push.sh` - Prevent accidental pushes to remote
  - `post-task-commit.sh` - Auto-commit after task completion
  - `gsd-check-update.js` - Check framework version on session start
  - `gsd-statusline.js` - Display status in Claude status bar

**.claude/skills/ - Reusable Capabilities:**
- Purpose: Encapsulated implementations of complex operations
- Contains: Skill modules (git/, commit/)
- Used by: Agents for specialized tasks

**.planning/ - Project Planning State:**
- Purpose: Persistent storage of project decisions and execution state
- Contains:
  - `.planning/codebase/` - Static codebase analysis documents
  - `.planning/research/` - Research findings (generated during research phase)
  - Project document files: PROJECT.md, MILESTONE.md, PHASE.md, PLAN.md, STATE.md, SUMMARY.md, CONTEXT.md
- Important: Planning docs may or may not be committed based on `.planning/config.json` setting

**.planning/codebase/ - Codebase Analysis Documents:**
- Purpose: Reference documents about existing codebase (not auto-updated)
- Contains: 7 markdown documents from codebase-mapper agents:
  - `STACK.md` - Technologies, frameworks, dependencies
  - `INTEGRATIONS.md` - External services, APIs, databases
  - `ARCHITECTURE.md` - System patterns, layers, data flow
  - `STRUCTURE.md` - Directory layout, file organization
  - `CONVENTIONS.md` - Code style, naming, patterns
  - `TESTING.md` - Testing framework and patterns
  - `CONCERNS.md` - Technical debt, known issues, fragile areas
- Read-only reference for agents (never auto-updated)

**.devcontainer/ - YOLO Mode Docker:**
- Purpose: Container setup for sandboxed autonomous execution
- Contains: Dockerfile, devcontainer.json, firewall and blocking scripts

**agents/ - Documentation:**
- Purpose: User-facing documentation about available agents
- Contains: README.md with agent descriptions, custom_subagents.md

**specs/ - Project Specifications:**
- Purpose: Requirements and contracts for project phases
- Contains: Per-project spec folders with checklists and contracts

**tests/ - Test Files:**
- Purpose: Test suite for codebase
- Contains: Test files organized by subsystem

## Key File Locations

**Entry Points:**
- `.claude/commands/gsd/` - All user-facing command definitions start here
- `.claude/agents/` - System prompts that define agent behavior
- `.claude/get-shit-done/workflows/` - Orchestration logic that chains commands and agents

**Configuration:**
- `.claude/settings.json` - Hook configuration and feature flags
- `.planning/config.json` - Project-level settings (model profile, commit behavior)
- `.devcontainer/Dockerfile` - Container setup

**Core Planning Logic:**
- `.claude/get-shit-done/templates/` - All document templates
- `.claude/get-shit-done/workflows/` - Multi-step process definitions

**Project Planning Documents:**
- `.planning/PROJECT.md` - Roadmap (phases and sequencing)
- `.planning/MILESTONE.md` - Current milestone scope
- `.planning/PHASE.md` - Current phase definition
- `.planning/PLAN.md` - Executable task breakdown
- `.planning/STATE.md` - Current execution position and decisions
- `.planning/SUMMARY.md` - What was executed and results

**Codebase Reference:**
- `.planning/codebase/STACK.md` - Technology decisions
- `.planning/codebase/ARCHITECTURE.md` - System design
- `.planning/codebase/STRUCTURE.md` - File organization
- `.planning/codebase/CONVENTIONS.md` - Code patterns
- `.planning/codebase/TESTING.md` - Test patterns

## Naming Conventions

**Command Files (.claude/commands/gsd/):**
- Pattern: `kebab-case.md` matching command name (e.g., `new-project.md` for `/gsd:new-project`)
- Purpose: Clear mapping between user command and definition

**Agent Files (.claude/agents/):**
- Pattern: `gsd-{role-name}.md` (e.g., `gsd-planner.md`, `gsd-executor.md`)
- Prefix `gsd-` identifies framework agents vs. other agents (git-expert, code-improver)

**Workflow Files (.claude/get-shit-done/workflows/):**
- Pattern: `{verb}-{noun}.md` (e.g., `execute-phase.md`, `verify-work.md`)
- Purpose: Clear action-oriented names

**Planning Documents (.planning/):**
- Pattern: UPPERCASE.md (PROJECT.md, PLAN.md, STATE.md, SUMMARY.md)
- Purpose: Persistent project state

**Template Files (.claude/get-shit-done/templates/):**
- Pattern: Filename matches output document (e.g., `codebase/architecture.md` is template for ARCHITECTURE.md)

**Hook Files (.claude/hooks/):**
- Pattern: `{verb}-{noun}.sh` or `{tool}-{purpose}.js` (e.g., `block-git-push.sh`, `gsd-statusline.js`)
- Purpose: Clear indication of what the hook does

## Where to Add New Code

**Extending the GSD Framework:**
- New agent: Create `.claude/agents/gsd-{role}.md` with system prompt and process definition
- New command: Create `.claude/commands/gsd/{command-name}.md` with execution context
- New workflow: Create `.claude/get-shit-done/workflows/{verb}-{noun}.md` with step definitions
- New template: Create `.claude/get-shit-done/templates/{category}/{name}.md` with structure

**For Project-Specific Code:**
- Project documentation: Write to `.planning/` (PROJECT.md, PHASE.md, etc.)
- Research findings: Write to `.planning/research/` (created by researcher agent)
- Planning state: Write to `.planning/` (STATE.md, SUMMARY.md)

**For Codebase Reference (Analysis Only):**
- Codebase documents: Always write to `.planning/codebase/` from codebase-mapper agents
- Never auto-update codebase documents - they are analysis snapshots, not generated code
- Refresh via `/gsd:map-codebase` when codebase significantly changes

## Special Directories

**.planning/ - Planning Artifacts:**
- Purpose: Project state and planning documents
- Generated: Yes (by orchestrator and agents)
- Committed: Configurable via `.planning/config.json` (default: true)
- Lifetime: Persistent across sessions; contains accumulated project decisions

**.claude/ - Framework Configuration:**
- Purpose: GSD framework installation and configuration
- Generated: No (manual setup/updates)
- Committed: Yes (version controlled with framework)
- Lifetime: Persistent; updated when framework is upgraded

**.planning/codebase/ - Codebase Analysis (Read-Only Reference):**
- Purpose: Static analysis of existing codebase
- Generated: Yes (by codebase-mapper agents via `/gsd:map-codebase`)
- Committed: Yes (snapshot of codebase understanding)
- Lifetime: Valid until significant codebase changes; refresh via `/gsd:map-codebase`
- Important: These are analysis documents, never auto-updated from source code

**.planning/research/ - Domain Research:**
- Purpose: Research findings before roadmap creation
- Generated: Yes (by project-researcher agent)
- Committed: Yes (decision rationale)
- Lifetime: Valid for duration of project
- Used by: Roadmap creator to inform phase structure

**.devcontainer/ - YOLO Mode Docker:**
- Purpose: Container and sandbox configuration
- Generated: No (manual setup)
- Committed: Yes (reproducible environment)
- Lifetime: Persistent; may be updated for security patches

---

*Structure analysis: 2026-02-02*
