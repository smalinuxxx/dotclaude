# Tasks: Singer Portfolio Website

**Input**: Design documents from `/specs/001-singer-website/`
**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/content-schema.json

**Tests**: Testing strategy from research.md recommends Playwright E2E tests. Test tasks are included per user story.

**Organization**: Tasks are grouped by user story (P1-P3) to enable independent implementation and testing of each story.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: Which user story this task belongs to (US1, US2, US3, US4)
- Include exact file paths in descriptions

## Path Conventions

All paths relative to project root (`singer-website/`)

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Project initialization and basic Next.js structure

- [ ] T001 Create Next.js 14+ project with TypeScript, Tailwind CSS, ESLint, App Router, and src directory
- [ ] T002 Install core dependencies: lucide-react, @svgr/webpack
- [ ] T003 [P] Install dev dependencies: @playwright/test, sharp, @next/third-parties
- [ ] T004 [P] Configure next.config.js for SVGR, image optimization (AVIF/WebP formats)
- [ ] T005 [P] Configure tailwind.config.ts with custom colors, fonts, spacing for minimal design
- [ ] T006 [P] Update src/app/globals.css with smooth scroll, accessibility (prefers-reduced-motion), base styles
- [ ] T007 [P] Initialize Playwright with playwright.config.ts for chromium, mobile chrome, mobile safari
- [ ] T008 Create directory structure: src/components/{layout,sections,ui}, src/data, src/lib, public/images/{hero,about,music,gallery}, tests/e2e, scripts
- [ ] T009 [P] Create .gitignore to exclude node_modules, .next, .env.local, test results

**Checkpoint**: Project structure ready - foundational work can begin

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that MUST be complete before ANY user story can be implemented

**⚠️ CRITICAL**: No user story work can begin until this phase is complete

- [ ] T010 Create TypeScript interfaces in src/lib/types.ts for Profile, MediaItem, GalleryImage, Event, SocialLink
- [ ] T011 [P] Create content loading utilities in src/lib/content.ts (getProfile, getMusic, getGallery, getUpcomingEvents, getSocialLinks)
- [ ] T012 [P] Create sample content files: src/data/profile.json, src/data/music.json, src/data/gallery.json, src/data/events.json, src/data/social.json
- [ ] T013 [P] Create placeholder images in public/images/ directories (hero, about, music, gallery)
- [ ] T014 [P] Create SVG logo file at public/logo.svg with optimized viewBox and accessibility attributes
- [ ] T015 [P] Create visually-hidden utility class in src/app/globals.css for accessibility
- [ ] T016 Create Navigation component in src/components/layout/Navigation.tsx with Intersection Observer for active section tracking
- [ ] T017 [P] Create Header component in src/components/layout/Header.tsx with logo and navigation
- [ ] T018 [P] Create Footer component in src/components/layout/Footer.tsx with social links and copyright
- [ ] T019 Create SectionWrapper component in src/components/ui/SectionWrapper.tsx for consistent spacing and scroll-margin
- [ ] T020 Update src/app/layout.tsx with metadata, fonts, and global layout structure
- [ ] T021 Create base src/app/page.tsx with all section imports (will be populated in user stories)

**Checkpoint**: Foundation ready - user story implementation can now begin in parallel

---

## Phase 3: User Story 1 - Discover Singer Identity (Priority: P1) 🎯 MVP

**Goal**: Visitors can immediately identify the singer's name, see a professional hero image, and understand their musical style/genre within 5 seconds of landing.

**Independent Test**: Visit homepage and verify: (1) Singer's name is prominently displayed, (2) High-quality hero image loads, (3) Tagline/bio describes genre and style, (4) Layout is responsive on mobile, tablet, desktop.

### E2E Tests for User Story 1

> **NOTE: Write these tests FIRST, ensure they FAIL before implementation**

- [ ] T022 [P] [US1] Create Playwright test tests/e2e/hero-section.spec.ts to verify hero image, name, and tagline load within 5 seconds
- [ ] T023 [P] [US1] Create Playwright test tests/e2e/responsive-layout.spec.ts to verify layout adapts on 320px, 768px, 1280px viewports

