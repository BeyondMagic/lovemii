# Feature List

Specifications, interaction flows, and implementation notes for shell features are documented here.

## User flow architecture

The diagram below maps how users move through the shell, from initial boot to desktop interactions, persistent panel widgets, and overlay utilities:

```mermaid
flowchart TD
    subgraph BootAuth["Boot & Authentication"]
        Plymouth["001: Plymouth"]
        Login["002: Login"]
        Plymouth -->|Boot completed| Login
    end

    Login -->|Authenticate| Home["Home / Desktop Session"]

    subgraph Desktop["Desktop Session (Home)"]
        Home --- TrayWorkspace["005: Workspace Tray"]
        Home --- TraySystem["004: System Tray"]
        Home --- TimeTracker["006: Time Tracker"]
        Home --- MusicManager["013: Music Manager"]
    end

    subgraph Overlays["Overlays & Modals"]
        Launcher["009: Launcher"]
        Overview["008: Overview"]
        Notifications["007: Notifications"]
        PowerMenu["003: Power Management"]
        HabitTracker["010: Habit Tracker"]
        TaskTracker["011: Task Tracker"]
        OCR["012: OCR"]
    end

    Home -->|Hotkey / Click| Launcher
    Home -->|Hotkey / Gesture| Overview
    Home -->|Daemon event / Panel| Notifications
    Home -->|Hotkey / Status click| PowerMenu
    Home -->|Shortcut / Tray| HabitTracker
    Home -->|Shortcut / Tray| TaskTracker
    Home -->|Capture trigger| OCR

    PowerMenu -->|Lock| Login
    PowerMenu -->|Restart| Plymouth
    PowerMenu -->|Shutdown| PowerOff(["Power Off"])

    click Plymouth "./001-plymouth.md" "001: Plymouth"
    click Login "./002-login.md" "002: Login"
    click PowerMenu "./003-power-management.md" "003: Power Management"
    click TraySystem "./004-system-tray.md" "004: System Tray"
    click TrayWorkspace "./005-workspace-tray.md" "005: Workspace Tray"
    click TimeTracker "./006-time-tracker/index.md" "006: Time Tracker"
    click Notifications "./007-notifications.md" "007: Notifications"
    click Overview "./008-overview.md" "008: Overview"
    click Launcher "./009-launcher/index.md" "009: Launcher"
    click HabitTracker "./010-habit-tracker.md" "010: Habit Tracker"
    click TaskTracker "./011-task-tracker.md" "011: Task Tracker"
    click OCR "./012-ocr.md" "012: OCR"
    click MusicManager "./013-music-manager/index.md" "013: Music Manager"
```

## Features

| ID     | Date                    | Feature                             | Status   |
| :----- | :---------------------- | :---------------------------------- | :------- |
| 000    | 2026-10-03 - 2026-10-03 | [Template](000-template.md) | **Accepted** | 
| 001    | 2026-10-03 -            | [Plymouth](001-plymouth.md) | Proposed |
| 002    | 2026-10-03 -            | [Login](002-login.md) | Proposed |
| 003    | 2026-10-03 -            | [Power Management](003-power-management.md) | Proposed |
| 004    | 2026-10-03 -            | [System Tray](004-system-tray.md) | Proposed |
| 005    | 2026-10-03 -            | [Workspace Tray](005-workspace-tray.md) | Proposed |
| 006    | 2026-10-03 -            | [Time Tracker](006-time-tracker/index.md) | Proposed |
| 007    | 2026-10-03 -            | [Notifications](007-notifications.md) | Proposed |
| 008    | 2026-10-03 -            | [Overview](008-overview.md) | Proposed |
| 009    | 2026-10-03 -            | [Launcher](009-launcher/index.md) | Proposed |
| 010    | 2026-10-03 -            | [Habit Tracker](010-habit-tracker.md) | Proposed |
| 011    | 2026-10-03 -            | [Task Tracker](011-task-tracker.md) | Proposed |
| 012    | 2026-10-03 -            | [OCR](012-ocr.md) | Proposed |
| 013    | 2026-10-11 -            | [Music Manager](013-music-manager/index.md) | Planned |
| 014    | 2026-10-12 -            | [Service Manager](014-service-manager/index.md) | Proposed |

<!-- Task Tracker will supersede habit tracker -->

Legend:

- **Proposed**: the feature is under discussion and has not been approved yet;
- **Accepted**: the feature is approved and planned or actively being built;
- **Developed**: the feature is fully built and in active use;
- **Rejected**: the feature was considered but decided against;
- **Deprecated**: the feature was once in use but is no longer supported or recommended.