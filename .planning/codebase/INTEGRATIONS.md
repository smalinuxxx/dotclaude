# External Integrations

**Analysis Date:** 2026-02-02

## Overview

The singer portfolio website and FAQ chatbot projects utilize select third-party integrations for media streaming, social platforms, and ticketing. The architecture is designed to minimize external dependencies - using embedded players and links rather than complex API integrations.

## APIs & External Services

### Music Streaming Platforms

**Spotify:**
- What it's used for: Stream singer's music, display embed player on website
- SDK/Client: Embedded player via iframe (no API client needed)
- Integration: Embed URL format: `https://open.spotify.com/embed/track/{track_id}`
- Authentication: No authentication required (public embeds)
- Data Model: `music.json` stores `url` and `embedUrl` fields

**Apple Music:**
- What it's used for: Stream and link to singer's music library
- SDK/Client: Embedded player via iframe (no API client needed)
- Integration: Embed URL format: `https://embed.music.apple.com/us/album/{album_id}`
- Authentication: No authentication required (public embeds)
- Data Model: `music.json` stores `url` and `embedUrl` fields

**YouTube:**
- What it's used for: Music videos and live performance videos
- SDK/Client: YouTube embedded player (iframe)
- Integration: Video embeds via YouTube iframe embed syntax
- Optimization: @next/third-parties YouTube embed component for performance
- Authentication: No authentication required (public videos)
- Data Model: `music.json` stores video URLs and thumbnails

### Ticket & Event Platforms

**Ticketmaster (Assumed):**
- What it's used for: Ticket purchasing for concert events
- SDK/Client: Link-based integration (no API client needed)
- Integration: External links to Ticketmaster event pages
- Authentication: None (users redirected to platform)
- Data Model: `events.json` stores `ticketUrl` field pointing to Ticketmaster

**Eventbrite (Assumed):**
- What it's used for: Alternative ticket platform for smaller venues
- SDK/Client: Link-based integration
- Integration: External links to event pages
- Authentication: None (users redirected to platform)
- Data Model: `events.json` supports alternative `ticketUrl`

**Venue-Specific Systems:**
- What it's used for: Direct venue ticketing (Royal Albert Hall, Blue Note, etc.)
- SDK/Client: Link-based integration
- Integration: Direct links to venue box office
- Authentication: None (users redirected to venue)
- Data Model: `events.json` flexible `ticketUrl` field

## Data Storage

**Content Storage:**

**Local JSON Files (Primary):**
- Location: `src/data/` directory
- Files:
  - `profile.json` - Singer biographical info, contact details
  - `music.json` - Streaming links and embedded media items
  - `gallery.json` - Photo gallery with captions and metadata
  - `events.json` - Tour dates, venues, ticket links
  - `social.json` - Social media platform links and profiles
- Format: JSON with strict schema validation
- Built-in: Loaded at Next.js build time (static generation)
- No database backend required

**Image Storage:**
- Location: `/public/images/` directory (served statically)
- Subdirectories:
  - `/public/images/hero/` - Hero section images
  - `/public/images/gallery/` - Gallery photo collection
  - `/public/images/music/` - Album artwork and thumbnails
  - `/public/images/about/` - Profile/about section images
- Optimization: Processed by Next.js Image component (AVIF, WebP, JPEG)
- Serving: Next.js built-in CDN or Vercel edge network

**Logo/Brand Assets:**
- Format: SVG (scalable vector graphics)
- Location: `/public/logo.svg`
- Integration: @svgr/webpack converts SVG to React component
- Benefits: Zero-size bitmap fallback, resolution-independent

**No External Database:**
- Current scope: Static site generation
- No persistent user data storage
- No backend database required
- Future consideration: May add database if FAQ chatbot needs persistence

## Authentication & Identity

**For Singer Website:**
- Auth Provider: None (public website, no user accounts)
- Public access: All content fully accessible without login

**For FAQ Chatbot (Future):**
- Auth approach: Likely sessionless (no user login required)
- Session tracking: Optional conversation history per session
- User data: Minimal (conversation context only)
- Privacy: Session-only storage (no persistent user profiles)

## External Links & Third-Party Services

**Social Media Platforms:**

Listed in `social.json`:
- Instagram - Direct profile links
- YouTube - Channel and video links
- TikTok - Profile links
- Twitter/X - Profile links
- Facebook - Profile links
- LinkedIn - Profile links
- Spotify - Artist profile link
- SoundCloud - Artist profile link

Integration:
- SDK/Client: None (simple `<a href>` links)
- Security: `rel="noopener noreferrer"` applied to all external links
- Tracking: No analytics SDK integrated
- Authentication: None required (public profiles)

## Monitoring & Observability