### Implementation for User Story 1

- [ ] T024 [P] [US1] Create HeroSection component in src/components/sections/HeroSection.tsx with next/image for hero, name, and tagline display
- [ ] T025 [P] [US1] Create AboutSection component in src/components/sections/AboutSection.tsx with biography and optional profile image
- [ ] T026 [US1] Integrate HeroSection and AboutSection into src/app/page.tsx with profile data from getProfile()
- [ ] T027 [US1] Add Tailwind responsive utilities to HeroSection for mobile (320px), tablet (768px), desktop (1280px+) breakpoints
- [ ] T028 [US1] Add blur placeholder generation script in scripts/generate-blur-data.js for hero images
- [ ] T029 [US1] Optimize hero image with next/image priority prop and quality 90 for fast First Contentful Paint

**Checkpoint**: User Story 1 (MVP) is complete - hero and about sections work independently. Page loads in <3s with singer identity clear.

---

## Phase 4: User Story 2 - Access Music and Media (Priority: P2)

**Goal**: Visitors can hear the singer's music and see visual content to decide if they want to become a fan. Quick access to music samples, videos, or streaming platform links.

**Independent Test**: Scroll to music section and verify: (1) Music embeds or links are visible, (2) Clicking streaming links opens in new tab, (3) Scroll to gallery section and verify 20+ images load with lazy loading, (4) Gallery is responsive on all devices.

### E2E Tests for User Story 2

- [ ] T030 [P] [US2] Create Playwright test tests/e2e/music-section.spec.ts to verify music embeds load, external links work, and no page reload on interaction
- [ ] T031 [P] [US2] Create Playwright test tests/e2e/gallery-section.spec.ts to verify gallery images lazy load and responsive layout maintains performance

### Implementation for User Story 2

- [ ] T032 [P] [US2] Create MusicSection component in src/components/sections/MusicSection.tsx to display streaming platform links/embeds from music.json
- [ ] T033 [P] [US2] Create MusicEmbed component in src/components/ui/MusicEmbed.tsx for Spotify, YouTube (lite-youtube-embed), Apple Music with lazy loading and GDPR consent gates
- [ ] T034 [P] [US2] Create GallerySection component in src/components/sections/GallerySection.tsx with responsive grid layout
- [ ] T035 [P] [US2] Create GalleryImage component in src/components/ui/GalleryImage.tsx using next/image with lazy loading, blur placeholders, and responsive sizes
- [ ] T036 [US2] Integrate MusicSection into src/app/page.tsx with music data from getMusic()
- [ ] T037 [US2] Integrate GallerySection into src/app/page.tsx with gallery data from getGallery()
- [ ] T038 [US2] Update scripts/generate-blur-data.js to generate blur placeholders for all gallery images
- [ ] T039 [US2] Implement Intersection Observer in MusicSection for lazy loading embeds 200px before viewport
- [ ] T040 [US2] Add GDPR consent management component in src/components/ui/ConsentBanner.tsx for streaming embeds
- [ ] T041 [US2] Configure next/image for gallery: quality 75-80, sizes attribute for responsive (max-width: 768px) 100vw, 33vw

**Checkpoint**: User Stories 1 AND 2 are both independently functional. Music and gallery sections work without blocking page load.

---

## Phase 5: User Story 3 - Connect on Social Media (Priority: P3)

**Goal**: Fans can easily find and follow the singer on social media platforms. Clearly visible links with accessible labels and visual feedback.

**Independent Test**: Locate social media icons in footer and verify: (1) All links direct to correct platform profiles, (2) Icons have accessible labels, (3) Hover provides visual feedback, (4) Links open in new tab with proper security attributes.

### E2E Tests for User Story 3

- [ ] T042 [P] [US3] Create Playwright test tests/e2e/social-links.spec.ts to verify all social media links are visible, accessible, and direct to correct profiles

### Implementation for User Story 3

