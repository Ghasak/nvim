# Backlog — change tracker for this config

One file per delivered change, plus this index. It exists so that a later session — a person or an
agent — can see what changed, why, what proved it, and what is still open, without reading the whole
repo again.

This tracker covers the whole setup, including work done in the theme plugin this config loads.

## Rules

- One entry per delivered change. **Append-only:** never rewrite or delete an entry, add a new one.
- Name an entry `YYYY-MM-DD-short-slug.md`, dated when the work was delivered, not started.
- Every entry carries the frontmatter below and these four sections: `What changed`, `Why`, `Proof`,
  `Follow-ups`.
- Add the row to the table here in the same commit as the entry.
- When a later entry closes a follow-up, mark it closed below. The old entry stays as written.
- Proof means a real command with its real output, or a `file:line`. If something was not verified,
  the entry says so. A tracker that only reports success is not worth keeping.

```yaml
---
id: YYYY-MM-DD-NN
date: YYYY-MM-DD
title: one line
status: done | partial | reverted
scope: [config, theme, plugins, lsp, docs]
commit: <repo> <sha> on <branch>
---
```

## Entries

| ID | Date | Title | Scope | Status |
|----|------|-------|-------|--------|
| [2026-10-07-01](2026-10-07-light-style-repair.md) | 2026-10-07 | Light style repair and the theme/config split | theme, config | done |

## Open follow-ups

| From | Item | Owner |
|------|------|-------|
| 2026-10-07-01 | The theme's `light` style crashes on load: 58 palette keys missing | later |
| 2026-10-07-01 | Dark owes 55 groups below 4.5:1, including `FidgetTitle` at 1.37:1 | later |
| 2026-10-07-01 | In light, `CursorLine` and `DiffChange` share `#ddf4ff` | later |
| 2026-10-07-01 | `Method` and `Struct` have no colour in either mode | later |
| 2026-10-07-01 | The bufferline palette is still owned by the config | later |
| 2026-10-07-01 | `scripts/check.lua` in the theme has no dark mode | later |
| 2026-10-07-01 | `TEMP(T9)` path override in `pluginsHub.lua` stays until the theme branch is merged | owner |
| 2026-10-07-01 | `feature/glight` in the theme repo is pushed but not merged into its `main` | owner |