**Error Tracking:**
- Current: None configured
- Consideration: Sentry, LogRocket, or similar for production monitoring

**Logs:**
- Development: Browser console, Next.js dev server logs
- Production: Vercel built-in logs (if deployed to Vercel)
- Approach: Standard HTTP access logs from hosting platform

**Analytics (Optional Future):**
- Google Analytics (not currently integrated)
- Vercel Analytics (available if using Vercel)
- No user tracking currently implemented

## CI/CD & Deployment

**Hosting Platform:**
- Primary: Vercel (optimal for Next.js, mentioned in specs)
- Alternative: Netlify, GitHub Pages (static export), AWS Amplify, etc.

**Git Workflow:**
- Repository: Feature-branch based (001-singer-website, 001-faq-chatbot)
- CI Pipeline: Vercel automatic deployments on git push
- Build: Next.js build process (`npm run build`)
- Testing: Playwright E2E tests (if configured in Vercel build)

**Deployment Triggers:**
- Automatic: On push to main or feature branches
- Build time: ~2-5 minutes (Next.js build + image optimization)
- Content updates: Require code commit and redeploy (no headless CMS)

**No External CI/CD:**
- Not configured: GitHub Actions, GitLab CI, Jenkins, etc.
- Current: Relies on Vercel's built-in CI/CD

## Environment Configuration

**Required Environment Variables:**
- Development: None required (all content local)
- Production: None required for singer website
- Future additions for chatbot:
  - `NEXT_PUBLIC_API_URL` - Backend API endpoint
  - `API_KEY` - Authentication for chatbot API

**Optional Configuration:**
- `NEXT_PUBLIC_GA_ID` - Google Analytics ID (if added)
- `SENTRY_DSN` - Error tracking (if added)

**Secrets Management:**
- Development: None needed (public content only)
- Production: Via Vercel environment variables dashboard
- No `.env` files in repository (all public constants)

## Webhooks & Callbacks

**Incoming Webhooks:**
- Current: None
- Potential future: Webhook for content updates from external CMS (if added)

**Outgoing Webhooks:**
- Current: None

**Contact/Inquiry Flow:**
- Singer website: Email form submission (no backend processing)
- FAQ chatbot: Escalation email or form submission to support email
- No webhook callbacks currently implemented

## Rate Limits & Quotas

**Streaming Platform Embeds:**
- Spotify: No rate limit for public embeds
- Apple Music: No rate limit for public embeds
- YouTube: No rate limit for public embeds (server-side rendering safe)

**Ticketing Platforms:**
- Ticketmaster: Rate limits apply to API calls (not used, only links)
- Eventbrite: Rate limits apply to API calls (not used, only links)

## Security & Privacy

**External Link Security:**
- All third-party links: `rel="noopener noreferrer"` attribute
- Purpose: Prevent opener attack vulnerabilities
- Scope: Social media, streaming platforms, ticketing sites

**Embed Security:**
- Spotify embeds: Iframe sandboxed (standard)
- YouTube embeds: Iframe sandboxed (standard)
- Content Security Policy: To be configured in Next.js

**Data Privacy:**
- No user data sent to external services (except social media links)
- No analytics tracking (by default)
- No cookies or tracking pixels

## Content Dependencies

**Required External Content:**
1. **Streaming Playlist/Track URLs** - Spotify, Apple Music, YouTube links
   - Maintained manually in `music.json`
   - No automatic sync with streaming platforms
   - Must be updated manually if URLs change

2. **Ticket Platform URLs** - Ticketmaster, Eventbrite, venue box offices
   - Maintained manually in `events.json`
   - Update required when new events announced
   - Manual process (no API sync)

3. **Social Media Profile Links** - Instagram, Twitter, YouTube, etc.
   - Maintained manually in `social.json`
   - Update required if handles/URLs change
   - Manual process

4. **Image Assets** - Hero, gallery, media artwork
   - Stored locally in `/public/images/`
   - Requires image files from singer/photographer
   - Manual upload and processing

**Content Not Externally Dependent:**
- Singer biography (local `profile.json`)
- Event dates and descriptions (local `events.json`)
- Gallery captions (local `gallery.json`)
- All styling and layout (local component code)

## Future Integration Opportunities

**Potential Additions:**
- Email subscription service (SendGrid, Mailchimp)
- Booking system (Calendly, custom backend)
- Fan club membership (Patreon, Memberful)
- Backend database (PostgreSQL via Supabase, Firebase)
- Content management system (Sanity, Contentful, Strapi)
- Real-time chat/messaging (Socket.io, Firebase Realtime)
- Analytics dashboard (Google Analytics, Vercel Analytics)

---

*Integration audit: 2026-02-02*
*Update when adding new external services or platforms*