- [ ] T043 [P] [US3] Create SocialLinks component in src/components/ui/SocialLinks.tsx with lucide-react icons, accessible labels, and hover states
- [ ] T044 [US3] Integrate SocialLinks into Footer component (src/components/layout/Footer.tsx) with social data from getSocialLinks()
- [ ] T045 [US3] Add ARIA labels and visually-hidden text to social icons for screen reader accessibility
- [ ] T046 [US3] Ensure minimum 44x44px touch targets for social links per WCAG 2.1 AA guidelines
- [ ] T047 [US3] Add rel="noopener noreferrer" to all external social media links for security
- [ ] T048 [US3] Style social links with Tailwind: hover effects, focus indicators (3:1 contrast), and responsive spacing

**Checkpoint**: User Stories 1, 2, AND 3 are all independently functional. Social media integration complete.

---

## Phase 6: User Story 4 - View Tour and Events (Priority: P3)

**Goal**: Fans can see upcoming concerts, tour dates, and purchase tickets. Clear chronological schedule with venue details and ticket links.

**Independent Test**: Scroll to events section and verify: (1) Upcoming events are chronologically ordered, (2) Event details include date, venue, location, (3) Ticket links open vendor sites, (4) "No upcoming events" message displays if empty, (5) Past events are visually distinguished.

### E2E Tests for User Story 4

- [ ] T049 [P] [US4] Create Playwright test tests/e2e/events-section.spec.ts to verify event listings, ticket links, and empty state handling

### Implementation for User Story 4

- [ ] T050 [P] [US4] Create EventsSection component in src/components/sections/EventsSection.tsx to display events from getUpcomingEvents()
- [ ] T051 [P] [US4] Create EventCard component in src/components/ui/EventCard.tsx with date, venue, location, ticket link, and status badges
- [ ] T052 [US4] Integrate EventsSection into src/app/page.tsx with events data
- [ ] T053 [US4] Implement event status badges (upcoming, sold out, cancelled) with appropriate styling and ARIA labels
- [ ] T054 [US4] Add empty state component in EventsSection for "No upcoming events" with optional subscription CTA
- [ ] T055 [US4] Format dates using JavaScript Intl.DateTimeFormat for locale-aware display
- [ ] T056 [US4] Add descriptive link text for ticket buttons (e.g., "Buy tickets for Carnegie Hall concert") for accessibility
- [ ] T057 [US4] Ensure ticket links open in new tab with rel="noopener noreferrer"

**Checkpoint**: All 4 user stories are independently functional. Complete single-page portfolio ready for polish.

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Improvements that affect multiple user stories and final quality assurance

- [ ] T058 [P] Run full Playwright E2E test suite across all user stories and fix any failures
- [ ] T059 [P] Run Lighthouse accessibility audit and achieve score >90, verify WCAG 2.1 AA compliance
- [ ] T060 [P] Run Lighthouse performance audit and verify: FCP <1.5s, LCP <2.5s, page weight <2MB
- [ ] T061 [P] Create skip link in Header component for keyboard accessibility (WCAG 2.4.1)
- [ ] T062 [P] Verify all images have descriptive alt text per WCAG 1.1.1 guidelines
- [ ] T063 [P] Verify color contrast ratios: 4.5:1 for text, 3:1 for UI components using WebAIM checker
- [ ] T064 [P] Test keyboard navigation: Tab through entire page, verify focus indicators, no keyboard traps
- [ ] T065 [P] Test screen reader navigation with NVDA or VoiceOver: verify section announcements, skip links, ARIA labels
- [ ] T066 [P] Add semantic HTML landmarks to all sections: header, nav, main, section with aria-labelledby, footer
- [ ] T067 [P] Implement smooth scroll focus management: move focus to target section on anchor click
- [ ] T068 [P] Add loading states and error boundaries for music embeds and gallery images
- [ ] T069 [P] Optimize bundle size: analyze next build output, ensure CSS <20KB, JavaScript <500KB
- [ ] T070 [P] Create README.md with project setup, development, deployment instructions from quickstart.md
- [ ] T071 [P] Add package.json scripts: generate-blur for blur placeholders, test for Playwright, lint
- [ ] T072 [P] Test responsive design on real devices: iOS Safari (iPhone 12), Android Chrome (Pixel 5)
- [ ] T073 [P] Verify external links security: all open in new tab, no noopener vulnerabilities
- [ ] T074 [P] Add meta tags in layout.tsx: description, Open Graph, Twitter Card for social sharing
- [ ] T075 [P] Create custom 404 page if needed (optional for single-page site)
- [ ] T076 [P] Run npm run build and verify static export works without errors
- [ ] T077 [P] Deploy to Vercel: connect GitHub repo, configure project, verify automatic deployments
- [ ] T078 Validate quickstart.md: follow setup instructions on clean machine, verify all steps work

