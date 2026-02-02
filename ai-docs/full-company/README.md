# dotclaude - Software Engineering Excellence

> Comprehensive workflows, roadmaps, and Claude Code configurations for building world-class software

## Overview

This repository contains battle-tested software development workflows, 30-year hiring roadmaps, and Claude Code configurations for teams working on low-level systems (Linux kernel, eBPF, Barebox), web applications (Django), AI/ML, and security-critical software.

## Contents

### Core Documents

- **[WORKFLOW.md](WORKFLOW.md)** - Complete SDLC guide covering all 17 phases from planning to continuous improvement
- **[ROADMAP.md](ROADMAP.md)** - 30-year strategic hiring and scaling roadmap from startup to industry leader
- **[CLAUDE.md](CLAUDE.md)** - Project-specific instructions for Claude Code

### Configuration

- **agents/** - Custom Claude Code subagents for specialized tasks
- **skills/** - Reusable skills and workflows
- **hooks/** - Lifecycle event handlers and validation scripts
- **plans/** - Project planning documents

### Reference

- **[custom_subagents.md](custom_subagents.md)** - Comprehensive subagent creation guide
- **[WORKFLOW.md](WORKFLOW.md)** - Notes and ideas for workflow improvements

## Quick Start

### 1. Browse the Workflow

Read [WORKFLOW.md](WORKFLOW.md) to understand the complete software development lifecycle:

- **17 SDLC Phases**: From requirements to continuous improvement
- **Expert Roles**: Who to hire for each phase
- **Tools & Processes**: Industry best practices for each domain
- **Domain-Specific Guidance**: Kernel, eBPF, Barebox, Django, AI/ML

### 2. Plan Your Hiring

Use [ROADMAP.md](ROADMAP.md) for strategic hiring decisions:

- **Years 0-5**: Foundation team (5-20 engineers)
- **Years 5-10**: Growth phase (20-100 engineers)
- **Years 10-20**: Maturity (100-500 engineers)
- **Years 20-30**: Industry leadership (500+ engineers)

### 3. Customize for Your Needs

Copy relevant sections to your project:

```bash
# Copy workflows to your project
cp WORKFLOW.md ~/your-project/docs/

# Copy hiring roadmap
cp ROADMAP.md ~/your-project/docs/

# Deploy Claude Code agents
cp -r agents/* ~/.claude/agents/
```

## Highlights

### Workflow Coverage

✅ **Complete SDLC**: All 17 phases from planning to post-mortems
✅ **Domain-Specific**: Kernel, eBPF, Barebox, Django, AI/ML guidance
✅ **Tool Recommendations**: Best-in-class tools for each phase
✅ **Checklists**: Code review, security, deployment checklists
✅ **Templates**: Post-mortem, ADR, release notes templates

### Roadmap Features

✅ **30-Year Strategic Plan**: From 5 to 1000+ engineers
✅ **Role Taxonomy**: Complete IC track and management track
✅ **Compensation Strategy**: Market-rate guidance with equity
✅ **Org Structure**: How to structure teams at each phase
✅ **Process Maturity**: When to formalize processes (TDD, SOC2, etc.)

### Domain Coverage

- **Linux Kernel**: Upstream workflow, kselftests, checkpatch, mailing lists
- **eBPF**: CO-RE, libbpf, BPF selftests, verifier testing
- **Barebox**: Boot optimization, device tree, A/B partitions
- **Django**: ORM optimization, security (OWASP Top 10), REST APIs
- **AI/ML**: Model training, MLOps, drift detection, responsible AI

## Use Cases

### For Startups

- Hire the right roles at the right time
- Avoid premature scaling or delayed specialization
- Understand when to formalize processes (TDD, code review, SOC2)

### For Established Companies

- Fill organizational gaps (missing security, SRE, DevEx teams)
- Benchmark against industry best practices
- Plan next 10-20 years of growth

### For Individual Contributors

- Understand career progression (Junior → Senior → Staff → Principal)
- Learn industry-standard workflows (TDD, code review, deployment)
- Discover tools used by top companies

### For Engineering Managers

- Onboard new team members with workflow standards
- Establish team processes (code review, testing, deployment)
- Hire specialists (security, performance, SRE)

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

## Key Sections

### WORKFLOW.md Structure

1. Planning & Requirements
2. Architecture & Design
3. Test Planning
4. TDD Implementation
5. Static Analysis & Code Quality
6. Code Review
7. Dynamic Testing
8. Performance Profiling
9. Security Review
10. Documentation
11. Release Management
12. CI/CD Pipeline
13. Deployment
14. Monitoring & Observability
15. Incident Response
16. Maintenance
17. Continuous Improvement

**Plus:**
- Domain-specific best practices (Kernel, eBPF, Barebox, Django, AI/ML)
- Quick reference tables (tools, metrics, checklists)
- Templates (post-mortem, ADR, changelog)

### ROADMAP.md Structure

- **Phase 1 (0-5 years)**: Foundation team, first hires, MVP
- **Phase 2 (5-10 years)**: Growth, managers, specialists
- **Phase 3 (10-20 years)**: Maturity, directors, VPs, compliance
- **Phase 4 (20-30 years)**: Innovation, research, open source leadership

**Plus:**
- Role taxonomy (all roles from Junior to Distinguished)
- Compensation strategy (equity, bonuses, benefits)
- Team structure evolution (flat → directors → multi-level)
- Hiring principles (diversity, OSS contributors, culture fit)

## Top 10 Tools

As referenced in WORKFLOW.md:

1. **Git** - Version control
2. **Linux Kernel** - Foundation for systems work
3. **LLVM/Clang** - Compiler toolchain
4. **BCC/bpftrace** - eBPF tooling
5. **PostgreSQL** - Database
6. **Redis** - Caching
7. **Docker + Kubernetes** - Containers & orchestration
8. **Prometheus + Grafana** - Monitoring
9. **pytest** - Testing framework
10. **Terraform + Ansible** - Infrastructure as Code

## Philosophy

**Simplicity Over Complexity:**
- Don't over-engineer
- Only add what's needed for current stage
- Formalize processes when pain is felt

**Quality Without Dogma:**
- Test coverage targets (>80% unit, >60% integration)
- But focus on valuable tests, not vanity metrics

**People First:**
- Hire excellent people
- Give them autonomy
- Build systems that support them (tooling, processes)

**Open Source:**
- Contribute upstream (kernel, eBPF, Django)
- Build on open source
- Give back to community

## License

MIT License - see [LICENSE](LICENSE) for details.

## Feedback

Found an issue or have suggestions? Open an issue at:
https://github.com/anthropics/claude-code/issues

---

**Maintained by**: Low-level systems engineers, web developers, and AI practitioners

**Last Updated**: 2025-01-15

**Version**: 1.0.0
