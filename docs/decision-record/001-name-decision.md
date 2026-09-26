# 1. Name selection

- **Status:** Accepted
- **Date:** 2026-09-25 - 2026-09-26
- **Deciders:** João V. Farias
- **Decision:** What will be the name of the project?

## Context

The project is a shell for the [Quickshell](https://quickshell.org/) engine, which claims to be the "building blocks for your desktop."

It's longer description details how it claims to work: "toolkit for building status bars, widgets, lockscreens, and other desktop components using QtQuick. It can be used alongside your wayland compositor or window manager to build a complete desktop environment."

I have previously used and built a simple shell using the [aylurs-gtk-shell](https://aylur.github.io/ags-docs/) project, I named it `lovemii`, which is currently running because this one with _quickshell_ is not yet ready for production use.

The old shell had the following features:

- four black rounded corners widgets radius to make the monitor appear rounded;
- a top bar with a icon for the current window in that monitor, title, clock, date, workspace switcher, and a system tray;
- launcher for applications;
- calendar widget with Google Calendar integration that opens when clicking on the date in the top bar.

I intend to implement the same features in this new shell alongside some new ones, such as:

- overview of all the workspaces with all windows in it of the monitor, and the ability to switch between them;
- a new system tray with a better design and more features;
- a new launcher with a better design and more features.

## Requirements and restrictions

- The name should be short, easy to remember, and easy to pronounce;
- The name should be unique and not already used by another project or product.

## Decision

The decision is to keep the name `lovemii` for this new shell, as it is already known and used, and it has a good meaning behind it.

## Consequences

### Positives

- The name is already known and used by the community, which can help with adoption and recognition;
- The name has a good meaning behind it, which can help with branding and marketing.

### Negatives

- The name is not very descriptive of what the project is or does, which can make it harder for new users to understand what it is about;
- The name is not very unique, which can make it harder to find information about the project online.