**Checkpoint**: Production-ready singer portfolio website complete with full accessibility, performance, and test coverage.

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies - can start immediately
- **Foundational (Phase 2)**: Depends on Setup completion - BLOCKS all user stories
- **User Stories (Phase 3-6)**: All depend on Foundational phase completion
  - User stories CAN proceed in parallel (if staffed)
  - OR sequentially in priority order (P1 → P2 → P3)
- **Polish (Phase 7)**: Depends on desired user stories being complete (minimum: US1 for MVP)

### User Story Dependencies

- **User Story 1 (P1)**: Can start after Foundational (Phase 2) - No dependencies on other stories - THIS IS THE MVP
- **User Story 2 (P2)**: Can start after Foundational (Phase 2) - Independent of US1 but complements it
- **User Story 3 (P3)**: Can start after Foundational (Phase 2) - Independent, requires Footer from Phase 2
- **User Story 4 (P3)**: Can start after Foundational (Phase 2) - Fully independent

### Within Each User Story

- E2E tests MUST be written FIRST and FAIL before implementation begins
- Components before integration into page.tsx
- Basic implementation before optimization
- Core functionality before error handling
- Story complete and independently testable before moving to next priority

### Parallel Opportunities

**Phase 1 (Setup)**:
- T003, T004, T005, T006, T007, T009 can all run in parallel after T001-T002

**Phase 2 (Foundational)**:
- T011-T015 can run in parallel after T010
- T017, T018 can run in parallel after T016
- All components in this phase work on different files

**Phase 3 (US1)**:
- T022, T023 tests can run in parallel
- T024, T025 components can run in parallel

**Phase 4 (US2)**:
- T030, T031 tests can run in parallel
- T032, T033, T034, T035 components can all run in parallel
- T038, T040, T041 can run in parallel after core components

**Phase 5 (US3)**:
- T043 component work can start immediately after T042 test

**Phase 6 (US4)**:
- T050, T051 components can run in parallel

**Phase 7 (Polish)**:
- Most tasks marked [P] can run in parallel as they affect different aspects

**Cross-User Story Parallelization**:
- After Phase 2 completes, ALL four user stories (US1-US4) can be developed in parallel by different developers
- Each story has independent components and data files

---

## Parallel Example: User Story 1

```bash
# Step 1: Launch all tests for User Story 1 together:
Task T022: "Create Playwright test tests/e2e/hero-section.spec.ts"
Task T023: "Create Playwright test tests/e2e/responsive-layout.spec.ts"

# Step 2: Launch all components for User Story 1 together:
Task T024: "Create HeroSection component in src/components/sections/HeroSection.tsx"
Task T025: "Create AboutSection component in src/components/sections/AboutSection.tsx"

# Step 3: Sequential integration tasks:
Task T026: "Integrate into src/app/page.tsx"
Task T027: "Add responsive utilities"
Task T028: "Add blur placeholder script"
Task T029: "Optimize hero image"
```

---

## Parallel Example: User Story 2

