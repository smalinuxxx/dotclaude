# Phase 0 Research: Singer Portfolio Website
**Feature**: 001-singer-website
**Date**: 2026-02-02
**Status**: Complete

## Overview

This document consolidates research findings for seven technical decisions required to implement the Next.js single-page singer portfolio website.

---

## 1. Styling Approach

### Decision: Tailwind CSS v4.0

**Rationale**:
- Zero runtime overhead (compile-time optimization)
- 35% smaller package size with automatic purging
- Perfect for minimal design with built-in utilities for whitespace, typography, and responsive design
- 100x faster incremental builds
- Native mobile-first responsive utilities align perfectly with 320px-2560px requirements
- Industry standard for Next.js in 2026

**Alternatives Considered**:
- **CSS Modules**: Rejected due to lack of built-in responsive utilities and repetitive manual CSS writing
- **styled-components**: Rejected due to runtime performance overhead, maintenance mode (March 2025), and React Server Components incompatibility
- **Vanilla CSS**: Rejected due to manual responsive design work and no systematic design tokens

**Configuration**:
```typescript
// tailwind.config.ts
import type { Config } from 'tailwindcss'

export default {
  content: [
    './app/**/*.{js,ts,jsx,tsx}',
    './components/**/*.{js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {
      colors: {
        primary: '#000000',
        secondary: '#FFFFFF',
        accent: '#8B8B8B',
      },
      fontFamily: {
        display: ['YourDisplayFont', 'serif'],
        body: ['YourBodyFont', 'sans-serif'],
      },
      fontSize: {
        'hero': ['6rem', { lineHeight: '1', letterSpacing: '-0.02em' }],
      },
      spacing: {
        '128': '32rem',
        '160': '40rem',
      },
    },
  },
} satisfies Config
```

**Performance Validation**:
- Expected CSS bundle: 5-15KB gzipped
- Build time: <500ms incremental
- Lighthouse performance score target: >90

---

## 2. Testing Strategy

### Decision: Playwright E2E (Primary) + Selective Jest/RTL (Secondary)

**Rationale**:
- E2E tests validate real user experience (responsive layouts, navigation, external links)
- Playwright provides built-in accessibility testing and multi-browser support
- Static sites have minimal client-side logic, reducing need for extensive unit tests
- Low maintenance overhead with stable DOM

**What to Test**:
- **Playwright (80% of effort)**:
  - Responsive layout breakpoints (320px, 768px, 1280px)
  - Smooth scroll navigation
  - External links (social media, streaming, tickets)
  - Image lazy loading
  - WCAG 2.1 AA accessibility (automated axe-core)
  - Performance metrics (Core Web Vitals)

- **Jest + RTL (20% of effort)**:
  - Interactive components only (mobile menu, gallery interactions)
  - Custom hooks (if any)
  - Utility functions (date formatting, content parsing)

**Coverage Goals**:
- E2E: 100% critical user paths (5-8 scenarios)
- Unit: 50-70% of interactive logic only
- Accessibility: 100% automated WCAG checks

**Setup**:
```bash
npm install -D @playwright/test
npx playwright install
```

---

## 3. Image Optimization

### Decision: Next.js Image Component + AVIF/WebP + Lazy Loading

**Rationale**:
- AVIF format delivers 50% smaller files than JPEG with superior quality
- WebP provides 30% smaller files as fallback
- Next.js `next/image` handles automatic optimization, responsive sizing, and lazy loading
- Intersection Observer with 200px rootMargin for optimal UX

**Image Format Strategy**:
- **Primary**: AVIF (best compression)
- **Fallback**: WebP (broad support)
- **Last Resort**: JPEG (universal compatibility)

**Quality Settings**:
- Hero images: 85-90 quality
- Gallery images: 75-80 quality
- Thumbnails: 70-75 quality

**Implementation Pattern**:
```jsx
// Hero Section (above-the-fold)
<Image
  src="/images/hero-singer.jpg"
  alt="Professional portrait"
  fill
  priority // Preload critical image
  sizes="100vw"
  quality={90}
  placeholder="blur"
  blurDataURL="data:image/jpeg;base64,..."
/>

// Gallery (below-the-fold)
<Image
  src={image.src}
  alt={image.alt}
  fill
  sizes="(max-width: 768px) 100vw, 33vw"
  quality={75}
  loading="lazy" // Default behavior
  placeholder="blur"
/>
```

**Performance Targets**:
- Initial page weight: <1.8MB (down from 8-12MB unoptimized)
- LCP: <2.3 seconds
- 85% reduction in page weight

**CDN Strategy**:
- Use Vercel built-in edge optimization (no external CDN needed)
- Automatic caching and global distribution
- Falls within free tier for portfolio sites

