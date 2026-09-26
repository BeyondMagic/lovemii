# 2. UI design system

- **Status:** Accepted
- **Date:** 2026-09-26
- **Deciders:** João V. Farias
- **Decision:** What will be the visual UI design system (colors, surfaces, typography, opacity, affordances)?

## Context

With the project name settled ([001](./001-name-decision.md)), I need a clear visual direction for `lovemii`. The old shell worked, but the visuals were thrown together as I went. For this rewrite, I want a minimalist dark interface inspired by GNOME and Apple: clean curves, black backgrounds, and strong typography.

This record covers the visual foundation: color, surfaces, type scales, opacity levels, and how clickable items look. Interaction flows and UX behavior will get their own record later.

## Requirements and restrictions

- Pure black background (#000000) for deep contrast and low power use on OLED screens;
- Light typography over dark surfaces, using white text with varying opacity;
- Rely on font weight, size, and opacity to show hierarchy and clickability instead of heavy borders, badges, or saturated background colors;
- Strictly monochrome for the interface chrome and text. Color is reserved for critical system warnings or errors;
- Crisp legibility at small sizes on the top bar and larger widget scales.

## Decision

I am setting the visual design rules for `lovemii` as follows:

### Colors and surfaces

- Background: Pure black (#000000) for the screen backing, window panels, and popups.
- Borders: 1px hairline border in low-opacity white (rgba(255, 255, 255, 0.08) to rgba(255, 255, 255, 0.12)). No solid gray borders.
- Radii: 12px to 16px corner radius for panels and floating windows; 6px to 8px for smaller interactive elements like input fields and tags.
- Accent colors: None in the main interface. Chrome, text, and icons stay grayscale. Subdued red and amber are allowed only for critical errors and battery alerts.

### Typography

Use a clean, neutral sans-serif with strong legibility at small sizes (Inter or SF Pro, falling back to the system sans font).

The type scale has four tiers:
- Title: 18px to 20px (clock, main headers)
- Body: 13px to 14px (standard labels, menu rows)
- Caption: 11px to 12px (subtitles, secondary info, timestamps)
- Micro: 9px to 10px (category titles, fine metadata)

### Opacity and hierarchy

White text opacity against the black background indicates priority:
- Primary (100% white, #FFFFFF): Active headers, primary labels, current time.
- Secondary (70% white, rgba(255, 255, 255, 0.70)): Standard body text and unhighlighted labels.
- Tertiary (45% white, rgba(255, 255, 255, 0.45)): Subtitles, timestamps, and secondary hints.
- Inactive (25% white, rgba(255, 255, 255, 0.25)): Disabled actions, placeholders, and subtle dividers.

### Clickable elements

Interactive text needs to stand out without cluttering the screen with button boxes:
- Font weight: Static labels use normal weight (400). Clickable items use medium (500) or semibold (600).
- Idle state: Clickable items rest at secondary opacity (around 75%) with medium weight.
- Hover state: Brightens to full white (100%) on hover for immediate feedback.
- Press state: Dims slightly (around 85%) or scales down by 2% on mouse down.

### Styles and decorations

- Section headers: Uppercase with wide letter spacing (0.5px to 1.0px) at micro or caption size, using tertiary opacity.
- Italics: Kept only for placeholders or empty-state text.
- Underlines: No underlines on buttons or UI text. Used only for hyperlinks on hover.

## Consequences

### Positives

- The pitch black surfaces and monochrome palette keep the shell clean, quiet, and easy on the eyes;
- Clear opacity and weight tiers make it obvious what is clickable without adding heavy button containers;
- Low power usage on OLED displays;
- Gives the desktop a cohesive look that matches modern GNOME and macOS styling.

### Negatives

- Low-opacity text (45% and 25%) might be hard to read on low-end displays or under bright glare;
- A strictly monochrome interface means spacing and type weights have to do all the heavy lifting, which leaves less room for sloppy layouts.
