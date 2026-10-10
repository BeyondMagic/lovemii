# 007: License selection

- **Status:** Accepted
- **Date:** 2026-10-03
- **Deciders:** João V. Farias
- **Decision:** Which open-source license will govern the lovemii project?

## Context

Choosing a software license determines how others can run, modify, fork, and distribute `lovemii`. Because this shell is a personal open-source project intended for the Wayland desktop community, I need to decide between permissive licensing (such as MIT or Apache 2.0) and strong copyleft licensing (such as GPLv3 or AGPL-3.0).

I want the code to be freely accessible, but I also want to make sure that any future forks or modifications remain open to everyone rather than being packaged into closed-source or proprietary distributions.

## Requirements and restrictions

- The project must remain free and open source in perpetuity;
- Any improvements, modifications, or derivative works created by others must be shared under the same license terms;
- Protection must extend to modifications even if the software is modified and run over a network or remote desktop setup;
- Compatibility with standard Linux desktop open-source components.

## Decision

I have chosen the **GNU Affero General Public License version 3.0** (AGPL-3.0-or-later).

All project code, widget definitions, and documentation are published under AGPL-3.0. Anyone who uses or redistributes `lovemii` is free to inspect, modify, and run the code, but any derivative works or distributed versions must release their complete source code under the same terms.

## Consequences

### Positives

- Strong copyleft guarantees that improvements made by contributors or downstream forks return to the community;
- Prevents third parties from turning the shell into proprietary, closed-source software;
- The network clause in AGPL closes the software-as-a-service loophole, ensuring transparency if the shell components are ever deployed in remote desktop environments;
- Aligns with the broader free software philosophy common across the Linux and Wayland desktop ecosystem.

### Negatives

- Strong copyleft can discourage people or organizations that strictly prefer permissive licenses like MIT;
- Cannot be mixed into closed-source proprietary software packages.