---

## 4. Smooth Scroll Implementation

### Decision: Native CSS `scroll-behavior: smooth` + Intersection Observer

**Rationale**:
- Zero JavaScript overhead (CSS runs on compositor thread)
- Excellent performance (60fps guaranteed)
- No external dependencies (0KB bundle impact)
- Intersection Observer provides active section tracking
- Native `<a>` tags preserve browser accessibility

**Implementation**:
```css
/* globals.css */
html {
  scroll-behavior: smooth;
}

@media (prefers-reduced-motion: reduce) {
  html {
    scroll-behavior: auto; /* Accessibility requirement */
  }
}

section {
  scroll-margin-top: 80px; /* Offset for fixed header */
}
```

```tsx
// Navigation with active tracking
useEffect(() => {
  const observer = new IntersectionObserver(
    (entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          setActiveSection(entry.target.id);
          window.history.replaceState(null, '', `#${entry.target.id}`);
        }
      });
    },
    { rootMargin: '-50% 0px -50% 0px' } // Trigger at center
  );

  sections.forEach(({ id }) => {
    const element = document.getElementById(id);
    if (element) observer.observe(element);
  });

  return () => observer.disconnect();
}, []);
```

**Browser Compatibility**:
- `scroll-behavior: smooth`: 96% global support (Chrome 61+, Firefox 36+, Safari 15.4+)
- Intersection Observer: 98% global support

**Alternatives Rejected**:
- JavaScript libraries (react-scroll, Lenis): Rejected due to bundle size and main thread execution
- Next.js Link component: Rejected because it prevents default anchor scroll behavior

---

## 5. SVG Logo Integration

### Decision: Inline SVG with SVGR + SVGO Optimization

**Rationale**:
- Complete theming control via CSS custom properties
- Zero additional HTTP requests
- Direct DOM access for animations
- Tree-shakeable (only included when used)
- User-specified SVG logo requirement

**Optimization Process**:
1. **SVGO optimization**: 60-90% file size reduction
2. **Remove editor metadata** (Adobe, Figma artifacts)
3. **Simplify paths** and round decimals
4. **Convert to inline component** with SVGR

**Setup**:
```bash
npm install --save-dev @svgr/webpack
```

```javascript
// next.config.js
const nextConfig = {
  webpack(config) {
    config.module.rules.push({
      test: /\.svg$/i,
      use: ['@svgr/webpack'],
    });
    return config;
  },
}
```

**Responsive Sizing**:
```css
.logo-container {
  width: clamp(120px, 15vw, 200px); /* Fluid 320px-2560px */
}

.logo-container svg {
  width: 100%;
  height: auto;
  display: block;
}
```

**Accessibility Pattern**:
```tsx
<svg
  role="img"
  aria-labelledby="logo-title"
  viewBox="0 0 200 60"
>
  <title id="logo-title">Singer Website</title>
  {/* SVG paths */}
</svg>
```

**Theming**:
```css
:root {
  --logo-primary: #1a1a1a;
  --logo-accent: #ff6b6b;
}

@media (prefers-color-scheme: dark) {
  :root {
    --logo-primary: #ffffff;
    --logo-accent: #ff8787;
  }
}

