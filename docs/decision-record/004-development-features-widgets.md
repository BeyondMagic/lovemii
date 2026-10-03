# 004: Development of features and widgets

- **Status:** Accepted
- **Date:** 2026-10-03
- **Deciders:** João V. Farias
- **Decision:** What is the development process for features and widgets? How will they be designed, implemented, and maintained?

## Context

In my previous shell, widgets and features were built ad-hoc. I often started by writing code directly, which meant figuring out interaction rules and visual layouts halfway through implementation. That led to wasted effort, awkward edge cases, and having to rewrite components after discovering that a flow did not work well in practice.

For this rewrite in Quickshell, I want a disciplined workflow. Deciding how a user interacts with a feature before writing code keeps components focused, prevents bloated widgets, and makes sure visual designs match actual use cases.

## Requirements and restrictions

- The interaction flow is the first priority, written step-by-step in a use-case format;
- The visual design is the second priority, translating the interaction steps into Figma mockups and wireframes;
- The implementation plan is the third priority, detailing dependencies, performance budgets, and technical constraints;
- Every feature must be documented in a single file inside `docs/feature/` using the `XXX-feature-name.md` naming format, following the [template](../feature/000-template.md).

## Decision

I am adopting a three-stage development process for all features and widgets in `lovemii`:

1. **Interaction flow:** Before creating graphics or writing code, write down the complete user flow in `docs/feature/XXX-feature-name.md`, follow [003](./003-ux-behavior-interaction-flows.md);
2. **Visual design:** Once the flow is clear, create Figma wireframes or mockups that fit the steps and follow the visual design rules in [002](./002-ui-design-decision.md);
3. **Implementation plan:** Outline the technical details, required Quickshell or QtQuick APIs, external system tools, and performance limits;
4. **Lifecycle tracking:** The feature proposal starts as **Proposed**. Development begins only after the flow and design are settled and marked as **Accepted** in the [feature list](../feature/README.md).

## Consequences

### Positives

- Planning the interaction flow first prevents rewriting code when edge cases appear;
- UI components stay consistent because mockups follow settled user steps instead of guesswork;
- Technical constraints and missing dependencies are caught before implementation begins;
- Clear documentation makes it easy to review why a feature works the way it does.

### Negatives

- Small adjustments and quick experiments take longer because of the extra documentation step;
- Documentation files must be kept up to date as features evolve over time.
