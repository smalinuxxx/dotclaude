# Quickstart Guide: Singer Portfolio Website
**Feature**: 001-singer-website
**Date**: 2026-02-02
**Status**: Complete

## Prerequisites

- **Node.js**: v18.0.0 or higher
- **npm**: v9.0.0 or higher (or yarn/pnpm equivalent)
- **Git**: For version control
- **Code Editor**: VS Code recommended (with ESLint/Prettier extensions)

---

## Quick Start (5 Minutes)

```bash
# 1. Create Next.js project
npx create-next-app@latest singer-website

# When prompted:
# ✓ TypeScript? Yes
# ✓ ESLint? Yes
# ✓ Tailwind CSS? Yes
# ✓ src/ directory? Yes
# ✓ App Router? Yes
# ✓ Import alias? Yes (@/*)

# 2. Navigate to project
cd singer-website

# 3. Install additional dependencies
npm install @svgr/webpack lucide-react

# 4. Install dev dependencies
npm install -D @playwright/test sharp

# 5. Initialize Playwright
npx playwright install

# 6. Start development server
npm run dev
# Open http://localhost:3000
```

---

## Project Setup (Detailed)

### 1. Create Next.js Application

```bash
npx create-next-app@latest singer-website --typescript --tailwind --eslint --app --src-dir --import-alias "@/*"
```

This creates a Next.js 14+ project with:
- TypeScript for type safety
- Tailwind CSS v4.0 for styling
- ESLint for code quality
- App Router for modern Next.js routing
- `src/` directory for organized code structure
- Import alias `@/*` for clean imports

### 2. Install Dependencies

```bash
cd singer-website

# Core dependencies
npm install lucide-react              # Icon library for social links
npm install @svgr/webpack            # SVG as React components

# Dev dependencies
npm install -D @playwright/test      # E2E testing
npm install -D sharp                 # Image optimization
npm install -D @next/third-parties   # YouTube embed optimization
```

### 3. Configure Next.js

Create/update `next.config.js`:

```javascript
/** @type {import('next').NextConfig} */
const nextConfig = {
  images: {
    formats: ['image/avif', 'image/webp'],
    deviceSizes: [640, 750, 828, 1080, 1200, 1920, 2048, 3840],
    imageSizes: [16, 32, 48, 64, 96, 128, 256, 384],
    minimumCacheTTL: 31536000, // 1 year for static images
  },
  webpack(config) {
    // SVG as React components with SVGR
    const fileLoaderRule = config.module.rules.find((rule) =>
      rule.test?.test?.('.svg'),
    )

    config.module.rules.push(
      {
        ...fileLoaderRule,
        test: /\.svg$/i,
        resourceQuery: /url/, // *.svg?url
      },
      {
        test: /\.svg$/i,
        issuer: fileLoaderRule.issuer,
        resourceQuery: { not: [...fileLoaderRule.resourceQuery.not, /url/] },
        use: ['@svgr/webpack'],
      },
    )

    fileLoaderRule.exclude = /\.svg$/i

    return config
  },
}

module.exports = nextConfig
```

### 4. Configure Tailwind CSS

Update `tailwind.config.ts`:

```typescript
import type { Config } from 'tailwindcss'

const config: Config = {
  content: [
    './src/pages/**/*.{js,ts,jsx,tsx,mdx}',
    './src/components/**/*.{js,ts,jsx,tsx,mdx}',
    './src/app/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        primary: '#000000',
        secondary: '#FFFFFF',
        accent: '#8B8B8B',
      },
      fontFamily: {
        display: ['var(--font-display)', 'serif'],
        body: ['var(--font-body)', 'sans-serif'],
      },
      fontSize: {
        'hero': ['6rem', { lineHeight: '1', letterSpacing: '-0.02em' }],
        'display': ['4.5rem', { lineHeight: '1.1', letterSpacing: '-0.01em' }],
      },
      spacing: {
        '128': '32rem',
        '160': '40rem',
      },
    },
  },
  plugins: [],
}

export default config
```

### 5. Update Global Styles

Update `src/app/globals.css`:

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  html {
    scroll-behavior: smooth;
  }

  /* Respect user motion preferences */
  @media (prefers-reduced-motion: reduce) {
    *,
    *::before,
    *::after {
      animation-duration: 0.01ms !important;
      animation-iteration-count: 1 !important;
      transition-duration: 0.01ms !important;
      scroll-behavior: auto !important;
    }
  }

  /* Offset for fixed header */
  section {
    scroll-margin-top: 80px;
  }

  body {
    @apply font-body text-primary bg-secondary antialiased;
  }

  h1, h2, h3, h4, h5, h6 {
    @apply font-display tracking-tight;
  }
}