.logo-path {
  fill: var(--logo-primary);
}
```

---

## 6. Streaming Platform Embeds

### Decision: Platform-Specific Lazy Loading with GDPR Consent Gates

**Rationale**:
- Performance: Embeds add 150-1300KB per iframe
- Privacy: GDPR requires explicit consent for tracking cookies
- UX: Lazy loading prevents blocking initial page load (<3s target)

### Platform Strategies:

#### **Spotify**
- **Method**: Simple iframe with Intersection Observer
- **Load Impact**: ~200KB per embed
- **GDPR**: Requires cookie consent (tracking/analytics)
- **Implementation**:
  ```tsx
  <iframe
    src="https://open.spotify.com/embed/track/..."
    width="100%"
    height="352"
    frameBorder="0"
    allow="autoplay; clipboard-write; encrypted-media"
    loading="lazy"
  />
  ```

#### **YouTube**
- **Method**: lite-youtube-embed (strongly recommended)
- **Load Impact**: ~100KB (vs 1.3MB standard embed)
- **Performance**: 224× faster than standard embed
- **GDPR**: Use youtube-nocookie.com, gate with consent
- **Implementation**:
  ```tsx
  import { YouTubeEmbed } from '@next/third-parties/google';

  <YouTubeEmbed videoid="..." height={400} params="controls=1" />
  ```

#### **Apple Music**
- **Method**: Simple iframe embed
- **Load Impact**: ~150KB
- **Limitation**: No native oEmbed API (must get embed codes manually)
- **Implementation**:
  ```tsx
  <iframe
    src="https://embed.music.apple.com/us/album/..."
    width="100%"
    height="450"
    allow="autoplay *; encrypted-media *; fullscreen *"
    loading="lazy"
  />
  ```

### Unified Consent Management:
```tsx
// Block all embeds until consent
if (!hasConsent) {
  return (
    <div className="consent-placeholder">
      <button onClick={() => grantConsent()}>
        Load {platform} Player
      </button>
      <a href={directUrl}>Open in {platform}</a>
    </div>
  );
}
```

**Performance Best Practices**:
- Use Intersection Observer with 200px rootMargin
- Lazy load with `loading="lazy"` attribute
- Dynamic import embed components with `ssr: false`
- Provide fallback direct links

---

## 7. WCAG 2.1 Level AA Accessibility

### Decision: Comprehensive Accessibility Implementation Checklist

**Critical Requirements**:

#### **Single-Page Navigation**
- **Skip link** as first focusable element
- **Semantic landmarks** (`<header>`, `<nav>`, `<main>`, `<footer>`)
- **Logical heading hierarchy** (H1 → H2 → H3, no skipped levels)
- **Focus management** for smooth scroll (move focus to target section)

#### **Color Contrast** (Critical for minimal designs)
- **Normal text**: 4.5:1 minimum (cannot round up - 4.47:1 fails)
- **Large text** (18pt/24px or 14pt/19px bold): 3:1 minimum
- **UI components**: 3:1 minimum (borders, focus indicators, icons)
- **Common pitfall**: Light gray text (#767676) on white fails contrast

#### **Keyboard Navigation**
- All interactive elements accessible via keyboard only
- Visible focus indicators (3:1 contrast)
- No keyboard traps
- Logical tab order
- Smooth scroll respects `prefers-reduced-motion`

#### **Image Accessibility**
- Alt text for all meaningful images (performance photos, headshots)
- Empty alt (`alt=""`) for decorative images
- Gallery implementation with `<figure>` and `<figcaption>`

#### **Media Players**
- **Videos**: Captions (WCAG 1.2.2) and audio descriptions (WCAG 1.2.5)
- **Audio**: Transcripts (WCAG 1.2.1)
- **No auto-play** audio >3 seconds (WCAG 1.4.2)
- Keyboard-accessible player controls

#### **Social Media Links**
- Accessible names for icon-only links
- Use `aria-label` or visually hidden text
- Minimum 44×44px touch targets (24×24px WCAG 2.2 minimum)

#### **Event Listings**
- Descriptive link text (no "click here" or "read more")
- Proper list semantics (`<ul>`, `<li>`)
- Clear context for ticket links

**Testing Tools**:
- **axe DevTools** (primary): Most comprehensive, 70+ WCAG tests
- **Lighthouse** (secondary): Built-in accessibility audit
- **WAVE** (beginner-friendly): Visual feedback overlay
- **Manual testing** (60-70% of issues): Keyboard navigation, screen readers (NVDA, VoiceOver)

**Implementation Pattern**:
```html
<a href="#main" class="skip-link">Skip to main content</a>

<header role="banner">
  <nav role="navigation" aria-label="Main">
    <a href="#music">Music</a>
  </nav>
</header>

<main role="main" id="main">
  <section id="music" aria-labelledby="music-heading">
    <h2 id="music-heading">Music</h2>
  </section>
</main>

<style>
@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
</style>
```

**Validation Checklist**:
- ✅ axe DevTools: 0 violations
- ✅ Lighthouse accessibility score >90
- ✅ Keyboard test: Full navigation successful
- ✅ Screen reader test: Content makes sense
- ✅ Contrast test: All elements pass 4.5:1 (text) or 3:1 (UI)
- ✅ Zoom test: Works at 200% without horizontal scroll

---

## Research Completion Summary

All seven technical unknowns have been resolved with clear implementation guidance:

1. ✅ **Styling**: Tailwind CSS v4.0 (zero runtime, optimal for minimal design)
2. ✅ **Testing**: Playwright E2E primary, selective Jest/RTL secondary
3. ✅ **Images**: Next.js Image + AVIF/WebP + lazy loading (85% weight reduction)
4. ✅ **Smooth Scroll**: Native CSS + Intersection Observer (zero dependencies)
5. ✅ **SVG Logo**: Inline with SVGR + SVGO optimization (themeable, accessible)
6. ✅ **Streaming Embeds**: Platform-specific lazy loading + GDPR consent gates
7. ✅ **Accessibility**: Comprehensive WCAG 2.1 AA implementation checklist

**Next Phase**: Proceed to Phase 1 (Design & Contracts) to create:
- data-model.md (content structure)
- contracts/content-schema.json
- quickstart.md (setup instructions)