```bash
# Step 1: Launch all tests together:
Task T030: "Create Playwright test tests/e2e/music-section.spec.ts"
Task T031: "Create Playwright test tests/e2e/gallery-section.spec.ts"

# Step 2: Launch all components together:
Task T032: "Create MusicSection in src/components/sections/MusicSection.tsx"
Task T033: "Create MusicEmbed in src/components/ui/MusicEmbed.tsx"
Task T034: "Create GallerySection in src/components/sections/GallerySection.tsx"
Task T035: "Create GalleryImage in src/components/ui/GalleryImage.tsx"

# Step 3: Sequential integration:
Task T036: "Integrate MusicSection into page.tsx"
Task T037: "Integrate GallerySection into page.tsx"

# Step 4: Parallel optimizations:
Task T038: "Update blur placeholder script"
Task T039: "Implement Intersection Observer"
Task T040: "Add GDPR consent component"
Task T041: "Configure next/image"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup (T001-T009)
2. Complete Phase 2: Foundational (T010-T021) - CRITICAL: blocks all stories
3. Complete Phase 3: User Story 1 (T022-T029)
4. **STOP and VALIDATE**:
   - Run Playwright tests for US1
   - Verify hero loads in <3s
   - Test on mobile (320px), tablet (768px), desktop (1280px)
   - Check Lighthouse scores (performance >90, accessibility >90)
5. Deploy MVP to Vercel for stakeholder review

**MVP Scope**: Hero section with singer name, professional image, tagline, and about section with biography. This delivers core value: immediate artist identity recognition.

### Incremental Delivery

1. **Foundation**: Complete Setup + Foundational (T001-T021) → Project structure ready
2. **MVP (US1)**: Add Hero + About (T022-T029) → Test independently → Deploy (Week 1)
3. **Engagement (US2)**: Add Music + Gallery (T030-T041) → Test independently → Deploy (Week 2)
4. **Connection (US3)**: Add Social Links (T042-T048) → Test independently → Deploy (Week 3)
5. **Conversion (US4)**: Add Events (T049-T057) → Test independently → Deploy (Week 4)
6. **Polish**: Quality assurance (T058-T078) → Final production deployment (Week 5)

Each deploy adds value without breaking previous functionality.

### Parallel Team Strategy

With multiple developers:

1. **Week 1**: Team completes Setup + Foundational together (T001-T021)
2. **Week 2-4**: Once Foundational is done, parallelize:
   - Developer A: User Story 1 (T022-T029) → Deploy MVP
   - Developer B: User Story 2 (T030-T041) → Merge to main
   - Developer C: User Story 3 (T042-T048) + User Story 4 (T049-T057) → Merge to main
3. **Week 5**: Team collaboration on Polish (T058-T078)

Stories complete independently and integrate without conflicts (different components/files).

---

## Task Summary

**Total Tasks**: 78 tasks
- **Setup (Phase 1)**: 9 tasks
- **Foundational (Phase 2)**: 12 tasks (BLOCKS all stories)
- **User Story 1 - Discover Identity (P1 - MVP)**: 8 tasks (2 tests + 6 implementation)
- **User Story 2 - Access Music/Media (P2)**: 12 tasks (2 tests + 10 implementation)
- **User Story 3 - Connect Social (P3)**: 7 tasks (1 test + 6 implementation)
- **User Story 4 - View Events (P3)**: 9 tasks (1 test + 8 implementation)
- **Polish (Phase 7)**: 21 tasks (quality assurance, deployment)

**Parallel Tasks**: 42 tasks marked [P] can run in parallel (54% of total)

**Independent Test Criteria**:
- US1: Hero loads, name visible, tagline clear, responsive on 3 viewports - testable without other stories
- US2: Music embeds work, gallery loads with lazy loading - testable without other stories
- US3: Social links navigate correctly, accessible - testable without other stories
- US4: Events display, tickets link, empty state works - testable without other stories

**Suggested MVP Scope**: Complete Phase 1 (Setup), Phase 2 (Foundational), and Phase 3 (User Story 1) only. This delivers a functional singer portfolio with hero image, name, tagline, and biography - the core value proposition. Deploy this first, then incrementally add US2-US4 based on feedback.

---

## Notes

- **[P] tasks**: Different files, no dependencies - safe to parallelize
- **[Story] labels**: Map tasks to user stories for traceability
- **Each user story is independently completable and testable** - no cross-story dependencies
- **Verify tests FAIL before implementing** - ensures TDD workflow
- **Commit after each task or logical group** - maintains clean git history
- **Stop at any checkpoint** to validate story independently before proceeding
- **Content files** in src/data/ can be populated incrementally without blocking implementation
- **Images** in public/images/ can use placeholders initially, swap with real assets later
- **Avoid**: Vague tasks, same-file conflicts, cross-story dependencies that break independence