@layer utilities {
  .visually-hidden {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    white-space: nowrap;
    border: 0;
  }
}
```

### 6. Create Directory Structure

```bash
# Create required directories
mkdir -p src/components/layout
mkdir -p src/components/sections
mkdir -p src/components/ui
mkdir -p src/data
mkdir -p src/lib
mkdir -p src/styles
mkdir -p public/images/hero
mkdir -p public/images/about
mkdir -p public/images/music
mkdir -p public/images/gallery
mkdir -p tests/e2e
mkdir -p scripts
```

### 7. Initialize Playwright

```bash
npx playwright install
npx playwright install-deps
```

Create `playwright.config.ts`:

```typescript
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests/e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: 'html',
  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
  },
  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'Mobile Chrome',
      use: { ...devices['Pixel 5'] },
    },
    {
      name: 'Mobile Safari',
      use: { ...devices['iPhone 12'] },
    },
  ],
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
  },
});
```

---

## Development Workflow

### Running the Development Server

```bash
npm run dev
# Open http://localhost:3000
```

Hot reload is enabled - changes appear instantly.

### Building for Production

```bash
npm run build
npm run start
```

### Running Tests

```bash
# Run all Playwright tests
npx playwright test

# Run tests in UI mode
npx playwright test --ui

# Run specific test file
npx playwright test tests/e2e/homepage.spec.ts

# Run tests in headed mode (see browser)
npx playwright test --headed

# Generate test report
npx playwright show-report
```

### Linting and Formatting

```bash
# Run ESLint
npm run lint

# Fix ESLint issues
npm run lint -- --fix

# Format with Prettier (if installed)
npx prettier --write .
```

---

## Content Management

### Adding Content

All content is managed through JSON files in `src/data/`:

```bash
# Edit artist profile
code src/data/profile.json

# Add music links
code src/data/music.json

# Add gallery images
code src/data/gallery.json

# Add tour dates
code src/data/events.json

# Add social links
code src/data/social.json
```

### Adding Images

1. **Optimize images** before adding:
   ```bash
   # Install Sharp CLI (if not already installed)
   npm install -g sharp-cli

   # Resize and optimize
   sharp -i original.jpg -o optimized.jpg resize 2560 -q 85
   ```

2. **Place images** in appropriate directories:
   - Hero images: `public/images/hero/`
   - Profile photos: `public/images/about/`
   - Album art: `public/images/music/`
   - Gallery photos: `public/images/gallery/`

3. **Generate blur placeholders** for gallery images:
   ```bash
   npm run generate-blur
   ```

### Content Validation

TypeScript will validate content structure at build time. Run:

```bash
npm run build
```

Any schema violations will be reported as build errors.

---

## Deployment

### Deploy to Vercel (Recommended)

1. **Push to GitHub**:
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/yourusername/singer-website.git
   git push -u origin main
   ```

