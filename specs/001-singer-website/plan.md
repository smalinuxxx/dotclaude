# Implementation Plan: Singer Portfolio Website

**Branch**: `001-singer-website` | **Date**: 2026-02-02 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/001-singer-website/spec.md`
**User Technical Preferences**: Next.js, SVG logo, responsive mobile design

## Summary

Build a single-page portfolio website for a singer using Next.js, featuring a sleek minimal design with responsive mobile support. The site will showcase the singer's identity, music, tour dates, and social media connections through a vertically-scrolling single-page architecture with smooth navigation. An SVG logo will provide scalable branding across all device sizes.

**Technical Approach**: Static site generation with Next.js App Router, component-based architecture, SVG assets for logo, CSS modules or Tailwind for responsive styling, optimized image loading with next/image, and smooth scroll behavior with anchor navigation.

## Technical Context

**Language/Version**: JavaScript (TypeScript recommended) / Node.js 18+
**Primary Framework**: Next.js 14+ (App Router)
**Primary Dependencies**: React 18+, next/image, next/font
**Styling**: [NEEDS CLARIFICATION: Tailwind CSS, CSS Modules, styled-components, or vanilla CSS?]
**Storage**: Static JSON/Markdown files for content (no database)
**Testing**: [NEEDS CLARIFICATION: Jest + React Testing Library, Playwright for E2E, or both?]
**Target Platform**: Web (desktop, tablet, mobile browsers - Chrome, Firefox, Safari, Edge last 2 versions)
**Project Type**: Web - Single-page application with static generation
**Performance Goals**: Initial page load <3s on 4G, First Contentful Paint <1.5s, Lighthouse score >90
**Constraints**: Page weight <2MB initial load, images optimized/lazy-loaded, mobile-first responsive (320px-2560px), WCAG 2.1 Level AA compliance
**Scale/Scope**: Single page, 5-7 sections, ~20 images max, 10-15 components, no backend API

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

**Status**: No project constitution defined - using general web development best practices.

**Applied Standards**:
- Component-based architecture for maintainability
- Static generation for performance and simplicity
- Responsive-first design approach
- Accessibility compliance (WCAG 2.1 Level AA)
- Modern browser support only (last 2 versions)

**Potential Concerns**:
- No backend - all content is hardcoded or in static files (acceptable for this use case)
- No CMS - content updates require code changes (documented as assumption in spec)
- No state management library needed - minimal client-side interactivity

**Violations**: None - simple static site with no complex dependencies

## Project Structure

### Documentation (this feature)

```text
specs/001-singer-website/
├── plan.md              # This file (/speckit.plan command output)
├── research.md          # Phase 0 output (/speckit.plan command)
├── data-model.md        # Phase 1 output (/speckit.plan command)
├── quickstart.md        # Phase 1 output (/speckit.plan command)
├── contracts/           # Phase 1 output (/speckit.plan command)
│   └── content-schema.json
└── tasks.md             # Phase 2 output (/speckit.tasks command - NOT created by /speckit.plan)
```

### Source Code (repository root)

```text
singer-website/
├── public/
│   ├── logo.svg                    # SVG logo for scalability
│   ├── favicon.ico
│   └── images/                     # Optimized images (pre-processing)
│       ├── hero/
│       ├── gallery/
│       └── placeholder.jpg
│
├── src/
│   ├── app/                        # Next.js App Router
│   │   ├── layout.tsx              # Root layout with metadata
│   │   ├── page.tsx                # Main single-page content
│   │   ├── globals.css             # Global styles
│   │   └── fonts/                  # Custom fonts if needed
│   │
│   ├── components/                 # React components
│   │   ├── layout/
│   │   │   ├── Header.tsx          # Navigation + logo
│   │   │   └── Footer.tsx          # Copyright + social links
│   │   ├── sections/
│   │   │   ├── HeroSection.tsx     # P1: Name + hero image + tagline
│   │   │   ├── AboutSection.tsx    # P1: Biography
│   │   │   ├── MusicSection.tsx    # P2: Streaming links + embeds
│   │   │   ├── GallerySection.tsx  # P2: Photo gallery
│   │   │   ├── EventsSection.tsx   # P3: Tour dates + tickets
│   │   │   └── ContactSection.tsx  # P3: Contact/booking
│   │   └── ui/
│   │       ├── Button.tsx          # Reusable button
│   │       ├── SectionWrapper.tsx  # Consistent section spacing
│   │       └── SmoothScroll.tsx    # Smooth scroll behavior
│   │
│   ├── data/                       # Static content
│   │   ├── profile.json            # Singer info, bio, tagline
│   │   ├── music.json              # Streaming links, embeds
│   │   ├── gallery.json            # Image paths, captions
│   │   ├── events.json             # Tour dates, venues, tickets
│   │   └── social.json             # Social media links
│   │
│   ├── lib/                        # Utilities
│   │   ├── content.ts              # Load/parse JSON data
│   │   └── types.ts                # TypeScript interfaces
│   │
│   └── styles/                     # Component styles
│       └── [component].module.css  # CSS modules per component
│
├── tests/
│   ├── unit/
│   │   └── components/             # Component unit tests
│   └── e2e/
│       └── user-flows.spec.ts      # User story tests
│
├── next.config.js                  # Next.js configuration
├── tsconfig.json                   # TypeScript config
├── package.json                    # Dependencies
└── README.md                       # Setup instructions
```

**Structure Decision**: Using Next.js App Router structure with component-based architecture. The `src/app/page.tsx` will be the single-page entry point, importing section components that map to user stories (Hero=P1, Music/Gallery=P2, Events/Contact=P3). Static data files in `src/data/` allow content updates without touching component code. The `public/logo.svg` ensures crisp rendering at all resolutions.

## Complexity Tracking

No constitutional violations to justify - this is a straightforward static site.

---

## Phase 0: Outline & Research

**Status**: Research tasks identified for technical unknowns

### Research Tasks

1. **Styling Approach Decision**
   - **Unknown**: NEEDS CLARIFICATION - Tailwind CSS vs CSS Modules vs styled-components vs vanilla CSS
   - **Research Required**: Evaluate each approach for minimal design aesthetic and mobile responsiveness
   - **Context**: Need to support sleek/minimal design with generous whitespace, custom typography, and responsive breakpoints (320px-2560px)

2. **Testing Strategy**
   - **Unknown**: NEEDS CLARIFICATION - Jest + React Testing Library vs Playwright E2E vs both
   - **Research Required**: Determine minimum viable testing approach for static site with minimal interactivity
   - **Context**: Need to test responsive layouts, smooth scroll navigation, external link functionality

3. **Image Optimization Strategy**
   - **Unknown**: Best practices for handling 20+ high-resolution images with <3s load time
   - **Research Required**: Next.js image optimization, lazy loading, responsive images, CDN options
   - **Context**: Media-heavy site must maintain performance; need to optimize gallery images

4. **Smooth Scroll Implementation**
   - **Unknown**: Best practice for smooth scrolling to anchor links in Next.js 14+
   - **Research Required**: Native CSS scroll-behavior vs JavaScript libraries vs Next.js Link component
   - **Context**: FR-008 requires smooth scrolling; FR-013 requires section jump navigation

5. **SVG Logo Integration**
   - **Unknown**: Best practice for responsive SVG logo in Next.js (import vs public folder, sizing strategies)
   - **Research Required**: SVG optimization, responsive sizing, accessibility (alt text for logos)
   - **Context**: User specified SVG logo; must scale from mobile (320px) to desktop (2560px)

6. **Streaming Platform Embeds**
   - **Unknown**: Spotify/Apple Music/YouTube embed patterns and performance implications
   - **Research Required**: Embed code patterns, lazy loading for iframes, fallback links
   - **Context**: FR-003 requires streaming platform access; need to avoid blocking page load

7. **Accessibility Implementation**
   - **Unknown**: WCAG 2.1 Level AA compliance checklist for single-page music website
   - **Research Required**: Screen reader navigation for single-page, keyboard navigation, color contrast for minimal design
   - **Context**: Spec assumes WCAG 2.1 AA; edge case mentions screen reader performance

---

## Phase 1: Design & Contracts

**Status**: ✅ Complete

### Deliverables Created:

1. **data-model.md** - Content structure definitions
   - 5 core entities: Profile, MediaItem, GalleryImage, Event, SocialLink
   - TypeScript interfaces for type safety
   - Content loading patterns for Next.js
   - File structure and validation rules

2. **contracts/content-schema.json** - JSON Schema definitions
   - Complete schema validation for all content files
   - Field-level validation rules (patterns, min/max, formats)
   - Type constraints and enum values
   - Reference documentation for all entities

3. **quickstart.md** - Development setup guide
   - 5-minute quick start instructions
   - Detailed project configuration (Next.js, Tailwind, Playwright)
   - Content management workflow
   - Deployment instructions (Vercel, Netlify)
   - Troubleshooting guide and common issues

### Agent Context Update

No agent context update needed - this is a new standalone project with no existing codebase to integrate with.

---

## Phase 2: Task Breakdown

**Status**: Not started - use `/speckit.tasks` after Phase 1 completion

*This phase is handled by the `/speckit.tasks` command, which will:*
- Generate dependency-ordered implementation tasks
- Map tasks to user stories (P1, P2, P3)
- Create tasks.md in this directory

---

## Notes

- User explicitly requested Next.js and SVG logo - these are locked in
- User emphasized mobile responsiveness - mobile-first approach is critical
- Spec prioritizes user stories P1 (Hero) → P2 (Music/Gallery) → P3 (Events/Social)
- Implementation should follow this priority order for incremental delivery
- No backend needed - all content is static files (spec assumption #10)
