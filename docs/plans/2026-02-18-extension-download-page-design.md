# Extension Download Page — Design Plan

**Date:** 2026-02-18
**Status:** Draft

## Goal

Create a page at `moxifymtg.com/#/extensions` where users can download and install the Moxfield Sync browser extension manually. Later, links will be updated to point to the official extension stores instead.

## Page URL

`/#/extensions` — new Flutter route in the website app (hash routing).

## Page Layout

The page follows the existing website design language (dark theme, Moxify branding).

### Content Structure

```
┌──────────────────────────────────────────┐
│  Moxify logo + "Moxfield Sync"           │
│                                          │
│  Short description of what the           │
│  extension does (2-3 sentences)          │
│                                          │
│  ┌────────────┐  ┌────────────┐          │
│  │  Chrome /   │  │  Firefox   │          │
│  │  Edge /     │  │            │          │
│  │  Brave      │  │            │          │
│  │             │  │            │          │
│  │ [Download]  │  │ [Download] │          │
│  │             │  │            │          │
│  │ Install     │  │ Install    │          │
│  │ instructions│  │ instructions│         │
│  └────────────┘  └────────────┘          │
│                                          │
│  "Coming soon to the Chrome Web Store    │
│   and Firefox Add-ons"                   │
└──────────────────────────────────────────┘
```

### Description Text

> Moxify Sync connects your Moxify app with your Moxfield account. Export decks and binders from Moxfield into Moxify, or import your Moxify collection to Moxfield — all through a simple QR code scan.

### Browser Cards

Two cards side by side (responsive, stack on mobile):

#### Chrome / Edge / Brave card
- Chrome logo or generic "Chromium" icon
- Label: "Chrome, Edge & Brave"
- Download button: links to `/extensions/moxfield-sync-chrome.zip`
- Install instructions (collapsed/expandable or inline):
  1. Download the zip file
  2. Unzip the file to a folder on your computer
  3. Open `chrome://extensions` (or `edge://extensions` / `brave://extensions`)
  4. Enable "Developer mode" (toggle in top-right)
  5. Click "Load unpacked" and select the unzipped folder
  6. Navigate to moxfield.com — the Moxify button appears in the navigation bar

#### Firefox card
- Firefox logo
- Label: "Firefox"
- Download button: links to `/extensions/moxfield-sync-firefox.zip`
- Install instructions (collapsed/expandable or inline):
  1. Download the zip file
  2. Open `about:addons` in Firefox
  3. Click the gear icon and select "Install Add-on From File..."
  4. Select the downloaded zip file
  5. Navigate to moxfield.com — the Moxify button appears in the navigation bar

### Future: Store Links

When the extension is published to the stores, replace the download buttons and instructions with direct store links:
- Chrome Web Store badge/link
- Firefox Add-ons badge/link
- Edge Add-ons badge/link

The static zip files in `web/extensions/` can remain as fallback downloads.

## Implementation Steps

### 1. Create the route
- Add `/extensions` route in `lib/app_router.dart`
- Create `lib/extensions/extensions_page.dart`

### 2. Build the page
- Reuse existing website theme and layout patterns (look at homepage or app_deeplink page for reference)
- Two browser cards with download links and install instructions
- Responsive: cards side by side on desktop, stacked on mobile
- Download links point to `/extensions/moxfield-sync-chrome.zip` and `/extensions/moxfield-sync-firefox.zip`

### 3. Static files
- Already handled by the Moxify build script (`npm run build` copies zips + `firefox-updates.json` to `web/extensions/`)
- Ensure `_config.yaml` includes the extensions directory if needed for GitHub Pages

### 4. Test
- `fvm flutter run -d chrome` to verify page renders
- Verify download links work (files serve correctly from `web/extensions/`)

## File Changes Summary

| File | Change |
|------|--------|
| `lib/app_router.dart` | Add `/extensions` route |
| `lib/extensions/extensions_page.dart` | New page widget |
| `web/extensions/` | Static files (already populated by Moxify build script) |
| `_config.yaml` | May need to include `extensions` directory |