2. **Import to Vercel**:
   - Go to [vercel.com/new](https://vercel.com/new)
   - Import your GitHub repository
   - Configure project (defaults are usually correct)
   - Deploy

3. **Automatic Deployments**:
   - Every push to `main` triggers a production deployment
   - Pull requests create preview deployments

### Deploy to Netlify

1. **Create `netlify.toml`**:
   ```toml
   [build]
     command = "npm run build"
     publish = ".next"

   [[plugins]]
     package = "@netlify/plugin-nextjs"
   ```

2. **Deploy**:
   - Connect repository at [app.netlify.com](https://app.netlify.com)
   - Configure build settings
   - Deploy

### Deploy to Other Platforms

Next.js supports many deployment platforms:
- **AWS Amplify**: Follow [Next.js deployment docs](https://nextjs.org/docs/deployment)
- **Google Cloud Run**: Use Docker container
- **Self-hosted**: Use `npm run build && npm run start`

---

## Environment Variables

Create `.env.local` for local development (never commit this file):

```bash
# Optional: Google Analytics
NEXT_PUBLIC_GA_ID=G-XXXXXXXXXX

# Optional: External API keys
SPOTIFY_CLIENT_ID=your_spotify_client_id
YOUTUBE_API_KEY=your_youtube_api_key
```

For production, add these to your deployment platform's environment settings.

---

## Useful Scripts

Add to `package.json`:

```json
{
  "scripts": {
    "dev": "next dev",
    "build": "next build",
    "start": "next start",
    "lint": "next lint",
    "test": "playwright test",
    "test:ui": "playwright test --ui",
    "generate-blur": "node scripts/generate-blur-data.js"
  }
}
```

Create `scripts/generate-blur-data.js`:

```javascript
const sharp = require('sharp');
const fs = require('fs/promises');
const path = require('path');

async function generateBlurDataURL(imagePath) {
  const buffer = await sharp(imagePath)
    .resize(10, 10, { fit: 'inside' })
    .jpeg({ quality: 50 })
    .toBuffer();

  return `data:image/jpeg;base64,${buffer.toString('base64')}`;
}

async function processGallery() {
  const galleryPath = path.join(__dirname, '../src/data/gallery.json');
  const gallery = JSON.parse(await fs.readFile(galleryPath, 'utf-8'));

  for (const image of gallery) {
    const imagePath = path.join(__dirname, '../public', image.src);
    const blurDataURL = await generateBlurDataURL(imagePath);
    image.blurDataURL = blurDataURL;
    console.log(`Generated blur for: ${image.id}`);
  }

  await fs.writeFile(galleryPath, JSON.stringify(gallery, null, 2));
  console.log('✅ Gallery blur placeholders generated');
}

processGallery().catch(console.error);
```

---

## Troubleshooting

### Common Issues

**Issue**: `Module not found: Can't resolve '@/...'`
- **Fix**: Ensure `tsconfig.json` has correct path mapping:
  ```json
  {
    "compilerOptions": {
      "paths": {
        "@/*": ["./src/*"]
      }
    }
  }
  ```

**Issue**: Tailwind styles not applying
- **Fix**: Verify `tailwind.config.ts` has correct content paths
- **Fix**: Ensure `globals.css` imports Tailwind directives

**Issue**: SVG imports not working
- **Fix**: Check `next.config.js` webpack configuration for SVGR
- **Fix**: Ensure `@svgr/webpack` is installed

**Issue**: Images not optimizing
- **Fix**: Verify `next/image` component is used (not `<img>`)
- **Fix**: Check image paths are correct (relative to `/public/`)

**Issue**: Playwright tests failing
- **Fix**: Ensure dev server is running (`npm run dev`)
- **Fix**: Check baseURL in `playwright.config.ts` matches server URL

### Getting Help

- **Next.js Docs**: https://nextjs.org/docs
- **Tailwind Docs**: https://tailwindcss.com/docs
- **Playwright Docs**: https://playwright.dev/docs/intro
- **Project Issues**: File an issue in your repository

---

## Next Steps

After completing this quickstart:

1. **Review the spec**: Read `specs/001-singer-website/spec.md`
2. **Review data model**: Read `specs/001-singer-website/data-model.md`
3. **Start implementation**: Follow `specs/001-singer-website/tasks.md` (generated by `/speckit.tasks`)
4. **Customize content**: Update JSON files in `src/data/`
5. **Add images**: Place optimized images in `public/images/`
6. **Test**: Run Playwright tests to verify functionality
7. **Deploy**: Push to GitHub and deploy to Vercel

---

## Quick Reference

### File Structure
```
singer-website/
├── src/
│   ├── app/                 # Next.js App Router
│   │   ├── layout.tsx       # Root layout
│   │   ├── page.tsx         # Homepage
│   │   └── globals.css      # Global styles
│   ├── components/
│   │   ├── layout/          # Header, Footer
│   │   ├── sections/        # Page sections
│   │   └── ui/              # Reusable components
│   ├── data/                # Content JSON files
│   ├── lib/                 # Utilities
│   └── styles/              # Additional styles
├── public/
│   ├── logo.svg             # Site logo
│   └── images/              # Optimized images
├── tests/
│   └── e2e/                 # Playwright tests
├── next.config.js           # Next.js configuration
├── tailwind.config.ts       # Tailwind configuration
├── playwright.config.ts     # Playwright configuration
└── package.json             # Dependencies
```

### Key Commands
```bash
npm run dev          # Start development server
npm run build        # Build for production
npm run start        # Start production server
npm run lint         # Run ESLint
npx playwright test  # Run E2E tests
npm run generate-blur # Generate blur placeholders
```

### Key URLs
- **Development**: http://localhost:3000
- **Playwright UI**: http://localhost:3000 (after `npx playwright test --ui`)
- **Test Report**: `playwright-report/index.html`

---

**Ready to build!** Follow the tasks in `specs/001-singer-website/tasks.md` for step-by-step implementation guidance.
