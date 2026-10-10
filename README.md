<p align="center">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="documentation/assets/dark/logotype.svg">
    <source media="(prefers-color-scheme: light)" srcset="documentation/assets/light/logotype.svg">
    <img alt="lovemii logotype" src="documentation/assets/light/logotype.svg" width="360">
  </picture>
</p>

# lovemii

A minimalist desktop shell for Wayland, built with [Quickshell](https://quickshell.org/) and designed to run alongside [Hyprland](https://hypr.land/).

## Overview

`lovemii` is a desktop shell built around pure black surfaces, high-contrast typography, and opacity-based hierarchy.

## Documentation

Full project documentation, architectural decision records, and feature specifications are available on the documentation site:

- **Site:** [https://beyondmagic.github.io/lovemii/](https://beyondmagic.github.io/lovemii/)
- **Decision records:** [docs/decision-record/](documentation/content/decision-record/index.mdindex.md)
- **Feature specifications:** [docs/feature/](documentation/content/feature/index.md)

## Local preview

To run the documentation server locally:

```bash
cd docs
zensical serve
```

To start the shell with Quickshell:

```bash
quickshell
```

## License

GNU Affero General Public License v3.0 ([AGPL-3.0-or-later](./LICENSE)).