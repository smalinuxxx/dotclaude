# Comprehensive Software Development Workflow

> Complete SDLC guide for building world-class software in low-level systems, performance engineering, security, and modern web/AI development.

## Table of Contents

1. [Planning & Requirements](#1-planning--requirements)
2. [Architecture & Design](#2-architecture--design)
3. [Test Planning](#3-test-planning)
4. [TDD Implementation](#4-tdd-implementation)
5. [Static Analysis & Code Quality](#5-static-analysis--code-quality)
6. [Code Review](#6-code-review)
7. [Dynamic Testing](#7-dynamic-testing)
8. [Performance Profiling](#8-performance-profiling)
9. [Security Review](#9-security-review)
10. [Documentation](#10-documentation)
11. [Release Management](#11-release-management)
12. [CI/CD Pipeline](#12-cicd-pipeline)
13. [Deployment](#13-deployment)
14. [Monitoring & Observability](#14-monitoring--observability)
15. [Incident Response](#15-incident-response)
16. [Maintenance](#16-maintenance)
17. [Continuous Improvement](#17-continuous-improvement)

---

## 1. Planning & Requirements

**Expert Roles:**
- Product Manager
- Requirements Engineer
- Technical Architect
- Domain Experts (kernel/embedded/web/AI)

### Activities

1. **Requirements Gathering**
   - Stakeholder interviews
   - User research
   - Market analysis
   - Competitive analysis

2. **Technical Feasibility**
   - Technology assessment
   - Performance feasibility (latency budgets, throughput targets)
   - Security constraints
   - Platform compatibility (x86, ARM, RISC-V)

3. **Risk Assessment**
   - Technical risks (API compatibility, kernel ABI stability)
   - Security threats (threat modeling with STRIDE)
   - Performance risks (scalability bottlenecks)
   - Compliance risks (standards, regulations)

4. **Scope Definition**
   - Feature prioritization (MoSCoW method)
   - MVP definition
   - Release milestones
   - Success metrics (KPIs)

5. **Acceptance Criteria**
   - Functional requirements (what system must do)
   - Non-functional requirements (performance, security, scalability)
   - Test acceptance criteria
   - Security acceptance criteria

### Deliverables

- Requirements Specification Document (RSD)
- Architecture Decision Records (ADRs)
- Threat Model (STRIDE/DREAD)
- Performance Requirements (SLAs, latency budgets)
- Project Charter

### Tools

- **Tracking:** Jira, Linear, GitHub Issues
- **Documentation:** Confluence, Notion, Markdown
- **Diagrams:** Draw.io, Mermaid, PlantUML
- **Threat Modeling:** Microsoft Threat Modeling Tool, OWASP Threat Dragon

### Domain-Specific Notes

**Kernel:** Define syscall interface, kernel ABI compatibility requirements, stable vs mainline target

**eBPF:** BPF program safety requirements, verifier constraints, map sizing

**Barebox:** Boot time requirements, size constraints, supported boards

**Django:** API design (REST/GraphQL), database choice, authentication method

**AI/ML:** Model accuracy requirements, inference latency, training data needs

---

## 2. Architecture & Design

**Expert Roles:**
- Solutions Architect
- Security Architect
- Performance Engineer
- Database Architect
- Kernel Architect

### Activities

1. **System Architecture**
   - High-level design (C4 diagrams: Context, Container, Component, Code)
   - Module decomposition
   - Interface definitions
   - Data flow design

2. **API Design**
   - Syscall design (kernel)
   - REST/GraphQL API (web)
   - Library API (eBPF helpers)
   - Version strategy (semver)

3. **Database Design**
   - Schema design (normalized forms)
   - Indexing strategy
   - Query patterns
   - Migration strategy
   - Replication topology

4. **Security Architecture**
   - Authentication design (OAuth2, JWT, kernel capabilities)
   - Authorization model (RBAC, ABAC, DAC/MAC for kernel)
   - Data protection (encryption at rest/in transit)
   - Attack surface minimization
   - Defense in depth

5. **Performance Architecture**
   - Algorithmic complexity targets (O(n log n) max)
   - Caching strategy (Redis, in-memory, CPU cache-friendly)
   - Concurrency model (locks, RCU, lock-free)
   - Resource budgets (memory, CPU)

6. **Technology Stack**
   - Language selection (C, Rust, Python)
   - Framework selection (Django, Flask)
   - Database selection (PostgreSQL, Redis)
   - Infrastructure (cloud, on-prem, hybrid)

### Deliverables

- System Architecture Document (SAD)
- C4 Diagrams (Context, Container, Component)
- API Specifications (OpenAPI/Swagger, syscall man pages)
- Database Schema (ERD diagrams)
- Security Design Document
- Performance Design Document
- Technology Stack ADR

### Tools

- **Architecture:** C4 Model, ArchiMate
- **Diagrams:** PlantUML, Mermaid, Draw.io, Lucidchart
- **API Design:** Swagger/OpenAPI Editor, Postman
- **Database:** DbDiagram.io, DBeaver, pgModeler
- **Kernel:** Doxygen (call graphs), Understand

### Domain-Specific Notes

**Kernel:** Define locking hierarchy, RCU usage, memory allocation strategy (GFP flags), interrupt context constraints

**eBPF:** Map types selection, BPF-to-BPF calls, CO-RE (BTF) strategy, helper function usage

**Barebox:** Device tree design, driver architecture, bootloader stages (PBL, main)

**Django:** ORM strategy vs raw SQL, REST vs GraphQL, async views (ASGI)

**AI/ML:** Model architecture, training pipeline, inference optimization (quantization, pruning)

---

## 3. Test Planning

**Expert Roles:**
- QA Lead
- Test Architect
- Security Test Engineer
- Performance Test Engineer

### Activities

1. **Test Strategy**
   - Test levels (unit, integration, system, acceptance)
   - Test types (functional, performance, security, regression)
   - Test coverage targets (>80% unit, >60% integration)
   - Test automation strategy

2. **Test Planning**
   - Test scope per release
   - Test schedule
   - Resource allocation
   - Risk-based testing priorities

3. **Test Environment**
   - Development environment
   - Staging environment (production-like)
   - CI/CD environment
   - Hardware testbeds (for kernel/embedded)

4. **Test Data**
   - Test data generation
   - Synthetic vs production data
   - Data privacy (anonymization)
   - Edge cases & boundary values

5. **Security Test Planning**
   - Fuzzing strategy (coverage-guided, grammar-based)
   - Penetration testing scope
   - Vulnerability scanning
   - Compliance testing (CIS benchmarks)

6. **Performance Test Planning**
   - Load profiles (normal, peak, stress)
   - Performance metrics (latency, throughput, resource usage)
   - Baseline establishment
   - Regression detection

### Deliverables

- Test Strategy Document
- Test Plan per Release
- Test Environment Specification
- Test Data Sets
- Security Test Plan
- Performance Test Plan

### Tools

- **Test Management:** TestRail, Zephyr, qTest
- **Test Planning:** Confluence, Notion
- **Kernel Testing:** kselftests framework, Linux Test Project (LTP)
- **Fuzzing:** Syzkaller (kernel), AFL++, libFuzzer
- **Performance:** locust, k6, Apache JMeter
- **Web E2E:** Playwright, Selenium, Cypress

### Domain-Specific Notes

**Kernel:** Plan for kselftests, LTP, boot testing on real hardware, multi-arch testing (x86, ARM, RISC-V)

**eBPF:** BPF selftests, verifier testing, userspace unit tests for BPF programs

**Barebox:** Boot testing on supported boards, QEMU testing, size regression tests

**Django:** Test database setup (SQLite for speed, PostgreSQL for accuracy), fixture management

**AI/ML:** Validation set strategy, A/B testing plan, model evaluation metrics

---

## 4. TDD Implementation

**Expert Roles:**
- Senior Software Engineers (C, Python, Rust)
- Kernel Developers
- eBPF Engineers
- Django Backend Developers
- Frontend Engineers
- AI/ML Engineers

### Activities

1. **TDD Red-Green-Refactor Cycle**
   - **Red:** Write failing test first
   - **Green:** Write minimal code to pass test
   - **Refactor:** Clean up code while keeping tests green

2. **Version Control Workflow**
   - Feature branching (Git Flow) or trunk-based development
   - Atomic commits (single logical change)
   - Conventional commits (feat:, fix:, refactor:, test:, doc:)
   - Pull request workflow

3. **Code Implementation**
   - Write clean, readable code
   - Follow coding standards (PEP8, kernel coding style)
   - Minimize complexity (cyclomatic complexity <10)
   - Avoid premature optimization

4. **Unit Testing**
   - Test one unit of code (function, method, class)
   - Fast tests (<100ms each)
   - Isolated tests (no external dependencies)
   - Deterministic tests (no flaky tests)

5. **Integration Testing**
   - Test component interactions
   - Database integration tests
   - API integration tests
   - External service mocking

6. **Documentation as Code**
   - Docstrings for all public APIs
   - Kerneldoc comments (kernel)
   - Inline comments for non-obvious logic only
   - README updates with new features

### Deliverables

- Source Code
- Unit Tests (>80% coverage)
- Integration Tests
- Git Commit History
- Feature Documentation

### Tools

- **Version Control:** Git + GitHub/GitLab
- **Pre-commit Hooks:** pre-commit framework
- **Python Testing:** pytest, pytest-cov, pytest-django
- **C Testing:** kselftests (kernel), Check, Unity, Cmocka
- **Coverage:** gcov/lcov (C), coverage.py (Python)
- **Linting:** ruff/pylint (Python), checkpatch.pl (kernel), clang-tidy (C)
- **Formatting:** Black/ruff (Python), clang-format (C)

### TDD Examples by Domain

**Kernel:**
```c
// Test first (kselftests)
KSTDLIB_TEST(test_my_function) {
    EXPECT_EQ(my_function(0), 0);
    EXPECT_EQ(my_function(10), 100);
}

// Then implement
int my_function(int x) {
    return x * x;
}
```

**Python/Django:**
```python
# Test first
def test_user_creation():
    user = User.objects.create(username="test")
    assert user.username == "test"
    assert user.is_active

# Then implement
class User(models.Model):
    username = models.CharField(max_length=150)
    is_active = models.BooleanField(default=True)
```

### Domain-Specific Notes

**Kernel:** Cannot use traditional unit testing (runs in kernel context). Use kselftests for syscalls/drivers, manual unit tests in userspace where possible

**eBPF:** Write userspace unit tests that load BPF programs, unit test helper functions separately

**Barebox:** Use QEMU for automated testing, hardware-in-the-loop for board-specific code

**Django:** Use django.test.TestCase (transactional tests), pytest-django for fixtures

**AI/ML:** TDD for data processing pipelines, model evaluation functions; models themselves validated differently

---

## 5. Static Analysis & Code Quality

**Expert Roles:**
- Code Quality Engineer
- Static Analysis Specialist
- Security Engineer

### Activities

1. **Static Code Analysis**
   - Bug detection (null deref, buffer overflow, use-after-free)
   - Code smell detection (long functions, deep nesting)
   - Complexity metrics (cyclomatic complexity)
   - Security vulnerabilities (CWE patterns)

2. **Code Style Enforcement**
   - PEP8 (Python)
   - Linux kernel coding style (scripts/checkpatch.pl)
   - Consistent formatting (automatic)

3. **Type Checking**
   - mypy (Python static type checking)
   - Sparse (kernel type checking)

4. **Dependency Analysis**
   - Dependency graph analysis
   - CVE scanning (known vulnerabilities)
   - License compliance (GPL, MIT, Apache)
   - Outdated dependency detection

5. **Code Duplication**
   - Detect copy-paste code
   - Suggest refactoring opportunities

6. **Security Scanning**
   - SAST (Static Application Security Testing)
   - Secret detection (API keys, passwords in code)
   - CWE pattern detection

### Deliverables

- Static Analysis Reports
- Vulnerability Reports
- Code Quality Metrics (Maintainability Index)
- Refactoring Recommendations
- License Compliance Report
- SBOM (Software Bill of Materials)

### Tools

- **General:** SonarQube/SonarCloud, Codacy, CodeClimate
- **Kernel:** Sparse, Coccinelle, Coverity, Smatch
- **Python:** Bandit (security), mypy (types), pylint, ruff
- **Security:** Semgrep, Snyk, Trivy, Grype
- **Secrets:** TruffleHog, Gitleaks, detect-secrets
- **Dependency:** Dependabot, Renovate, pip-audit
- **License:** FOSSA, Black Duck, Snyk

### Metrics to Track

- **Code Coverage:** >80% target
- **Cyclomatic Complexity:** <10 per function
- **Maintainability Index:** >65 (good), >85 (excellent)
- **Technical Debt Ratio:** <5%
- **Duplicated Lines:** <3%
- **Critical Security Issues:** 0

### Domain-Specific Notes

**Kernel:** Use Sparse for type checking, Coccinelle for semantic patches, Coverity for deep analysis, Smatch for logic bugs

**eBPF:** BPF verifier is built-in static analysis; use static analysis on userspace loader code

**Python/Django:** Bandit for security, mypy for type safety, ruff for style+linting

**C Code:** Clang Static Analyzer, cppcheck, Infer (Facebook)

---

## 6. Code Review

**Expert Roles:**
- Senior Engineers
- Staff Engineers
- Principal Engineers
- Security Reviewers
- Performance Specialists

### Activities

1. **Pre-Review Checklist**
   - [ ] All tests pass (CI green)
   - [ ] Code coverage maintained or improved
   - [ ] Documentation updated
   - [ ] No linter errors
   - [ ] Self-review completed
   - [ ] Commit messages follow convention

2. **Review Focus Areas**

   **Correctness:**
   - Logic errors
   - Edge cases handled
   - Error handling (check all error paths)
   - Concurrency issues (race conditions, deadlocks)

   **Security:**
   - Input validation (all user inputs)
   - Injection vulnerabilities (SQL, command, XSS)
   - Authentication/authorization checks
   - Cryptography usage (no homebrew crypto)
   - Integer overflow/underflow
   - Buffer overflows
   - Use-after-free, double-free

   **Performance:**
   - Algorithmic complexity (O(n²) red flag)
   - Unnecessary allocations
   - Lock contention (lock duration, granularity)
   - Database query efficiency (N+1 queries)
   - Cache friendliness

   **Maintainability:**
   - Code readability (meaningful names)
   - Function length (<50 lines ideal)
   - Single Responsibility Principle
   - DRY (Don't Repeat Yourself)
   - Comments for non-obvious logic only

   **API Design:**
   - Backward compatibility (especially kernel ABI)
   - Error handling (return codes, exceptions)
   - API naming consistency
   - Documentation completeness

3. **Kernel-Specific Review**
   - Locking correctness (lock hierarchy, RCU correctness)
   - Memory allocation (GFP flags, free on all error paths)
   - Interrupt context safety (no sleep in interrupt)
   - ABI stability (no breaking changes)
   - Checkpatch.pl compliance

4. **Django-Specific Review**
   - ORM query efficiency (select_related, prefetch_related)
   - SQL injection prevention (never raw SQL with user input)
   - XSS prevention (template auto-escaping)
   - CSRF protection (proper use of csrf_token)
   - Authentication checks (login_required, permissions)

### Code Review Checklist

```markdown
## Functionality
- [ ] Code does what it's supposed to
- [ ] Edge cases handled
- [ ] Error paths tested

## Security
- [ ] Input validation present
- [ ] No SQL injection
- [ ] No XSS vulnerabilities
- [ ] Authentication/authorization correct
- [ ] Secrets not hardcoded

## Performance
- [ ] No O(n²) or worse algorithms
- [ ] Database queries optimized
- [ ] No unnecessary allocations

## Tests
- [ ] Unit tests for new code
- [ ] Integration tests for interactions
- [ ] Tests actually test the right thing
- [ ] No flaky tests

## Documentation
- [ ] API documentation updated
- [ ] README updated if needed
- [ ] Comments explain "why" not "what"

## Style
- [ ] Follows project coding style
- [ ] No unnecessary complexity
- [ ] Readable and maintainable
```

### Deliverables

- Code Review Comments
- Approval/Request Changes Decision
- Refactoring Suggestions

### Tools

- **GitHub:** Pull Requests
- **GitLab:** Merge Requests
- **Gerrit:** (Linux kernel workflow)
- **Review Board**
- **Crucible**

### Review Etiquette

1. **Be Kind:** Focus on code, not person
2. **Be Specific:** "This could cause a race condition" not "This is wrong"
3. **Explain Why:** "Use select_related() here to avoid N+1 queries"
4. **Suggest Alternatives:** Provide better approach when criticizing
5. **Acknowledge Good Work:** Comment on clever solutions

---

## 7. Dynamic Testing

**Expert Roles:**
- QA Engineers
- Test Automation Engineers
- Performance Engineers
- Security Engineers (penetration testers)

### Activities

1. **Unit Testing**
   - Developer-owned
   - Fast (<100ms per test)
   - Isolated (mocked dependencies)
   - Coverage >80%

2. **Integration Testing**
   - Component interaction testing
   - Database integration
   - API integration
   - Message queue integration

3. **System Testing (E2E)**
   - Complete user workflows
   - Real database, no mocks
   - Production-like environment
   - Smoke tests for critical paths

4. **Performance Testing**
   - **Load Testing:** Expected load
   - **Stress Testing:** Beyond capacity
   - **Endurance Testing:** Sustained load (memory leaks)
   - **Spike Testing:** Sudden traffic spikes
   - **Latency Measurement:** p50, p95, p99
   - **Resource Profiling:** CPU, memory, I/O

5. **Security Testing**
   - **Fuzzing:** Coverage-guided (AFL++, libFuzzer, Syzkaller)
   - **Penetration Testing:** OWASP Top 10 testing
   - **Vulnerability Scanning:** Known CVEs
   - **Authentication Testing:** Bypass attempts
   - **Authorization Testing:** Privilege escalation

6. **Regression Testing**
   - Re-run all tests for every change
   - Automated in CI/CD
   - Performance regression detection

### Domain-Specific Testing

**Kernel:**
- **kselftests:** In-tree kernel testing framework
- **LTP:** Linux Test Project (comprehensive test suite)
- **Boot Testing:** QEMU, real hardware
- **Stability Testing:** stress-ng, kernel torture tests
- **Syzkaller:** Kernel fuzzer (syscall fuzzing)
- **Multi-arch:** Test on x86, ARM, RISC-V

**eBPF:**
- **BPF selftests:** In-tree BPF testing
- **Verifier Testing:** Invalid programs rejected
- **Userspace Unit Tests:** Test BPF program logic
- **Integration:** Test with kernel (via syscalls)
- **Performance:** Minimal overhead verification

**Barebox:**
- **QEMU Testing:** Automated boot testing
- **Hardware Testing:** Board-specific tests
- **Boot Time:** Measure boot latency
- **Size Regression:** Binary size tracking

**Django:**
- **Unit:** django.test.TestCase, pytest-django
- **Integration:** Database, cache, email
- **E2E:** Playwright, Selenium (browser automation)
- **API:** Test REST endpoints (DRF)
- **Performance:** Load test API endpoints

**AI/ML:**
- **Model Evaluation:** Accuracy, precision, recall, F1
- **Data Validation:** Great Expectations
- **Integration:** Model serving tests
- **Performance:** Inference latency, throughput

### Deliverables

- Test Execution Reports
- Bug Reports (JIRA, GitHub Issues)
- Performance Benchmarks
- Security Test Reports
- Code Coverage Reports (HTML, badges)

### Tools

**General:**
- pytest, pytest-cov, pytest-xdist (parallel)
- tox (multi-environment testing)

**Kernel:**
- kselftests, LTP, Syzkaller
- QEMU (emulation), KVM
- stress-ng, kernel torture tests

**Performance:**
- perf, perf-tools, flamegraph
- locust, k6 (load testing)
- Apache JMeter, Gatling
- wrk, hey (HTTP benchmarking)

**Security:**
- OWASP ZAP, Burp Suite
- AFL++, libFuzzer, Syzkaller
- Nikto, Nmap

**Web E2E:**
- Playwright (modern, fast)
- Selenium (legacy, browser support)
- Cypress (developer-friendly)

**CI Integration:**
- GitHub Actions, GitLab CI
- Jenkins, CircleCI

---

## 8. Performance Profiling

**Expert Roles:**
- Performance Engineers
- eBPF Specialists
- Database Performance Engineers

### Activities

1. **CPU Profiling**
   - Identify hotspots (functions consuming most CPU)
   - Flamegraph generation
   - On-CPU vs off-CPU analysis
   - Per-thread profiling

2. **Memory Profiling**
   - Heap profiling (allocations, leaks)
   - Stack usage
   - Cache efficiency (L1, L2, L3 misses)
   - Memory bandwidth

3. **I/O Profiling**
   - Disk I/O (read/write patterns)
   - Block device tracing
   - Filesystem latency
   - Network I/O

4. **Lock Profiling**
   - Lock contention analysis
   - Lock hold times
   - Lock dependency chains
   - Lockdep (kernel)

5. **Database Profiling**
   - Slow query log
   - Query execution plans (EXPLAIN)
   - Index usage
   - Connection pooling

6. **Optimization**
   - Algorithm optimization (reduce complexity)
   - Data structure optimization (cache-friendly)
   - Lock-free algorithms (where possible)
   - Database query optimization (indexes, denormalization)
   - Caching (Redis, in-memory)

### Profiling Workflow

1. **Establish Baseline:** Measure before optimization
2. **Identify Bottleneck:** Profile to find hotspot
3. **Optimize:** Apply targeted optimization
4. **Measure:** Verify improvement
5. **Regression Test:** Ensure no performance regression

### Domain-Specific Profiling

**Kernel:**
- **perf:** CPU profiling, hardware counters
- **Ftrace:** Function tracing, event tracing
- **eBPF/bpftrace:** Custom tracing (latency, syscalls)
- **Lockdep:** Deadlock detection
- **KASAN:** Memory error detection (use-after-free)

**eBPF:**
- **Overhead Measurement:** BPF program execution time
- **Map Access Latency:** Hash vs array maps
- **Verifier Complexity:** Instruction count

**Python/Django:**
- **py-spy:** Sampling profiler (low overhead)
- **cProfile:** Deterministic profiler
- **Django Debug Toolbar:** Query profiling
- **silk:** Request/response profiling

**Database (PostgreSQL):**
- **EXPLAIN ANALYZE:** Query execution plan
- **pg_stat_statements:** Query statistics
- **Indexing:** Create indexes for slow queries

### Deliverables

- Performance Analysis Reports
- Flamegraphs (CPU, memory, off-CPU)
- Optimization Recommendations
- Before/After Benchmarks
- Performance Regression Tests

### Tools

**CPU Profiling:**
- perf (Linux), perf-tools
- bpftrace, BCC tools (profile, cpudist)
- py-spy, Austin (Python)
- Flamegraph (Brendan Gregg)

**Memory Profiling:**
- Valgrind (memcheck, massif, cachegrind)
- heaptrack (heap profiling)
- KASAN (kernel memory errors)
- memory_profiler (Python)

**I/O Profiling:**
- iotop, blktrace
- bpftrace (biolatency, biosnoop)
- perf (block tracing)

**Database:**
- pgBadger (PostgreSQL log analyzer)
- EXPLAIN ANALYZE
- Django Debug Toolbar

**Tracing:**
- bpftrace (high-level eBPF)
- BCC tools (pre-built eBPF tools)
- Ftrace (kernel tracing)

---

## 9. Security Review

**Expert Roles:**
- Security Engineers
- Penetration Testers
- Cryptography Experts
- Compliance Officers

### Activities

1. **Threat Modeling**
   - STRIDE analysis (Spoofing, Tampering, Repudiation, Info Disclosure, DoS, Elevation of Privilege)
   - Attack surface analysis
   - Trust boundaries identification
   - Data flow diagrams (DFDs)

2. **Security Code Review**
   - Input validation (sanitize all user input)
   - Injection prevention (SQL, command, XSS, LDAP)
   - Authentication review (password storage, session management)
   - Authorization review (access control, privilege checks)
   - Cryptography review (TLS, hashing, encryption)
   - Error handling (no info disclosure in errors)
   - Secrets management (no hardcoded secrets)

3. **Vulnerability Assessment**
   - SAST (Static Application Security Testing)
   - DAST (Dynamic Application Security Testing)
   - Dependency scanning (CVEs in dependencies)
   - Container scanning (base image vulnerabilities)

4. **Penetration Testing**
   - OWASP Top 10 testing
   - Authentication bypass attempts
   - Authorization bypass (privilege escalation)
   - Session hijacking
   - CSRF testing
   - API security testing

5. **Fuzzing**
   - Coverage-guided fuzzing (AFL++, libFuzzer)
   - Kernel fuzzing (Syzkaller)
   - Grammar-based fuzzing (for parsers)
   - Crash triage & deduplication

6. **Compliance**
   - CIS Benchmarks
   - OWASP ASVS (Application Security Verification Standard)
   - PCI-DSS (if handling payment data)
   - GDPR (data protection)
   - HIPAA (healthcare data)

### Security Review Checklist

**Authentication:**
- [ ] Passwords hashed (bcrypt, Argon2)
- [ ] Multi-factor authentication supported
- [ ] Account lockout after failed attempts
- [ ] Secure session management

**Authorization:**
- [ ] Principle of least privilege
- [ ] All endpoints protected
- [ ] No insecure direct object references
- [ ] Horizontal privilege escalation prevented

**Input Validation:**
- [ ] All input validated (whitelist, not blacklist)
- [ ] SQL injection prevented (parameterized queries)
- [ ] XSS prevented (output encoding)
- [ ] Command injection prevented (no shell=True with user input)

**Cryptography:**
- [ ] TLS for data in transit (TLS 1.3)
- [ ] Encryption for sensitive data at rest
- [ ] No weak crypto (MD5, SHA1, DES)
- [ ] Secure random (not predictable)

**Error Handling:**
- [ ] No stack traces to users
- [ ] No sensitive info in errors
- [ ] Proper logging (but no sensitive data logged)

**Dependency Security:**
- [ ] All dependencies scanned for CVEs
- [ ] Outdated dependencies updated
- [ ] Supply chain verification (signatures)

### Domain-Specific Security

**Kernel:**
- **Privilege Escalation:** Check capability checks (CAP_SYS_ADMIN, etc.)
- **Race Conditions:** TOCTTOU (Time-of-check-time-of-use)
- **Memory Safety:** Buffer overflow, use-after-free, double-free
- **Integer Overflow:** Multiplication before allocation
- **Spectre/Meltdown:** Mitigations in place
- **kCFI:** Control Flow Integrity (if supported)
- **KASLR:** Address space randomization

**eBPF:**
- **Verifier Bypass:** Ensure no verifier bugs exploited
- **Information Leak:** Uninitialized memory read
- **Denial of Service:** Resource exhaustion (map size limits)

**Barebox:**
- **Secure Boot:** Chain of trust verification
- **Attack Surface:** Minimize exposed services
- **Memory Safety:** Same as kernel

**Django:**
- **OWASP Top 10:** All addressed
- **SQL Injection:** Use ORM, or parameterized queries
- **XSS:** Template auto-escaping, CSP header
- **CSRF:** Use {% csrf_token %}
- **Authentication:** Use Django auth, or well-tested library
- **Authorization:** Permission checks on views
- **Secrets:** Environment variables, never commit
- **HTTPS:** Enforce with SECURE_SSL_REDIRECT

**AI/ML:**
- **Model Poisoning:** Validate training data
- **Adversarial Examples:** Robustness testing
- **Model Stealing:** Rate limiting, authentication
- **Data Privacy:** Differential privacy, federated learning

### Deliverables

- Security Assessment Report
- Penetration Test Report
- Vulnerability List (with CVSS scores)
- Remediation Plan (prioritized)
- Compliance Checklist

### Tools

**SAST:**
- Semgrep, Snyk Code, SonarQube
- Bandit (Python), Brakeman (Rails)
- Sparse, Coverity (kernel)

**DAST:**
- OWASP ZAP, Burp Suite
- Nikto, w3af

**Dependency Scanning:**
- Snyk, Dependabot, Grype, Trivy
- pip-audit (Python), cargo audit (Rust)

**Fuzzing:**
- AFL++, libFuzzer, honggfuzz
- Syzkaller (kernel syscalls)

**Container Security:**
- Trivy, Grype, Clair
- Docker Bench for Security

**Secrets:**
- TruffleHog, Gitleaks, detect-secrets

**Compliance:**
- OpenSCAP (CIS benchmarks)
- Lynis (system hardening)

---

## 10. Documentation

**Expert Roles:**
- Technical Writers
- Developer Advocates
- Documentation Engineers

### Activities

1. **Code Documentation**
   - **Inline Comments:** Non-obvious logic only (explain "why" not "what")
   - **Docstrings:** All public APIs (functions, classes, modules)
   - **Kerneldoc:** Kernel functions, structs, enums
   - **Type Hints:** Python type annotations (PEP 484)

2. **API Documentation**
   - **REST API:** OpenAPI/Swagger spec
   - **Syscalls:** Man pages (groff format)
   - **Library API:** Doxygen, Sphinx
   - **Examples:** Code snippets for common use cases

3. **Architecture Documentation**
   - **System Design:** C4 diagrams (Context, Container, Component, Code)
   - **ADRs:** Architecture Decision Records (why chose X over Y)
   - **Sequence Diagrams:** Complex workflows
   - **Data Flow:** How data moves through system

4. **User Documentation**
   - **README:** Quick start, installation, basic usage
   - **User Guide:** Step-by-step tutorials
   - **How-To Guides:** Task-oriented (solve specific problem)
   - **Reference:** Complete feature documentation
   - **FAQ:** Frequently asked questions

5. **Developer Documentation**
   - **CONTRIBUTING.md:** How to contribute (code, tests, docs)
   - **Development Setup:** Local environment setup
   - **Coding Standards:** Style guide, conventions
   - **Git Workflow:** Branching strategy, commit messages
   - **Debugging Guide:** Common issues, profiling

6. **Operations Documentation**
   - **Deployment Guide:** How to deploy
   - **Configuration:** All config options explained
   - **Runbooks:** Incident response procedures
   - **Monitoring:** Metrics, alerts, dashboards

### Documentation Formats

**Markdown:**
- README.md, CONTRIBUTING.md, ADRs
- Rendered on GitHub/GitLab
- Simple, version-controlled

**Sphinx (reStructuredText):**
- Python documentation (official)
- Kernel documentation (Documentation/)
- Autodoc (docstring extraction)
- HTML, PDF output

**OpenAPI/Swagger:**
- REST API specification (YAML/JSON)
- Interactive API docs (Swagger UI)
- Code generation (clients, servers)

**Man Pages:**
- Syscall documentation
- Command-line tool documentation
- groff format

### Documentation Structure

```
docs/
├── README.md                 # Quick start
├── architecture/
│   ├── overview.md
│   ├── adr/                  # Architecture Decision Records
│   │   ├── 0001-use-postgresql.md
│   │   └── 0002-rest-over-graphql.md
│   └── diagrams/             # C4, sequence diagrams
├── user-guide/
│   ├── installation.md
│   ├── tutorials/
│   └── how-to/
├── api/
│   ├── openapi.yaml
│   └── examples/
├── development/
│   ├── setup.md
│   ├── coding-standards.md
│   ├── testing.md
│   └── debugging.md
└── operations/
    ├── deployment.md
    ├── configuration.md
    └── runbooks/
```

### Domain-Specific Documentation

**Kernel:**
- **Kerneldoc:** `/** ... */` comments for functions/structs
- **Documentation/:** reStructuredText files (Sphinx)
- **Man Pages:** Syscall documentation (man 2 syscall)
- **Kconfig:** Document config options

**eBPF:**
- **BPF Helpers:** Document helper functions (man bpf-helpers)
- **Map Types:** Explain when to use each type
- **Examples:** Sample BPF programs (samples/bpf/)

**Barebox:**
- **Documentation/:** Device tree bindings, board documentation
- **Commands:** Document all shell commands

**Django:**
- **Docstrings:** Google style or NumPy style
- **API Docs:** drf-spectacular (auto-generate OpenAPI)
- **Admin:** Document custom admin actions

**AI/ML:**
- **Model Cards:** Model metadata (architecture, training data, performance)
- **Data Cards:** Dataset documentation
- **Experiment Tracking:** MLflow, Weights & Biases

### Deliverables

- README.md (updated)
- API Documentation (OpenAPI, man pages)
- Architecture Documentation (ADRs, diagrams)
- User Guides
- Developer Guides
- CONTRIBUTING.md
- Inline Code Comments/Docstrings

### Tools

**General:**
- Markdown (GitHub-flavored)
- Mermaid (diagrams in Markdown)
- Draw.io, Lucidchart (diagrams)

**Sphinx:**
- Sphinx (Python/kernel docs)
- reStructuredText
- Autodoc (docstring extraction)

**API:**
- Swagger/OpenAPI Editor
- Redoc (OpenAPI renderer)
- drf-spectacular (Django REST)

**Static Site Generators:**
- MkDocs (Markdown → HTML)
- Docusaurus (React-based)
- GitBook

**Kernel:**
- Kerneldoc → Sphinx
- man page generation (groff)

**Diagrams:**
- PlantUML (text → diagrams)
- Mermaid (in Markdown)
- C4-PlantUML (C4 diagrams)

---

## 11. Release Management

**Expert Roles:**
- Release Engineers
- DevOps Engineers
- Build Engineers

### Activities

1. **Versioning**
   - **Semantic Versioning (SemVer):** MAJOR.MINOR.PATCH
     - MAJOR: Breaking changes
     - MINOR: New features (backward compatible)
     - PATCH: Bug fixes
   - Git tagging (annotated tags)
   - Version in code (__version__, VERSION)

2. **Changelog Generation**
   - Based on conventional commits
   - Auto-generation (git-cliff, standard-version)
   - Manual curation for major releases
   - Format: Keep a Changelog

3. **Release Notes**
   - **New Features:** User-facing changes
   - **Bug Fixes:** What was broken, now fixed
   - **Breaking Changes:** Migration guide
   - **Performance Improvements:** Benchmarks
   - **Security Fixes:** CVE references
   - **Deprecations:** What's being removed, alternatives
   - **Acknowledgments:** Contributors

4. **Build & Packaging**
   - **Kernel:** make, kbuild, kernel .tar.xz
   - **Python:** wheel, sdist (setuptools, poetry)
   - **Container:** Docker image (multi-stage, minimal base)
   - **Packages:** .deb (Debian), .rpm (RHEL)

5. **Artifact Signing**
   - GPG signing (git tags, release artifacts)
   - SLSA provenance (supply chain security)
   - Checksums (SHA256)

6. **Release Validation**
   - **Smoke Tests:** Critical paths work
   - **Installation Tests:** Fresh install succeeds
   - **Upgrade Tests:** Upgrade from previous version
   - **Rollback Tests:** Can rollback if needed

### Release Process

1. **Feature Freeze:** No new features, only bug fixes
2. **Release Candidate (RC):** Tag RC (v1.0.0-rc.1)
3. **Testing:** Extended testing on RC
4. **Bug Fixes:** Fix critical bugs, new RC if needed
5. **Final Release:** Tag v1.0.0
6. **Build Artifacts:** Generate packages, containers
7. **Sign Artifacts:** GPG sign
8. **Generate Changelog:** Auto + manual curation
9. **Write Release Notes:** User-focused
10. **Publish:** GitHub Releases, package registries
11. **Announcement:** Blog post, mailing list, social media

### CHANGELOG Format

```markdown
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2025-01-15

### Added
- New feature X for improved performance (#123)
- Support for ARM64 architecture (#145)

### Changed
- Updated API endpoint /users to /api/v2/users (#156)

### Deprecated
- Old authentication method (use OAuth2 instead)

### Removed
- Python 3.7 support (EOL)

### Fixed
- Fixed race condition in cache invalidation (#178)
- Fixed memory leak in connection pool (#182)

### Security
- Fixed CVE-2025-1234: SQL injection in login form
```

### Domain-Specific Release

**Kernel:**
- Tag format: v6.7.0, v6.7.1
- Release on kernel.org
- Announce on LKML
- Stable tree process for LTS

**Python/Django:**
- PyPI: `twine upload dist/*`
- Version in setup.py, __init__.py
- Wheel + source distribution

**Container:**
- Docker Hub, GitHub Container Registry, quay.io
- Tag: latest, v1.0.0, v1.0, v1
- Multi-arch builds (amd64, arm64)

**Embedded/Barebox:**
- Binary artifacts (.bin, .elf)
- Board-specific images
- Flashing instructions

### Deliverables

- CHANGELOG.md (updated)
- Release Notes (GitHub Releases, blog post)
- Git Tags (signed)
- Build Artifacts (signed, checksums)
  - Source tarball (.tar.gz, .tar.xz)
  - Python wheel (.whl)
  - Container image
  - Debian package (.deb)
  - RPM package (.rpm)
- SBOM (Software Bill of Materials)

### Tools

**Changelog:**
- git-cliff (Rust, convention-based)
- standard-version (npm, automated)
- Manual curation

**Versioning:**
- bumpversion, bump2version (Python)
- semantic-release (automated)

**Build:**
- make (kernel, C projects)
- Poetry, setuptools (Python)
- Docker, Buildah (containers)
- debuild, dpkg-deb (.deb)
- rpmbuild (.rpm)

**Signing:**
- GPG (git tag -s, gpg --sign)
- Cosign (container signing)
- Sigstore (SLSA provenance)

**SBOM:**
- Syft (generate SBOM)
- CycloneDX

**Publishing:**
- PyPI (twine)
- Docker Hub, GHCR, quay.io
- GitHub Releases

---

## 12. CI/CD Pipeline

**Expert Roles:**
- DevOps Engineers
- SRE (Site Reliability Engineers)
- Build Engineers

### Activities

1. **Continuous Integration (CI)**
   - Trigger on every commit/PR
   - Multi-stage pipeline:
     1. **Lint:** Code style, static analysis
     2. **Build:** Compile code
     3. **Test:** Run all tests (unit, integration)
     4. **Coverage:** Code coverage report
     5. **Security Scan:** SAST, dependency scan
     6. **Package:** Build artifacts
   - Build matrix (multiple Python versions, architectures)
   - Fast feedback (<10 minutes ideal)

2. **Continuous Delivery (CD)**
   - Automated packaging
   - Deploy to staging (automated)
   - Integration tests on staging
   - Artifact storage (registry, S3)
   - Manual promotion to production

3. **Continuous Deployment (Web/AI)**
   - Automated deploy to production (after tests pass)
   - Deployment strategies:
     - **Blue-Green:** Two environments, switch traffic
     - **Canary:** Gradual rollout (1%, 10%, 50%, 100%)
     - **Rolling:** Update instances one by one
   - Feature flags (gradual feature rollout)
   - Automatic rollback on errors

4. **Pipeline Best Practices**
   - **Fail Fast:** Run fast tests first
   - **Parallel:** Run independent jobs in parallel
   - **Caching:** Cache dependencies
   - **Artifacts:** Upload build artifacts
   - **Notifications:** Slack, email on failure
   - **Secrets:** Use secret management (not hardcoded)

### CI/CD Pipeline Example

```yaml
# GitHub Actions example
name: CI/CD

on: [push, pull_request]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Lint
        run: ruff check .

  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python: ['3.10', '3.11', '3.12']
    steps:
      - uses: actions/checkout@v3
      - name: Set up Python
        uses: actions/setup-python@v4
        with:
          python-version: ${{ matrix.python }}
      - name: Install dependencies
        run: pip install -e .[dev]
      - name: Run tests
        run: pytest --cov
      - name: Upload coverage
        uses: codecov/codecov-action@v3

  security:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Run Bandit
        run: bandit -r .
      - name: Dependency scan
        run: pip-audit

  build:
    needs: [lint, test, security]
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Build package
        run: python -m build
      - name: Upload artifact
        uses: actions/upload-artifact@v3
        with:
          name: package
          path: dist/

  deploy-staging:
    needs: build
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to staging
        run: ./deploy-staging.sh
```

### Domain-Specific CI/CD

**Kernel:**
- Build on multiple architectures (x86, ARM, RISC-V)
- Cross-compilation setup
- Boot test in QEMU
- Run kselftests
- Checkpatch.pl validation
- 0-day bot (automated testing on patches)

**eBPF:**
- Build BPF programs (clang -target bpf)
- Verifier testing (load programs, check rejection)
- Run BPF selftests
- CO-RE (BTF) compatibility checks

**Python/Django:**
- Tox (test multiple Python versions)
- Database matrix (SQLite, PostgreSQL)
- Django version matrix
- Migrate database in CI
- Collect static files

**Container:**
- Multi-stage builds (small images)
- Multi-arch builds (amd64, arm64)
- Container scanning (Trivy)
- Push to registry (Docker Hub, GHCR)

### Deliverables

- CI/CD Pipeline Config (`.github/workflows/`, `.gitlab-ci.yml`)
- Build Artifacts
- Test Reports
- Coverage Reports
- Security Scan Reports

### Tools

**CI/CD Platforms:**
- GitHub Actions (excellent for OSS)
- GitLab CI/CD (built-in)
- Jenkins (self-hosted, flexible)
- CircleCI (cloud-based)
- Travis CI (legacy)

**Build:**
- Make (kernel, C)
- Poetry, pip (Python)
- Docker, Buildah (containers)

**Testing:**
- pytest, tox (Python)
- QEMU (kernel boot testing)

**Artifacts:**
- GitHub Packages, GitLab Package Registry
- Docker Hub, GHCR, quay.io
- AWS S3, Google Cloud Storage

**Secrets:**
- GitHub Secrets, GitLab CI/CD Variables
- HashiCorp Vault
- AWS Secrets Manager

---

## 13. Deployment

**Expert Roles:**
- SRE (Site Reliability Engineers)
- Cloud Engineers
- Infrastructure Engineers
- Kernel Integration Engineers

### Activities

1. **Deployment Strategies**
   - **Blue-Green:** Two identical environments, instant switch
   - **Canary:** Gradual rollout (test on small % of users)
   - **Rolling:** Update instances sequentially
   - **Recreate:** Stop all, then deploy (downtime)

2. **Infrastructure Provisioning**
   - Infrastructure as Code (Terraform, Ansible)
   - Immutable infrastructure (containers, images)
   - Auto-scaling (horizontal, vertical)
   - Load balancing (round-robin, least-conn, sticky sessions)

3. **Configuration Management**
   - Environment-specific configs (dev, staging, prod)
   - Secrets management (Vault, AWS Secrets Manager)
   - Feature flags (LaunchDarkly, Unleash)
   - Config validation before deployment

4. **Database Deployment**
   - **Migrations:** Apply in deployment (idempotent)
   - **Zero-Downtime:** Backward-compatible migrations
   - **Rollback Plan:** Reversible migrations
   - **Backup:** Before migration

5. **Monitoring During Deployment**
   - Health checks (HTTP /health endpoint)
   - Canary metrics (error rate, latency)
   - Automatic rollback on threshold breach
   - Deployment alerts (start, success, failure)

### Domain-Specific Deployment

**Kernel:**
- **Packaging:** .deb, .rpm for distributions
- **Distribution Integration:** Submit to Debian, Ubuntu, RHEL, Arch
- **Bootloader:** GRUB, Barebox configuration
- **Multi-boot:** Keep old kernel for rollback
- **Kexec:** Fast reboot without BIOS

**eBPF:**
- **CO-RE:** Ensure BTF available on target
- **Distribution:** Package with libbpf
- **Loading:** Systemd service, init script

**Barebox:**
- **Flashing:** Write to flash (SPI, eMMC, SD)
- **Boot Script:** Update boot.scr
- **Failsafe:** Dual-boot setup (A/B partitions)

**Django (Web):**
- **Container:** Docker image with app + dependencies
- **Kubernetes:** Deployment, Service, Ingress
- **Static Files:** Collect, upload to CDN
- **Database Migrations:** `python manage.py migrate`
- **Reverse Proxy:** Nginx, Gunicorn/uWSGI

**AI/ML:**
- **Model Serving:** TorchServe, TFServing, ONNX Runtime
- **Model Registry:** MLflow, DVC
- **Versioning:** Model version in API
- **A/B Testing:** Route % of traffic to new model

### Deployment Checklist

Pre-Deployment:
- [ ] All tests pass
- [ ] Code review approved
- [ ] Security scan passed
- [ ] Staging deployment successful
- [ ] Database backup completed
- [ ] Rollback plan ready
- [ ] Monitoring dashboards prepared
- [ ] On-call team notified

Deployment:
- [ ] Apply database migrations
- [ ] Deploy application
- [ ] Run smoke tests
- [ ] Monitor error rates
- [ ] Monitor latency
- [ ] Verify health checks

Post-Deployment:
- [ ] Verify functionality
- [ ] Check logs for errors
- [ ] Monitor resource usage
- [ ] Update runbooks if needed
- [ ] Document any issues

### Deliverables

- Deployment Scripts (deploy.sh, Kubernetes manifests)
- Infrastructure as Code (Terraform, Ansible playbooks)
- Rollback Procedures
- Deployment Runbooks
- Configuration Files

### Tools

**Orchestration:**
- Kubernetes (industry standard)
- Docker Swarm (simpler alternative)
- Nomad (HashiCorp)

**Infrastructure as Code:**
- Terraform (cloud provisioning)
- Ansible (configuration management)
- Pulumi (code-based IaC)

**Configuration:**
- Helm (Kubernetes package manager)
- Kustomize (Kubernetes config management)
- ConfigMaps, Secrets (Kubernetes)

**Secrets:**
- HashiCorp Vault
- AWS Secrets Manager, GCP Secret Manager
- Sealed Secrets (Kubernetes)

**Deployment:**
- ArgoCD (GitOps for Kubernetes)
- Flux (GitOps)
- Spinnaker (multi-cloud CD)

**Load Balancing:**
- Nginx, HAProxy (reverse proxy)
- Traefik (cloud-native)
- AWS ALB, GCP Load Balancer

**Barebox/Embedded:**
- Buildroot, Yocto (rootfs)
- SWUpdate (embedded software update)

---

## 14. Monitoring & Observability

**Expert Roles:**
- SRE (Site Reliability Engineers)
- Observability Engineers
- On-Call Engineers

### Activities

1. **Metrics Collection**
   - **Application Metrics:**
     - Request rate (requests/sec)
     - Error rate (errors/sec, %)
     - Latency (p50, p95, p99, p99.9)
     - Throughput (bytes/sec, records/sec)
   - **Infrastructure Metrics:**
     - CPU usage (%, per core)
     - Memory usage (RSS, heap)
     - Disk I/O (IOPS, throughput)
     - Network (bandwidth, packets)
   - **Business Metrics:**
     - User signups, conversions
     - Revenue metrics
   - **Kernel/System Metrics:**
     - Syscall rate, context switches
     - Page faults, interrupts
     - Load average

2. **Logging**
   - **Structured Logging:** JSON format
   - **Log Levels:** DEBUG, INFO, WARNING, ERROR, CRITICAL
   - **Correlation IDs:** Trace requests across services
   - **Log Aggregation:** Central log storage
   - **Log Retention:** 30 days (adjustable)
   - **Sensitive Data:** Never log secrets, PII

3. **Tracing**
   - **Distributed Tracing:** Trace requests across microservices
   - **eBPF Tracing:** Kernel-level tracing (syscalls, functions)
   - **APM:** Application Performance Monitoring
   - **Trace Sampling:** Sample % of traces (reduce overhead)

4. **Alerting**
   - **SLO-Based:** Alert on SLO violations (error budget)
   - **Symptom-Based:** Alert on user-facing issues, not internal
   - **Alert Fatigue:** Reduce false positives
   - **Escalation:** On-call rotation, escalation policy
   - **Alert Channels:** PagerDuty, Slack, email, SMS

5. **Dashboards**
   - **Real-Time:** Current system state
   - **SLA/SLO Tracking:** Availability, latency, error rate
   - **Business Metrics:** User activity, revenue
   - **Drill-Down:** From overview to detailed metrics

6. **SLI/SLO/SLA**
   - **SLI (Service Level Indicator):** Metric (latency, availability)
   - **SLO (Service Level Objective):** Target (99.9% availability)
   - **SLA (Service Level Agreement):** Contract with users
   - **Error Budget:** 1 - SLO (e.g., 0.1% downtime allowed)

### Observability Best Practices

- **Three Pillars:** Metrics, Logs, Traces
- **Cardinality:** Limit high-cardinality labels (user ID bad, endpoint good)
- **Retention:** Metrics (30d), Logs (30d), Traces (7d)
- **Sampling:** Trace sampling (1-10%), full error traces
- **Dashboards:** Start with Golden Signals (latency, traffic, errors, saturation)

### Domain-Specific Monitoring

**Kernel:**
- **Metrics:** /proc, /sys, perf events
- **Tracing:** Ftrace, eBPF (bpftrace, BCC tools)
- **Logging:** dmesg, journald
- **Tools:** sysstat, sar, iostat, vmstat

**eBPF:**
- **Overhead:** Measure BPF program overhead
- **Map Usage:** Monitor map memory usage
- **Tools:** bpftool (introspection)

**Django:**
- **Middleware:** Log requests, exceptions
- **ORM:** Query count, slow queries
- **Cache:** Hit rate, miss rate
- **Tools:** Django Debug Toolbar (dev), Silk (profiling)

**AI/ML:**
- **Model Metrics:** Accuracy, precision, recall
- **Inference:** Latency, throughput
- **Data Drift:** Input distribution changes
- **Model Drift:** Performance degradation
- **Tools:** Evidently AI, Arize, Seldon

### Deliverables

- Monitoring Dashboards (Grafana)
- Alert Rules (Prometheus, PagerDuty)
- SLO Definitions
- On-Call Runbooks
- Log Aggregation Setup

### Tools

**Metrics:**
- **Prometheus:** Time-series DB, pull-based
- **Grafana:** Visualization
- **StatsD:** Push-based metrics
- **InfluxDB:** Time-series DB

**Logging:**
- **ELK Stack:** Elasticsearch, Logstash, Kibana
- **Loki:** Grafana's log aggregation (like Prometheus for logs)
- **Fluentd, Fluent Bit:** Log forwarding
- **journald:** systemd logging

**Tracing:**
- **Jaeger:** Distributed tracing
- **Tempo:** Grafana's tracing
- **Zipkin:** Distributed tracing
- **OpenTelemetry:** Vendor-neutral instrumentation

**APM:**
- **Sentry:** Error tracking
- **New Relic, Datadog:** Full-stack observability (paid)

**Kernel/eBPF:**
- **bpftrace:** High-level eBPF tracing
- **BCC tools:** Pre-built eBPF tools (execsnoop, biolatency, etc.)
- **perf:** Linux profiler

**Alerting:**
- **PagerDuty, OpsGenie:** On-call management
- **Alertmanager:** Prometheus alerting
- **Slack, email:** Notification channels

---

## 15. Incident Response

**Expert Roles:**
- Incident Commanders
- SRE (Site Reliability Engineers)
- Security Incident Response Team (SIRT)
- On-Call Engineers

### Activities

1. **Incident Detection**
   - Monitoring alerts (Prometheus, PagerDuty)
   - User reports (support tickets)
   - Anomaly detection (outliers)
   - Security events (SIEM alerts)

2. **Incident Triage**
   - **Severity Assessment:**
     - SEV1/P1: Critical (all users down)
     - SEV2/P2: Major (degraded service)
     - SEV3/P3: Minor (isolated issues)
   - Assign incident commander
   - Assemble response team
   - Create incident channel (Slack)

3. **Incident Response**
   - **Assess:** Understand scope, impact
   - **Communicate:** Status page, stakeholders
   - **Mitigate:** Stop bleeding (rollback, scale up, disable feature)
   - **Resolve:** Fix root cause
   - **Verify:** Confirm resolution

4. **Communication**
   - **Internal:** Slack incident channel, status updates
   - **External:** Status page (statuspage.io), Twitter
   - **Stakeholders:** Email to executives, customers
   - **Frequency:** Update every 30min for SEV1

5. **Root Cause Analysis (RCA)**
   - Timeline reconstruction (what happened when)
   - Contributing factors (why did it happen)
   - Root cause (fundamental issue)
   - Five Whys technique

6. **Post-Mortem**
   - **Blameless:** Focus on system, not people
   - **Timeline:** Detailed event timeline
   - **Root Cause:** What went wrong
   - **Action Items:** Prevent recurrence
   - **What Went Well:** Positive aspects
   - **Share Learnings:** Publish post-mortem

7. **Security Incidents**
   - **Containment:** Isolate compromised systems
   - **Eradication:** Remove malware, close vulnerability
   - **Recovery:** Restore service
   - **Forensics:** Preserve evidence
   - **Disclosure:** Responsible disclosure (CVEs)

### Incident Response Workflow

1. **Alert Fires** → PagerDuty notifies on-call
2. **On-call Acknowledges** → Start timer
3. **Triage** → Assess severity
4. **Page Incident Commander** (if SEV1/SEV2)
5. **Create Incident Channel** (Slack #incident-YYYY-MM-DD)
6. **Assemble Team** → Page relevant experts
7. **Update Status Page** → "Investigating issue with..."
8. **Mitigate** → Rollback/hotfix/scale
9. **Resolve** → Fix root cause
10. **Verify** → Monitoring shows normal
11. **Communicate Resolution** → Status page, stakeholders
12. **Schedule Post-Mortem** → Within 48 hours

### Incident Severity Levels

**SEV1 / P1 (Critical):**
- Complete service outage
- Data loss or corruption
- Security breach
- Response time: <15 minutes
- Update frequency: Every 30 minutes

**SEV2 / P2 (Major):**
- Significant degradation (>50% users affected)
- Core feature broken
- Response time: <1 hour
- Update frequency: Every 2 hours

**SEV3 / P3 (Minor):**
- Minor feature broken
- Small % of users affected
- Response time: <4 hours
- Update frequency: Daily

### Post-Mortem Template

```markdown
# Incident Post-Mortem: [Brief Title]

**Date:** 2025-01-15
**Severity:** SEV1
**Duration:** 2 hours 15 minutes (14:00 - 16:15 UTC)
**Impact:** 100% of users unable to log in

## Summary
Brief (2-3 sentence) summary of what happened.

## Timeline (All times UTC)
- 14:00 - Deploy v1.2.0 to production
- 14:05 - Login error rate spikes to 100%
- 14:07 - PagerDuty alert fires
- 14:10 - On-call acknowledges, starts investigation
- 14:15 - Incident commander paged
- 14:20 - Rollback initiated
- 14:25 - Rollback complete, still broken
- 14:30 - Root cause identified: database migration issue
- 14:45 - Hotfix deployed
- 15:00 - Login error rate drops to 0%
- 16:15 - Incident resolved, monitoring confirms normal

## Root Cause
Database migration added NOT NULL column without default value,
causing all INSERT statements to fail.

## Contributing Factors
- Migration not tested on production-size dataset
- No automated rollback for failed migrations
- Insufficient monitoring on database errors

## Resolution
Deployed hotfix with ALTER TABLE to add default value.

## Action Items
- [ ] Add migration testing on staging with prod-size data (Owner: Alice, Due: 2025-01-20)
- [ ] Implement automated migration rollback (Owner: Bob, Due: 2025-02-01)
- [ ] Add database error monitoring (Owner: Charlie, Due: 2025-01-18)
- [ ] Update deployment checklist (Owner: Diana, Due: 2025-01-16)

## What Went Well
- Fast detection (5 minutes)
- Good communication (status page updated quickly)
- Team assembled quickly

## What Went Poorly
- Rollback didn't fix issue (migration already applied)
- Took 30 minutes to identify root cause

## Lessons Learned
- Always test migrations on production-size data
- Database migrations need separate rollback strategy
```

### Deliverables

- Incident Reports (per incident)
- Post-Mortem Documents (blameless)
- Action Items (for prevention)
- Updated Runbooks
- Process Improvements

### Tools

**Incident Management:**
- PagerDuty, OpsGenie (on-call, alerting)
- Slack, Microsoft Teams (communication)
- Zoom, Google Meet (war room)
- Statuspage.io, Atlassian Statuspage (status page)

**Documentation:**
- Confluence, Notion (post-mortems)
- Jira, Linear (action items)

**Security Incidents:**
- SIEM: Splunk, Wazuh, Elastic Security
- Forensics: Volatility, Autopsy, Wireshark

**Monitoring:**
- Prometheus, Grafana (see Monitoring section)

---

## 16. Maintenance

**Expert Roles:**
- Software Engineers
- Engineering Managers
- Tech Leads
- DevOps Engineers

### Activities

1. **Bug Fixing**
   - **Bug Triage:** Prioritize by severity, impact
   - **Reproduction:** Create minimal reproducer
   - **Root Cause:** Identify why bug exists
   - **Fix:** Implement fix (with test)
   - **Regression Test:** Ensure bug doesn't recur

2. **Technical Debt Management**
   - **Debt Identification:** Code smells, TODO comments, workarounds
   - **Debt Tracking:** Track in backlog (JIRA, Linear)
   - **Debt Prioritization:** Impact vs effort
   - **Refactoring:** Allocate time (20% rule)
   - **Deprecation:** Plan removal of legacy code

3. **Dependency Updates**
   - **Security Patches:** Apply immediately (CVEs)
   - **Minor Updates:** Quarterly (bug fixes, features)
   - **Major Updates:** Annually (breaking changes, careful testing)
   - **Compatibility Testing:** Ensure no regressions
   - **Automated:** Dependabot, Renovate

4. **Code Refactoring**
   - **Code Smells:** Long functions, deep nesting, duplication
   - **Design Patterns:** Apply where appropriate
   - **Performance:** Optimize hot paths
   - **Readability:** Improve naming, structure
   - **Test Coverage:** Maintain coverage during refactor

5. **Legacy Code**
   - **Documentation:** Document before changing
   - **Characterization Tests:** Cover existing behavior
   - **Strangler Fig Pattern:** Gradually replace
   - **Deprecation:** Announce, provide migration path, remove

### Domain-Specific Maintenance

**Kernel:**
- **Upstream Backporting:** Pull fixes from mainline to stable
- **LTS Maintenance:** Long-Term Support (years)
- **Stable Tree:** Maintain stable releases (v6.7.1, v6.7.2)
- **ABI Compatibility:** Never break kernel ABI

**eBPF:**
- **CO-RE Compatibility:** Ensure BTF compatibility
- **Verifier Changes:** Adapt to verifier updates

**Barebox:**
- **Board Support:** Maintain for new hardware revisions
- **Bootloader Updates:** Security fixes, boot time improvements

**Django:**
- **Django Updates:** Keep up with Django releases
- **Deprecation Warnings:** Fix before removal
- **Database Migrations:** Clean up old migrations (squash)

**AI/ML:**
- **Model Retraining:** Refresh with new data
- **Model Drift:** Monitor and retrain when performance degrades
- **Dependency Updates:** TensorFlow, PyTorch major updates

### Technical Debt Categories

1. **Code Debt:** Messy code, duplication, complexity
2. **Architecture Debt:** Wrong abstractions, tight coupling
3. **Test Debt:** Low coverage, flaky tests
4. **Documentation Debt:** Outdated docs, missing docs
5. **Infrastructure Debt:** Manual processes, legacy systems

### Bug Priority Matrix

|              | High Impact         | Low Impact          |
|--------------|---------------------|---------------------|
| **Frequent** | P1 - Fix immediately| P2 - Fix this sprint|
| **Rare**     | P3 - Fix next sprint| P4 - Backlog        |

### Deliverables

- Bug Fixes (with tests)
- Refactored Code
- Updated Dependencies
- Deprecation Notices
- Technical Debt Backlog

### Tools

**Issue Tracking:**
- Jira, Linear, GitHub Issues
- Bug tracking, sprint planning

**Dependency Management:**
- Dependabot (GitHub), Renovate (multi-platform)
- pip-audit, cargo-audit (vulnerability scanning)

**Refactoring:**
- IDE refactoring tools (PyCharm, VSCode)
- Coccinelle (kernel semantic patches)

**Code Quality:**
- SonarQube (tech debt tracking)
- CodeClimate (maintainability index)

---

## 17. Continuous Improvement

**Expert Roles:**
- Engineering Managers
- Staff Engineers
- Developer Experience Engineers
- Process Improvement Specialists

### Activities

1. **Retrospectives**
   - **Sprint Retrospectives:** Every 2 weeks
   - **Project Retrospectives:** After project completion
   - **Incident Retrospectives:** After incidents (post-mortems)
   - **Format:** What went well, what didn't, action items

2. **Knowledge Sharing**
   - **Tech Talks:** Weekly internal talks
   - **Lunch & Learns:** Informal learning sessions
   - **Documentation:** Internal wikis, how-tos
   - **Code Reviews:** Learning opportunity
   - **Pair Programming:** Knowledge transfer

3. **Tooling Improvement**
   - **Developer Productivity:** Faster CI, better IDE
   - **Automation:** Automate repetitive tasks
   - **Observability:** Better debugging tools
   - **Self-Service:** Developer platforms

4. **Process Optimization**
   - **Metrics:** Cycle time, lead time, deployment frequency
   - **Waste Reduction:** Eliminate non-value-adding steps
   - **Feedback Loops:** Faster feedback (CI, code review)
   - **Bottleneck Identification:** Theory of Constraints

5. **Training & Development**
   - **Onboarding:** New hire training program
   - **Skill Development:** Courses, conferences, books
   - **Certifications:** CKA (Kubernetes), OSCP (security)
   - **Career Growth:** IC track, management track

6. **Innovation**
   - **Hackathons:** Internal innovation time
   - **20% Time:** Explore new technologies
   - **Research:** Bleeding-edge tech (eBPF use cases, AI)
   - **Open Source:** Contribute upstream

### Metrics to Track (DORA Metrics)

1. **Deployment Frequency:** How often deploy to prod
2. **Lead Time for Changes:** Commit → production time
3. **Change Failure Rate:** % of deploys causing incidents
4. **Mean Time to Recovery (MTTR):** How fast recover from incidents

**Elite Performers:**
- Deploy: Multiple times per day
- Lead Time: <1 hour
- Change Failure: <15%
- MTTR: <1 hour

### Retrospective Format

**What Went Well:**
- List positive aspects
- Celebrate wins

**What Didn't Go Well:**
- List problems, frustrations
- No blame, focus on system

**Action Items:**
- Concrete improvements
- Owner assigned
- Due date set
- Follow up next retro

### Knowledge Sharing Formats

1. **Tech Talks:** 30-minute presentation on technical topic
2. **Lunch & Learn:** Informal, during lunch
3. **Book Club:** Read and discuss technical books
4. **Code Review:** Teaching moment
5. **Pair Programming:** Real-time knowledge transfer
6. **Mentorship:** 1-on-1 long-term pairing
7. **Internal Documentation:** Wiki, Confluence
8. **Conference Talks:** External sharing (visibility)

### Continuous Learning Culture

- **Psychological Safety:** Safe to ask questions, admit mistakes
- **Experimentation:** Safe to try new approaches
- **Blameless Culture:** Focus on systems, not people
- **Growth Mindset:** Skills can be developed
- **Documentation:** Write things down
- **Feedback:** Regular, constructive feedback

### Deliverables

- Retrospective Notes (action items)
- Internal Documentation (how-tos, wikis)
- Training Materials (onboarding, courses)
- Process Documentation (updated workflows)
- DORA Metrics Dashboard

### Tools

**Retrospectives:**
- Miro, Mural (virtual whiteboard)
- Confluence, Notion (documentation)

**Knowledge Sharing:**
- Confluence, Notion, Wiki
- Internal blogs
- Zoom, Google Meet (tech talks)

**Metrics:**
- Jira, Linear (cycle time, lead time)
- Grafana (deployment frequency)
- Prometheus (MTTR)

**Training:**
- Coursera, Udemy, Pluralsight (courses)
- O'Reilly Learning (books, videos)
- Internal training platform

---

## Domain-Specific Best Practices

### Linux Kernel Development

**Workflow:**
1. Upstream first (submit to mainline)
2. Mailing list workflow (LKML, subsystem lists)
3. Patch series format (git format-patch)
4. Detailed commit messages (explain "why")
5. Coding style (scripts/checkpatch.pl)

**Testing:**
- kselftests (in-tree tests)
- Linux Test Project (LTP)
- Syzkaller (fuzzing)
- Boot on real hardware

**Review:**
- Gerrit, mailing list
- Maintainer review required
- Sign-offs (Signed-off-by)

**Security:**
- CVE assignment for vulnerabilities
- Security mailing list (security@kernel.org)
- Stable tree backports

### eBPF Development

**Workflow:**
1. Use CO-RE (Compile Once, Run Everywhere)
2. libbpf for userspace loader
3. BTF (BPF Type Format) for portability

**Testing:**
- BPF selftests
- Verifier testing (invalid programs rejected)
- Userspace unit tests

**Performance:**
- Minimize overhead (<5%)
- Use efficient map types
- Avoid unbounded loops

**Security:**
- Verifier ensures safety
- CAP_BPF capability (unprivileged eBPF disabled by default)

### Barebox/Embedded

**Workflow:**
1. Device tree for board description
2. Board-specific code in arch/
3. Size optimization (binary size critical)

**Testing:**
- QEMU testing (automated)
- Real hardware testing (required)
- Boot time measurement

**Deployment:**
- Flash update (SPI, eMMC, SD)
- A/B partitions (failsafe)

### Django Development

**Workflow:**
1. Use Django ORM (avoid raw SQL)
2. Migrations for schema changes
3. Admin for internal tools

**Testing:**
- django.test.TestCase (transactional)
- pytest-django (fixtures)
- Factory Boy (test data)

**Performance:**
- select_related, prefetch_related (avoid N+1)
- Database indexing
- Redis caching
- CDN for static files

**Security:**
- OWASP Top 10 compliance
- CSRF, XSS, SQL injection prevention
- Django security middleware
- HTTPS (SECURE_SSL_REDIRECT)

### AI/ML Development

**Workflow:**
1. Data versioning (DVC)
2. Experiment tracking (MLflow, Weights & Biases)
3. Model registry (MLflow)

**Testing:**
- Unit tests for data processing
- Model evaluation (accuracy, F1, etc.)
- A/B testing (production)

**Performance:**
- Model optimization (quantization, pruning)
- Inference optimization (batching, caching)
- GPU utilization

**Monitoring:**
- Model drift detection
- Data drift detection
- Inference latency monitoring

---

## Quick Reference

### Essential Tools by Phase

| Phase | Essential Tools |
|-------|----------------|
| Planning | Jira, Confluence, Draw.io |
| Design | PlantUML, OpenAPI, DbDiagram |
| TDD | pytest, Git, pre-commit |
| Static Analysis | SonarQube, Sparse (kernel), Bandit (Python) |
| Code Review | GitHub PR, Gerrit (kernel) |
| Testing | pytest, kselftests, Playwright, Syzkaller |
| Profiling | perf, bpftrace, py-spy, Flamegraph |
| Security | Semgrep, OWASP ZAP, Syzkaller, Snyk |
| Documentation | Sphinx, MkDocs, OpenAPI, Mermaid |
| Release | git-cliff, GPG, Docker, PyPI |
| CI/CD | GitHub Actions, GitLab CI, Jenkins |
| Deployment | Kubernetes, Terraform, Ansible |
| Monitoring | Prometheus, Grafana, Loki, Jaeger |
| Incidents | PagerDuty, Statuspage, Confluence |
| Maintenance | Dependabot, SonarQube, JIRA |
| Improvement | Retrospectives, DORA metrics, Confluence |

### Commit Prefixes (Conventional Commits)

- `feat:` New feature
- `fix:` Bug fix
- `refactor:` Code refactoring (no functional change)
- `perf:` Performance improvement
- `test:` Add or update tests
- `doc:` Documentation
- `build:` Build system, dependencies
- `ci:` CI/CD changes
- `chore:` Miscellaneous (no prod code change)

### Code Coverage Targets

- Unit Tests: >80%
- Integration Tests: >60%
- Critical Paths: 100%

### Performance Targets

- API Latency: p95 < 200ms, p99 < 500ms
- Page Load: <2 seconds
- Time to First Byte (TTFB): <100ms
- Boot Time (embedded): <5 seconds

### Security Checklist

- [ ] All input validated
- [ ] No SQL injection (parameterized queries)
- [ ] No XSS (output encoding)
- [ ] HTTPS enforced
- [ ] Secrets not hardcoded (use env vars)
- [ ] Dependencies scanned (no CVEs)
- [ ] Authentication required
- [ ] Authorization checked
- [ ] Logging (no sensitive data)
- [ ] Error handling (no info disclosure)

---

## Related Documents

- [ROADMAP.md](ROADMAP.md) - 30-year hiring and scaling roadmap
- [CONTRIBUTING.md](CONTRIBUTING.md) - Contribution guidelines
- [custom_subagents.md](custom_subagents.md) - Custom Claude Code subagents

---

**Last Updated:** 2025-01-15
**Version:** 1.0.0
