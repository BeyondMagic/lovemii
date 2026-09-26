# 2. UI design system

- **Status:** Accepted
- **Date:** 2026-09-26
- **Deciders:** João V. Farias
- **Decision:** What will be the visual UI design system (colors, surfaces, typography, opacity, affordances)?

## Context

Following the project name decision ([001](./001-name-decision.md)), the `lovemii` shell requires a cohesive, purposeful visual identity. The goal is to build an interface that feels lightweight, modern, and uncluttered, drawing aesthetic inspiration from both GNOME (Adwaita's clean curves, edge treatment, and restrained simplicity) and Apple macOS/iOS (Human Interface Guidelines' emphasis on typography hierarchy, dynamic opacity, and subtle layer contrast).

This record establishes the visual design (UI) rules and tokens—specifically color palettes, surface treatments, typography scales, opacity tiers, and clickability affordances. User interaction flows (UX) will be addressed separately.

## Requirements and restrictions

- **Aesthetic:** Minimalist, sleek, modern dark mode inspired by GNOME and Apple design philosophies;
- **Palette:** Pure pitch black foundation (`#000000`) for OLED-friendly aesthetics and deep contrast, with white text and elements;
- **Affordance & Hierarchy:** Rely primarily on typography attributes (size, weight, style, casing) and opacity levels (grayish tints through alpha transparency) rather than heavy borders, colorful badges, or noisy backgrounds to differentiate interactive vs. static content and relative importance;
- **Semantic Restraint:** Core UI must be strictly monochrome; colors are strictly reserved for critical system states (errors, critical warnings);
- **Legibility & Scalability:** High readability at both small desktop bar sizes and larger overlay/window scales.

## Decision

The UI design system for `lovemii` is established with the following specifications:

### 1. Color Palette & Surfaces

- **Base Background:** Pitch Black (`#000000`) for the primary backdrop, floating cards, and widget surfaces.
- **Surface Boundaries:** 1px hairline border using low-opacity white (`rgba(255, 255, 255, 0.08)` to `rgba(255, 255, 255, 0.12)`). No thick or solid opaque borders.
- **Corner Radii:** Rounded corners of 12px to 16px for windows, panels, and floating cards; 6px to 8px for smaller interactive elements (inputs, pills).
- **Color Accents:** Strictly monochrome (pure white at varying opacities). Colored accents are disallowed in UI chrome, navigation, and regular text, reserved solely for critical system alerts (e.g., desaturated red for errors, amber for urgent battery/system warnings).

### 2. Typography Foundation

- **Font Family:** Clean, neutral modern sans-serif with high legibility at micro sizes (e.g., `Inter`, `SF Pro Display/Text`, with system sans-serif fallback).
- **Type Scale:**
  - **Large / Title:** 18px – 20px (window titles, prominent clock, headline values).
  - **Body / Primary Label:** 13px – 14px (standard widget labels, menu items, main text).
  - **Caption / Secondary:** 11px – 12px (subtitles, secondary info, timestamps, status labels).
  - **Micro / Metadata:** 9px – 10px (category headers, fine metadata, keyboard shortcuts).

### 3. Opacity Tiers (Text & Visual Importance)

Visual hierarchy is communicated through alpha transparency against the pitch black background rather than fixed gray hex colors:

- **Primary (100% / `1.0`):** `#FFFFFF` — Primary active content, focused items, high-importance labels, clock time.
- **Secondary (70% / `0.70`):** `rgba(255, 255, 255, 0.70)` — Regular body copy, standard inactive labels, non-highlighted information.
- **Tertiary (45% / `0.45`):** `rgba(255, 255, 255, 0.45)` — Captions, timestamps, secondary hints, descriptive metadata.
- **Quaternary / Disabled (20%–30% / `0.25`):** `rgba(255, 255, 255, 0.25)` — Disabled controls, placeholder text, inactive dividers.

### 4. Clickability & Interaction Affordances

To clearly distinguish clickable/actionable elements from static informative text without visual clutter:

- **Weight Pairing:**
  - *Static text* uses standard weight (`Font.Normal` / 400).
  - *Clickable items* use medium or semibold weight (`Font.Medium` / 500 or `Font.DemiBold` / 600).
- **Interactive State Transitions:**
  - **Default:** Clickable elements sit at Secondary opacity (70%–80%) with medium weight.
  - **Hover:** Transitions smoothly to 100% brightness (white `1.0`), providing instant visual feedback.
  - **Active / Pressed:** Brief dimming (down to ~85%) or subtle micro-scale (0.98) feedback.
  - **Focused:** Outlined or emphasized with a subtle hairline highlight.

### 5. Font Styles & Decorations

- **Section Headers & Categories:** Uppercase with subtle positive letter spacing (`letterSpacing: 0.5px` to `1.0px`), at Micro/Caption size with Tertiary opacity (45%).
- **Metadata & Placeholders:** Optional subtle italicization reserved strictly for empty states, placeholders, or contextual hints.
- **Underlines:** Strictly forbidden for standard text or buttons; reserved solely for explicit inline hyperlinks on hover.

## Consequences

### Positives

- **High Focus & Low Distraction:** The pitch-black aesthetic and monochrome hierarchy reduce cognitive load and screen glare.
- **Consistent Mental Model:** By standardizing opacity tiers and weight pairing, users intuitively perceive what is clickable versus what is informational.
- **OLED / Power Efficiency:** Pure `#000000` base minimizes power usage on OLED/mini-LED displays and achieves true infinite contrast.
- **Timeless Aesthetic:** Drawing from Apple and GNOME creates a polished, premium desktop environment that blends seamlessly with modern Wayland compositors.

### Negatives

- **Low-Contrast Risk:** High ambient lighting or poorly calibrated monitors may make tertiary/quaternary opacity tiers harder to distinguish. Text sizes and contrast ratios must be monitored for WCAG compliance.
- **Restricted Expressiveness:** Disallowing colored accents requires careful craftsmanship in spacing, weight, and typography to avoid looking flat or ambiguous.
