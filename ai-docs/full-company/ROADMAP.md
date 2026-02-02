# 30-Year Software Engineering Hiring & Scaling Roadmap

> Strategic hiring plan for building world-class engineering org from startup to industry leader

## Overview

This roadmap outlines a systematic 30-year strategy for building and scaling an engineering organization focused on low-level systems (Linux kernel, eBPF, Barebox), web development (Django), AI/ML, and security. It maps each SDLC phase to specific roles, defining what expertise to hire at each stage of growth.

---

## Table of Contents

1. [Phase 1: Foundation (Years 0-5)](#phase-1-foundation-years-0-5)
2. [Phase 2: Growth (Years 5-10)](#phase-2-growth-years-5-10)
3. [Phase 3: Maturity (Years 10-20)](#phase-3-maturity-years-10-20)
4. [Phase 4: Innovation Leadership (Years 20-30)](#phase-4-innovation-leadership-years-20-30)
5. [Role Taxonomy](#role-taxonomy)
6. [Team Structure Evolution](#team-structure-evolution)
7. [Compensation Strategy](#compensation-strategy)

---

## Phase 1: Foundation (Years 0-5)

**Company Stage:** Startup → Product-Market Fit
**Team Size:** 5-20 engineers
**Revenue:** $0-10M ARR
**Focus:** Ship fast, validate product, build foundations

### Hiring Priority (Order Matters)

#### Year 0-1: Core Team (5 engineers)

**Hire Order:**

1. **Technical Co-Founder / CTO** (Month 0)
   - Full-stack, strong in primary domain (kernel OR web)
   - Sets technical direction
   - First engineer, does everything
   - Ideal: kernel background + startup experience

2. **Senior Backend Engineer (Kernel/Systems)** (Month 3-6)
   - If kernel-focused: deep Linux kernel experience
   - If web-focused: skip, hire web engineer instead
   - C programming expert
   - 5+ years systems programming

3. **Senior Backend Engineer (Python/Django)** (Month 3-6)
   - Django expert if web-focused company
   - Can build APIs, databases, admin tools
   - 5+ years Python/Django

4. **Full-Stack Engineer** (Month 6-9)
   - Generalist, can do backend + frontend
   - Reduces dependencies
   - 3-5 years experience

5. **DevOps/SRE Generalist** (Month 9-12)
   - Sets up CI/CD, cloud infrastructure
   - On-call setup, monitoring
   - Wears many hats
   - 3+ years

#### Year 1-2: First Expansion (10 engineers)

**Additional Hires:**

6. **Senior Kernel Engineer** (if applicable)
   - eBPF specialist OR driver developer OR arch-specific
   - Upstream contribution experience
   - 7+ years kernel

7. **Backend Engineer (Mid-level)** (Django/Python)
   - API development
   - 3-5 years experience

8. **QA Engineer / SDET**
   - First QA hire
   - Automation-focused (pytest, Selenium/Playwright)
   - Builds test framework
   - 3+ years

9. **Frontend Engineer** (if web-focused)
   - React/Vue expert
   - Can build UI from scratch
   - 3-5 years

10. **Security Engineer (Part-time/Contractor)**
    - Penetration testing, security reviews
    - Can be contractor initially
    - Kernel security OR web security based on focus

#### Year 2-3: Specialists (15 engineers)

**Additional Hires:**

11. **Engineering Manager** (First Manager)
    - Manages 5-7 engineers
    - IC background in your domain
    - 3+ years management

12. **Performance Engineer**
    - eBPF expert, profiling, optimization
    - 5+ years low-level performance

13. **Backend Engineer (Mid-level)** (another one)
    - Scale backend team to 4-5 engineers

14. **Site Reliability Engineer (SRE)**
    - Dedicated SRE, not DevOps generalist
    - Monitoring, alerting, incident response
    - 3+ years

15. **Technical Writer (Part-time initially)**
    - Documentation, API docs
    - Can be contractor initially

#### Year 3-5: Scaling Foundations (20 engineers)

**Additional Hires:**

16. **Staff Engineer (Principal IC track)**
    - Technical leadership, architecture
    - Kernel OR web depending on focus
    - 10+ years, proven impact

17. **Senior QA Engineer / QA Lead**
    - Leads QA function
    - 5+ years, test strategy

18. **Backend Engineers (2x Junior-Mid)**
    - Growing backend team
    - 1-4 years experience
    - Mentorship from seniors

19. **AI/ML Engineer** (if AI-focused)
    - PyTorch/TensorFlow
    - Model training, deployment
    - 3+ years ML

20. **Engineering Manager #2**
    - Second manager as team grows
    - 3+ years management

### Process Maturity (Years 0-5)

**Year 0-1:**
- Basic Git workflow (feature branches)
- CI/CD setup (GitHub Actions, GitLab CI)
- Manual deployment
- Basic monitoring (Prometheus, Grafana basics)
- Code review on PRs

**Year 1-3:**
- Automated testing (>60% coverage)
- Automated deployment to staging
- On-call rotation starts
- Incident response process
- Weekly standups, sprint planning

**Year 3-5:**
- TDD culture starts
- Automated deployment to production
- SLOs defined
- Post-mortems for incidents
- Security scanning in CI
- Performance benchmarks

### Key Milestones

- **Month 0-6:** First prototype, alpha users
- **Month 6-12:** Beta launch, early customers
- **Year 1-2:** Product-market fit, $1M ARR
- **Year 2-3:** Scaling product, $5M ARR
- **Year 3-5:** Multiple products/features, $10M ARR

---

## Phase 2: Growth (Years 5-10)

**Company Stage:** Growth → Scale-Up
**Team Size:** 20-100 engineers
**Revenue:** $10M-50M ARR
**Focus:** Scale product, enter new markets, quality

### Organizational Structure (Year 5)

```
CTO
├── VP Engineering (hire Year 5-6)
│   ├── Kernel Team (8-10 engineers)
│   │   ├── EM: Kernel
│   │   ├── Staff Engineer: Kernel Architecture
│   │   └── Engineers: Senior (4), Mid (3), Junior (2)
│   ├── Backend Team (Django, 10-12 engineers)
│   │   ├── EM: Backend
│   │   ├── Staff Engineer: Backend Architecture
│   │   └── Engineers: Senior (5), Mid (4), Junior (3)
│   ├── Platform Team (5-7 engineers)
│   │   ├── EM: Platform
│   │   └── SRE, DevOps, Infrastructure
│   └── QA Team (5-7 engineers)
│       ├── QA Lead
│       └── QA Engineers, SDET
├── Director of Security (hire Year 6-7)
│   └── Security Engineers (3-5)
└── Director of Engineering (Infrastructure, hire Year 7-8)
    └── SRE, Platform Engineers (10+)
```

### Hiring Priority (Years 5-10)

#### Leadership (Hire Early)

**Year 5-6:**
- **VP Engineering** (critical hire)
  - Manages managers
  - Sets engineering strategy
  - 10+ years, 3+ years leading teams >20
  - Scaled startups before

**Year 6-7:**
- **Director of Security**
  - Builds security org
  - 8+ years security, 3+ years management

- **Director of Infrastructure / SRE**
  - Builds SRE org
  - 8+ years, 3+ management

**Year 7-8:**
- **Director of Product Engineering** (if multiple products)
  - Owns product engineering
  - 8+ years, 3+ management

#### Specialists & ICs (Years 5-10)

**Kernel/Low-Level (if kernel-focused):**
- Senior Kernel Engineers (3-5 more)
- eBPF Specialists (2-3)
- Kernel Security Engineer (1-2)
- Performance Engineers (2-3, eBPF tracing experts)
- Embedded Engineers (Barebox) (2-3)
- Device Driver Engineers (2-4)

**Backend/Web (if web-focused):**
- Senior Backend Engineers (5-10 more)
- Database Engineers (PostgreSQL experts) (2-3)
- API Architects (2)
- Django Security Engineers (1-2)

**Platform & SRE:**
- SREs (5-10 total)
- DevOps Engineers (3-5)
- Build Engineers / Release Engineers (2-3)
- Infrastructure Engineers (Cloud, K8s) (3-5)

**Quality:**
- Senior QA Engineers (3-5)
- Security QA / Penetration Testers (2)
- Performance QA Engineers (2)
- Test Automation Engineers (3-5)

**Security:**
- Security Engineers (5 total)
  - Application Security (2)
  - Infrastructure Security (1)
  - Security Researcher / Penetration Tester (2)
- Security Architect (1, Year 8-9)

**Frontend (if web-focused):**
- Senior Frontend Engineers (3-5)
- Frontend Lead (1)
- UI/UX Engineers (2-3)

**AI/ML (if AI-focused):**
- ML Engineers (5-8)
- ML Ops Engineers (2)
- Data Engineers (3-4)
- AI Research Scientists (1-2, PhD preferred)

**Developer Experience:**
- Developer Experience Engineers (2-3)
  - Build tooling, IDE plugins, dev productivity

**Documentation & DevRel:**
- Technical Writers (3-4, 2 full-time by Year 7)
- Developer Advocates (1-2, Year 8+)

**Engineering Managers:**
- Engineering Managers (total: 8-12)
  - Each managing 6-8 engineers
  - Mix of technical EMs (70%) and people-focused EMs (30%)

**Principal / Staff Engineers:**
- Staff Engineers (5-8 total across teams)
- Principal Engineers (1-2, Year 8-10)
  - 15+ years experience
  - Technical strategy, architecture

### Process Maturity (Years 5-10)

**Year 5-7:**
- Architecture review board (ARB)
- Design docs required for major features
- TDD enforced (>70% coverage minimum)
- Security scanning mandatory in CI
- Automated performance benchmarks
- Chaos engineering starts (resilience testing)
- Formalized on-call runbooks

**Year 7-10:**
- SOC2 compliance (if enterprise customers)
- Formal security audits (quarterly)
- Penetration testing (bi-annual)
- Bug bounty program
- Internal tech talks (weekly)
- Formal incident management (SEV levels)
- DORA metrics tracked
- Engineering metrics dashboard

### Key Milestones

- **Year 5-6:** Multi-product company, international expansion, $20M ARR
- **Year 6-8:** Enterprise customers, compliance (SOC2), $30M ARR
- **Year 8-10:** Industry recognition, $50M ARR, IPO prep or profitability

---

## Phase 3: Maturity (Years 10-20)

**Company Stage:** Mature → Enterprise
**Team Size:** 100-500 engineers
**Revenue:** $50M-500M ARR
**Focus:** Enterprise, compliance, multiple product lines, innovation

### Organizational Structure (Year 10)

```
CTO
├── SVP Engineering
│   ├── VP Kernel Engineering (30+ engineers)
│   │   ├── Director: Core Kernel
│   │   ├── Director: eBPF
│   │   ├── Director: Embedded (Barebox)
│   │   └── Director: Kernel Security
│   ├── VP Backend Engineering (40+ engineers)
│   │   ├── Director: Platform APIs
│   │   ├── Director: Data Platform
│   │   └── Director: Backend Services
│   ├── VP Frontend Engineering (30+ engineers)
│   │   ├── Director: Web Frontend
│   │   └── Director: Mobile (if applicable)
│   ├── VP Infrastructure & SRE (40+ engineers)
│   │   ├── Director: SRE
│   │   ├── Director: Cloud Infrastructure
│   │   └── Director: Platform Engineering
│   ├── VP Quality Engineering (20+ engineers)
│   │   ├── Director: QA
│   │   ├── Director: Test Automation
│   │   └── Director: Performance QA
│   └── VP AI/ML (if AI-focused, 30+ engineers)
│       ├── Director: ML Platform
│       ├── Director: AI Research
│       └── Director: ML Ops
├── VP Security (20+ engineers)
│   ├── Director: Application Security
│   ├── Director: Infrastructure Security
│   ├── Director: Security Operations (SOC)
│   └── CISO (Chief Information Security Officer, Year 12+)
├── VP Developer Experience (15+ engineers)
│   ├── Director: DevEx & Tooling
│   └── Director: Build & Release
├── VP Architecture (10+ architects)
│   ├── Chief Architect (Enterprise Architecture)
│   ├── Principal Engineers (5-8)
│   └── Staff Engineers (cross-team)
└── VP Engineering Operations
    ├── Director: Engineering Programs (PMO)
    ├── Director: Recruiting (Technical)
    └── Director: Learning & Development
```

### Hiring Priority (Years 10-20)

#### Executive Leadership (C-level, VP-level)

**Year 10-12:**
- **SVP Engineering** (if VP Eng promoted to CTO role)
- **CISO** (Chief Information Security Officer)
- **VP Developer Experience**
- **VP Architecture** (Distinguished Engineers path)

**Year 12-15:**
- **Chief Architect**
- **VP Product Engineering** (if separate from SVP)

**Year 15-20:**
- **CTO reports to CEO** (if not already)
- **VP Research & Innovation**
- **VP Open Source Program Office (OSPO)**

#### Deep Specialists (Years 10-20)

**Kernel & Systems:**
- Kernel maintainers (upstream subsystem maintainers) (3-5)
- Kernel architects (10-15 senior/staff)
- eBPF core contributors (5-8)
- Performance architects (5-7)
- Embedded systems architects (3-5)
- Hardware bring-up engineers (3-5)

**Security (20-40 engineers by Year 20):**
- Security architects (3-5)
- Cryptography experts (2-3)
- Security researchers (5-8)
- Threat intelligence analysts (2-3)
- Security operations engineers (SOC) (5-10)
- Compliance engineers (SOC2, ISO, GDPR, HIPAA) (3-5)
- Penetration testers (full-time, 3-5)

**SRE & Infrastructure (40-80 engineers by Year 20):**
- SRE teams per product/region (6-8 per team)
- Cloud architects (multi-cloud strategy) (3-5)
- Kubernetes platform engineers (8-12)
- Observability engineers (dedicated team, 5-8)
- Chaos engineering team (3-5)
- Disaster recovery specialists (2-3)

**Quality (20-40 engineers):**
- QA engineers (distributed across product teams)
- Test architects (2-3)
- Performance QA engineers (5-8)
- Security QA engineers (3-5)
- Compliance QA (regulatory testing) (2-3)

**AI/ML (if applicable, 30-100 engineers):**
- ML researchers (PhDs) (5-10)
- ML engineers (30-50)
- ML platform engineers (10-15)
- Data engineers (15-20)
- AI ethics & fairness team (2-4)

**Research & Innovation (Years 15-20):**
- Research scientists (10-15, PhDs preferred)
- Innovation lab engineers (5-10)
- Emerging tech team (eBPF new use cases, kernel features) (5-8)

**Developer Relations & Community (Years 12-20):**
- Developer advocates (10-15)
- Technical evangelists (5-8)
- Community managers (3-5)
- Conference speakers (internal program)

**Engineering Productivity (Years 10-20):**
- Developer experience engineers (15-25)
- Build & release engineers (10-15)
- IDE/tooling engineers (5-8)
- Internal platform engineers (10-15)

#### Management Layer (Years 10-20)

By Year 20, management structure:
- **Directors:** 20-30 (each managing 2-4 teams)
- **Engineering Managers:** 50-70 (each managing 6-8 ICs)
- **Staff Engineers:** 30-50 (technical leadership, no reports)
- **Principal Engineers:** 10-15 (cross-org influence)
- **Distinguished Engineers / Fellows:** 2-5 (company-wide technical strategy)

### Process Maturity (Years 10-20)

**Year 10-12:**
- SOC2 Type II certified
- ISO 27001 certified
- Formal architecture review process (ADRs mandatory)
- Internal engineering blog (public)
- Open source contributions formalized (OSPO)
- Inner source programs (cross-team collaboration)
- Formal mentorship programs
- Engineering career ladder (IC track, management track)

**Year 12-15:**
- ISO 9001 (if applicable, quality management)
- Compliance: GDPR, HIPAA, PCI-DSS (if applicable)
- Formal security training (all engineers)
- Secure SDLC mandatory
- Code ownership model (CODEOWNERS)
- SLA commitments to enterprise customers (99.9%+)

**Year 15-20:**
- Industry-leading engineering blog
- Engineering thought leadership (conference keynotes)
- Open source project maintainers (kernel, eBPF, Django)
- Academic partnerships (research collaborations)
- Patents filed (kernel optimizations, eBPF innovations)
- Engineering excellence awards (internal, external)
- Diverse & inclusive hiring (50% URG goal)

### Key Milestones

- **Year 10-12:** Enterprise dominance, global presence, $100M ARR
- **Year 12-15:** IPO or major acquisition, $250M ARR
- **Year 15-20:** Industry leader, thought leadership, $500M ARR

---

## Phase 4: Innovation Leadership (Years 20-30)

**Company Stage:** Industry Leader
**Team Size:** 500-1500+ engineers
**Revenue:** $500M-$1B+ ARR
**Focus:** Innovation, research, industry influence, open source leadership

### Organizational Structure (Year 20+)

```
CTO / Chief Technology Officer
├── CIO (Chief Innovation Officer, Year 22+)
│   ├── VP Research
│   │   └── Research labs (kernel, eBPF, AI, security)
│   ├── VP Open Source Program Office (OSPO)
│   │   └── Upstream maintainers, community
│   └── VP Emerging Technologies
│       └── Exploration teams (new tech)
├── SVP Engineering (Product Engineering)
│   ├── Multiple VPs per product line (3-5 products)
│   │   └── Directors → EMs → ICs
│   └── Org per product (30-100 engineers each)
├── SVP Infrastructure & Platform
│   ├── VP SRE (global SRE org)
│   ├── VP Cloud Infrastructure
│   ├── VP Internal Platform (developer platform)
│   └── VP Data Platform
├── SVP Security & Compliance
│   ├── CISO
│   ├── VP Application Security
│   ├── VP Infrastructure Security
│   ├── VP Security Research
│   └── VP Compliance & Risk
├── SVP Quality & Performance
│   ├── VP Quality Engineering
│   └── VP Performance Engineering
├── SVP AI & Machine Learning (if AI-focused)
│   ├── VP AI Research
│   ├── VP AI Products
│   └── VP ML Platform
├── SVP Developer Experience
│   ├── VP DevEx & Tooling
│   ├── VP Developer Relations
│   └── VP Engineering Enablement
└── SVP Engineering Operations
    ├── VP Engineering Programs
    ├── VP Talent & Recruiting
    └── VP Learning & Development
```

### Hiring Strategy (Years 20-30)

#### Leadership Hires

**Year 20-25:**
- **CIO (Chief Innovation Officer)**
  - Drives innovation strategy
  - Research partnerships
  - 15+ years, visionary

- **Chief Architect** (if not already)
  - Company-wide technical strategy

- **VP Open Source Program Office (OSPO)**
  - Leads open source strategy
  - Kernel maintainer relationships
  - 12+ years open source

**Year 25-30:**
- **Distinguished Engineers / Technical Fellows** (5-10 total)
  - Company-wide technical authority
  - External thought leaders
  - 20+ years, recognized experts

- **VP Developer Relations** (separate from DevEx)
  - External developer community
  - Conferences, evangelism

#### Specialist Teams (Years 20-30)

**Research & Innovation (50-100 engineers):**
- Research scientists (PhDs, published) (20-30)
- Innovation engineers (15-25)
- Patent attorneys (technical background) (3-5)
- Standards committee representatives (IEEE, IETF) (5-8)

**Open Source Leadership (30-50 engineers):**
- Kernel subsystem maintainers (5-10)
  - mm (memory management)
  - sched (scheduler)
  - bpf (eBPF subsystem)
  - drivers
- eBPF core contributors (5-10)
- Django core contributors (if web-focused) (3-5)
- Open source community managers (5-8)

**Security (50-100 engineers):**
- Security research lab (10-15)
- Offensive security (red team) (8-12)
- Defensive security (blue team) (12-18)
- Threat intelligence (5-8)
- Security architecture (5-8)
- Compliance (regulatory, global) (10-15)

**AI/ML (if applicable, 100-300 engineers):**
- AI research lab (25-50, PhDs)
- ML platform (50-80)
- AI products (50-100)
- AI ethics & responsible AI (10-15)

**Global SRE (100-200 engineers):**
- Regional SRE teams (Americas, EMEA, APAC)
- Follow-the-sun on-call
- SRE embedded in product teams

**Engineering Productivity (50-100 engineers):**
- Internal platform team (25-40)
- Developer tooling (15-25)
- Build & release (10-15)
- Engineering analytics (5-10)

**Engineering Programs (20-40):**
- Engineering program managers (EPMs) (15-25)
- Technical project managers (10-15)

### Innovation Focus (Years 20-30)

**Research Areas:**
- Next-gen eBPF use cases (networking, security, observability)
- Kernel performance innovations (microsecond latency)
- AI-assisted kernel development (AI code review, bug detection)
- Secure enclaves, trusted execution (TEE, SGX)
- Quantum-resistant cryptography
- Edge computing, IoT (Barebox evolution)
- Zero-trust security architectures

**Industry Influence:**
- Linux kernel top contributors (company)
- eBPF steering committee members (company)
- Conference keynotes (Linux Plumbers, KubeCon, FOSDEM)
- Academic papers published (kernel optimizations, eBPF innovations)
- Patents filed (20-50 patents)

### Process Maturity (Years 20-30)

**Year 20-25:**
- Formal innovation labs (20% time for research)
- Internal tech conferences (annual, all-hands)
- Engineering fellows program (technical ladder pinnacle)
- Global engineering centers (US, Europe, Asia)
- Acquisitions of startups (M&A integration team)

**Year 25-30:**
- Industry-standard certifications created (company creates standards)
- Open source foundations led by company (CNCF, Linux Foundation)
- Engineering university partnerships (research labs at universities)
- Spin-off startups from innovation labs
- Engineering DEI goals achieved (representative workforce)

### Key Milestones

- **Year 20-25:** Top 10 kernel contributor company, eBPF thought leader, $750M ARR
- **Year 25-30:** Industry-defining company, open source champion, $1B+ ARR

---

## Role Taxonomy

Complete list of all roles across 30 years.

### Individual Contributors (IC Track)

**Junior Level (0-2 years):**
- Junior Software Engineer (Backend, Frontend, Embedded)
- Associate QA Engineer
- Junior DevOps Engineer

**Mid Level (2-5 years):**
- Software Engineer (Backend, Frontend, Kernel, Embedded)
- QA Engineer / SDET
- DevOps Engineer
- SRE
- Security Engineer
- ML Engineer

**Senior Level (5-8 years):**
- Senior Software Engineer (specializations)
- Senior Kernel Engineer
- Senior eBPF Engineer
- Senior QA Engineer / QA Lead
- Senior SRE
- Senior Security Engineer
- Senior ML Engineer
- Performance Engineer
- Database Engineer
- Build/Release Engineer

**Staff Level (8-12 years):**
- Staff Software Engineer
- Staff Kernel Engineer
- Staff Security Engineer
- Staff SRE
- Staff ML Engineer
- Performance Architect

**Principal Level (12-15 years):**
- Principal Engineer (cross-team technical leadership)
- Principal Architect
- Principal Security Engineer
- Principal SRE

**Distinguished Level (15-20+ years):**
- Distinguished Engineer
- Technical Fellow
- Chief Architect

### Management Track

**First-Line Managers (3+ years IC):**
- Engineering Manager (EM)
  - Manages 6-8 ICs
  - 1:1s, performance reviews, hiring

**Second-Line Managers (3+ years management):**
- Senior Engineering Manager
  - Manages 2-3 teams (12-24 ICs via EMs)
- Director of Engineering
  - Manages 3-5 teams (20-40 ICs via EMs)

**Executive Managers (5+ years management):**
- Senior Director
- VP Engineering (multiple orgs, 50-200 engineers)
- SVP Engineering (entire engineering org, 200-1000 engineers)

**C-Suite:**
- CTO (Chief Technology Officer)
- CISO (Chief Information Security Officer)
- CIO (Chief Innovation Officer)

### Specialized Roles

**Architecture:**
- Solutions Architect
- Security Architect
- Performance Architect
- Data Architect
- Cloud Architect
- Chief Architect

**Enablement:**
- Developer Experience Engineer
- Developer Advocate
- Technical Writer
- Technical Evangelist
- Community Manager

**Program Management:**
- Engineering Program Manager (EPM)
- Technical Project Manager (TPM)
- Release Manager

**Research:**
- Research Scientist (PhD preferred)
- Research Engineer

**Operations:**
- Engineering Recruiter (Technical)
- Engineering Operations Manager
- Learning & Development Manager

---

## Team Structure Evolution

### Startup Phase (Years 0-5): Flat Hierarchy

```
CTO
└── All Engineers (direct reports, <20)
```

**Characteristics:**
- Everyone reports to CTO
- No middle management
- High autonomy
- Fast decisions

### Growth Phase (Years 5-10): Team Leads

```
CTO / VP Engineering
├── EM: Kernel (6-8 ICs)
├── EM: Backend (6-8 ICs)
├── EM: Platform (6-8 ICs)
├── QA Lead (4-6 ICs)
└── Security Lead (3-5 ICs)
```

**Characteristics:**
- First-line managers (EMs)
- Teams by function or product
- Manager:IC ratio ~1:7
- Managers still code (50% time)

### Maturity Phase (Years 10-20): Directors

```
CTO → SVP Eng
├── VP Kernel Engineering
│   ├── Director: Core Kernel
│   │   ├── EM: Scheduler (6-8)
│   │   ├── EM: Memory Mgmt (6-8)
│   │   └── EM: Networking (6-8)
│   └── Director: eBPF
│       ├── EM: eBPF Core (6-8)
│       └── EM: eBPF Tools (6-8)
└── VP Backend Engineering
    ├── Director: APIs
    │   ├── EM: Public APIs (6-8)
    │   └── EM: Internal APIs (6-8)
    └── Director: Data Platform
        └── EM: Data Infra (6-8)
```

**Characteristics:**
- Directors (2nd line managers)
- VPs (3rd line)
- Manager:IC ratio ~1:6-8 at each level
- Managers rarely code (<20% time)

### Leadership Phase (Years 20-30): SVPs, Multi-Level Hierarchy

```
CEO
└── CTO
    ├── CIO (Innovation)
    ├── SVP Engineering (Product)
    │   └── VPs → Directors → EMs → ICs
    ├── SVP Infrastructure
    │   └── VPs → Directors → EMs → ICs
    ├── SVP Security (CISO)
    │   └── VPs → Directors → EMs → ICs
    └── SVP AI/ML (if applicable)
        └── VPs → Directors → EMs → ICs
```

**Characteristics:**
- 4-5 levels of management
- Clear separation: strategy (VPs), execution (Directors/EMs)
- Dedicated staff functions (recruiting, programs, L&D)

---

## Compensation Strategy

### Philosophy

- **Market Rate + Equity:** Pay at or above market (75th percentile)
- **IC Parity:** Staff/Principal ICs earn same as Directors/VPs
- **Transparency:** Bands published internally
- **Location Flexibility:** Remote-friendly, location-based pay or location-agnostic

### Compensation Bands (Rough % of Base)

| Level | Base (Index) | Equity (% of base) | Bonus (% of base) |
|-------|--------------|-------------------|------------------|
| Junior (L3) | 100% | 10-20% | 5-10% |
| Mid (L4) | 130% | 15-25% | 10-15% |
| Senior (L5) | 170% | 20-30% | 10-15% |
| Staff (L6) | 210% | 25-40% | 15-20% |
| Principal (L7) | 250% | 30-50% | 20-25% |
| Distinguished (L8) | 300%+ | 40-60% | 25-30% |
| EM | ~150-180% | 20-30% | 15-20% |
| Director | ~200-230% | 30-40% | 20-25% |
| VP | ~250-300% | 40-60% | 25-35% |
| SVP | ~350-450% | 50-80% | 30-40% |
| CTO/CISO | ~500-700% | 80-150% | 40-60% |

**Notes:**
- Index = Junior base (e.g., Junior at $100k, Senior at $170k)
- Equity vests over 4 years (1-year cliff)
- Bonuses based on company performance + individual

### Benefits (All Levels)

- Health insurance (100% employee, 80% family)
- 401k match (6%)
- Unlimited PTO (minimum 3 weeks encouraged)
- Learning budget ($2k/year)
- Conference budget ($5k/year for speakers)
- Home office stipend ($2k one-time)
- Sabbatical (every 5 years, 4-week paid)

---

## Hiring Principles

1. **Hire for Potential, Train for Skills:** Junior hires (20-30%), grow internally
2. **Diversity & Inclusion:** 50% URG (underrepresented groups) by Year 20
3. **Bar Raisers:** Every hire should raise the bar
4. **Referrals:** 50% of hires from referrals (incentivize)
5. **Upstream Contributors:** Prefer kernel/Django/OSS contributors
6. **Remote-Friendly:** Remote or hybrid (office optional)
7. **No Assholes:** Culture fit (collaborative, humble, curious)
8. **Write Code Test:** All ICs write code during interview (no whiteboard algorithms)
9. **Sponsor PhD Interns:** Research partnerships, PhD interns → full-time pipeline
10. **Apprenticeships:** Junior engineers paired with seniors (6-month program)

---

## Career Development

### IC Track (Individual Contributor)

**Junior → Mid (2 years):**
- Mentorship from senior
- Complete 2-3 features independently
- Code review participation

**Mid → Senior (3 years):**
- Mentor juniors
- Lead feature development
- On-call rotation
- Technical design docs

**Senior → Staff (4 years):**
- Technical leadership (influence multiple teams)
- Architecture proposals
- Interviewer (bar raiser)
- Mentor seniors

**Staff → Principal (4-5 years):**
- Cross-org influence
- Company-wide technical strategy
- External thought leadership (talks, blog posts)

**Principal → Distinguished (5-7 years):**
- Industry-wide recognition
- Company-defining technical decisions
- Keynotes, publications

### Management Track

**IC → EM (after 5+ years IC):**
- Manage 6-8 ICs
- 1:1s, performance reviews, hiring
- Deliver team goals

**EM → Senior EM / Director (3 years management):**
- Manage managers (2-3 EMs)
- Multi-team strategy
- Cross-team collaboration

**Director → VP (3-5 years):**
- Org-level strategy (50-200 engineers)
- Budget ownership
- Hiring plan, headcount
- Executive presence

**VP → SVP (5+ years):**
- Multi-org leadership (200-1000 engineers)
- Company strategy influence
- Board presentations

---

## Scaling Checklist

### Year 0-5: Foundation
- [ ] Hire founding team (5-20 engineers)
- [ ] Setup CI/CD pipeline
- [ ] Establish code review culture
- [ ] First product launch
- [ ] Product-market fit

### Year 5-10: Growth
- [ ] Hire VP Engineering
- [ ] Build management layer (8-12 EMs)
- [ ] Formalize on-call
- [ ] SOC2 compliance
- [ ] Scale to 100 engineers

### Year 10-20: Maturity
- [ ] Hire SVP Engineering, CISO
- [ ] Build director layer (20-30 directors)
- [ ] Formal architecture review
- [ ] Open source program office (OSPO)
- [ ] Scale to 500 engineers
- [ ] IPO or profitability

### Year 20-30: Leadership
- [ ] Hire CIO, Distinguished Engineers
- [ ] Research labs established
- [ ] Top 10 kernel contributor company
- [ ] Industry-defining innovations
- [ ] Scale to 1000+ engineers
- [ ] $1B+ ARR

---

## Related Documents

- [WORKFLOW.md](WORKFLOW.md) - Comprehensive SDLC workflow
- [CONTRIBUTING.md](CONTRIBUTING.md) - How to contribute
- [CLAUDE.md](CLAUDE.md) - Project-specific instructions

---

**Last Updated:** 2025-01-15
**Version:** 1.0.0
