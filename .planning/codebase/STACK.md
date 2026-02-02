# Technology Stack

**Analysis Date:** 2026-02-02

## Overview

This codebase contains a GSD (Get Shit Done) project management and CLI framework with support for multiple feature implementations. The primary projects under development are a singer portfolio website and an FAQ chatbot, both built on modern web technologies.

## Languages

**Primary:**
- TypeScript 5.3+ - All application code and configurations
- JavaScript - Build scripts, configuration files, and tooling scripts

**Secondary:**
- Markdown - Documentation, specifications, and content
- JSON - Configuration files, data schemas, and content storage

## Runtime

**Environment:**
- Node.js 20.x (LTS) - Required for development and deployment
  - Configured in Docker base image: `node:20`
  - Devcontainer user: `node`
  - NPM Global prefix: `/usr/local/share/npm-global`

**Package Manager:**
- npm 10.x+ (comes with Node.js 20)
- Lockfile: `package-lock.json` (standard npm lockfile)

## Frameworks & Core Dependencies

**Web Frameworks (for projects):**
- Next.js 14+ (App Router) - Primary framework for singer website and chatbot projects
  - React 18+ - UI component framework
  - next/image - Image optimization and responsive serving
  - next/font - Font optimization

**Styling & UI:**
- Tailwind CSS v4.0 - Utility-first CSS framework (as specified in singer website project)
- CSS Modules - Component-scoped styling
- lucide-react - Icon library for UI components

**Icon/SVG Support:**
- @svgr/webpack - Converts SVG files to React components
- Configured in Next.js webpack pipeline for SVG imports

**Testing & Quality:**
- Playwright - E2E testing framework (@playwright/test)
- TypeScript compiler - Type checking and compilation
- ESLint - Code quality and style enforcement
- Prettier - Code formatting

**Build & Development Tools:**
- TypeScript 5.3+ - Static type checking
- tsx - TypeScript execution without build step
- sharp - Image processing and optimization
- @next/third-parties - Third-party script optimization (YouTube embeds, etc.)

## Key Dependencies by Project

### Singer Portfolio Website

**Critical:**
- Next.js 14+ - Static site generation and server-side rendering
- React 18+ - Component architecture
- Tailwind CSS v4.0 - Responsive styling system
- lucide-react - Icon components for social media links

**Infrastructure:**
- next/image - Optimized image delivery with WebP/AVIF support
- @svgr/webpack - SVG logo as React component
- sharp - Image processing for optimization

### FAQ Chatbot

**Critical:**
- Next.js 14+ - Web server and routing
- React 18+ - Chatbot widget UI
- (LLM integration framework to be determined) - Natural language understanding

**Infrastructure:**
- next/image - Image serving
- (API client library to be determined) - Backend communication

## Configuration Files

**TypeScript:**
- `tsconfig.json` - TypeScript compiler options

**Next.js:**
- `next.config.js` - Next.js configuration (image formats, webpack rules for SVG)
- `tailwind.config.ts` - Tailwind CSS theme customization (colors, fonts, spacing)
- `.eslintrc.json` or `.eslintrc.js` - ESLint rules configuration

**Development Container:**
- `.devcontainer/devcontainer.json` - Dev container configuration
- `.devcontainer/Dockerfile` - Docker image with Node.js 20, npm, zsh, ESLint, Prettier
- `.claude/settings.json` - Claude Code hooks and configuration

**Testing:**
- `jest.config.js` or `vitest.config.ts` (if configured) - Test runner configuration
- `playwright.config.ts` (if configured) - Playwright E2E test configuration

## Environment Configuration

**Development:**
- Environment variables via `.env.local` (Next.js convention)
- No required environment variables for basic development (static sites)
- Potential future vars for chatbot: API endpoints, authentication keys

**Build:**
- Standard Next.js build process: `npm run build`
- Static export supported for singer website (no dynamic server needed)
- Image optimization enabled (AVIF, WebP formats)

**Docker/Container:**
- Development: Node.js 20 container with npm configured
- Network firewall configured: whitelist npm registry and GitHub
- Node user (non-root) runs all processes
- Node options: `--max-old-space-size=4096` for memory

## Platform Requirements

**Development:**
- Docker container (Linux-based) with Node.js 20
- Platform: Linux (via Docker)
- npm registry access required
- GitHub access for git operations (controlled)

**Production:**

**Singer Portfolio Website:**
- Deployment platform: Vercel (optimal for Next.js, mentioned in specs)
- Alternative: Any Node.js hosting (AWS, Netlify, Azure, etc.)
- Static export compatible (generates pure HTML/CSS/JS)
- CDN: Vercel built-in edge optimization (no external CDN needed)

**FAQ Chatbot:**
- Deployment platform: Vercel or similar Node.js host
- Runtime: Node.js 20+
- May require: Database/API backend (to be determined)
- Scaling: Designed to handle 100+ concurrent sessions

## Performance Targets

**Singer Website:**
- Initial page load: <3 seconds (4G network)
- First Contentful Paint: <1.5 seconds
- Lighthouse score: >90
- Page weight: <2MB initial load
- Images: Optimized with lazy loading

**FAQ Chatbot:**
- Response time: <2 seconds for FAQ queries
- Concurrent sessions: 100+ without degradation
- Search accuracy: 85%+ match rate for questions

## Notable Architectural Decisions

**No Backend Required (Singer Website):**
- Static JSON/Markdown files stored in `/src/data/`
- Content: `profile.json`, `music.json`, `gallery.json`, `events.json`, `social.json`
- No database required (static generation)
- No CMS backend (content updates require code changes and redeploy)

**Content Schema:**
- JSON-based data models with strict validation
- Relationships between entities (music items, gallery images, events)
- Build-time content validation and processing

**Image Handling:**
- next/image for responsive optimization
- Formats: AVIF (primary), WebP (fallback), JPEG (legacy)
- Blur placeholder support (generated at build time)
- Lazy loading by default

**Styling Architecture:**
- Tailwind CSS utility classes
- CSS custom properties (CSS variables) for theming
- Design system: Black (#000000), White (#FFFFFF), Gray (#8B8B8B)
- Responsive breakpoints: Mobile-first (320px-2560px)

---

*Stack analysis: 2026-02-02*
*Update after major dependency changes or new framework additions*
