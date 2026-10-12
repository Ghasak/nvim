---
id: 2026-10-12-01
date: 2026-10-12
title: avante spec — add the missing mega.cmdparse + mega.logging dependencies
status: done
scope: [config, plugins]
commit: nvim 0a993ae on hotfix/avante-mega-deps, merged into main as 1fc6d8a
---

# 2026-10-12 — avante mega deps

## What changed

- `lua/plugins/pluginsHub.lua:1227` — added to the avante spec's dependency list:
  `{ "ColinKennedy/mega.cmdparse", dependencies = { "ColinKennedy/mega.logging" } }`
  (placement and shape copied from upstream `avante.nvim` README:211).
- Both plugins installed (`:Lazy! install`); the lockfile now pins them
  (`mega.cmdparse` 47ea5b1b…, `mega.logging` 194ad8c3…, lines 41-42).
- Nothing else. Avante stays at 4f49656.

## Why

Today's `:Lazy update` moved avante to 4f49656, whose `plugin/avante.lua:142` does a
top-level `require("mega.cmdparse")` for the new `AvanteSwitchProvider` command. Our spec
lists avante's dependencies by hand and was missing the two new ones, so on the first
`InsertEnter` the plugin file died there and lazy.nvim showed
`Failed to source .../avante.nvim/plugin/avante.lua` with `module 'mega.cmdparse' not found`
(the owner's screenshot: "megam_cmpbase" was the blur of `mega.cmdparse`).

## Proof

- Markers before the fix: `avante_loaded=1 AvanteCmd=0 SwitchProvider=0` — `avante_loaded` is
  set at `plugin/avante.lua:13`, i.e. *before* the failing require, which is why a plain
  `Lazy load` looked "clean".
- pty raw before: contains the failing popup text (`module 'mega.cmdparse' not fou…`) around
  the first insert in a fresh session.
- After: markers `avante_loaded=1 AvanteCmd=2 SwitchProvider=2 mega=true`; pty raw after a full
  insert+typing session: 0 occurrences of `mega.cmdparse`, 0 of `Failed to source`.
- Lockfile lines 41-42 pin both plugins; clean startup
  (`nvim --headless "+messages" +qa`) prints nothing.

## Follow-ups

- Avante reads `CLAUDE.md` as an instructions file (`avante/utils/prompts.lua:206-217`); the
  owner's "CLAUDE.md flashes when a session opens" was most likely the telescope preview of
  that file plus the broken-avante popup. Ask the owner to confirm it is gone on a fresh
  session.

## Rollback

- Remove the one dependency line and `:Lazy clean mega.cmdparse mega.logging`.
