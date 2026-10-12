---
id: 2026-10-12-03
date: 2026-10-12
title: Light-theme indent guides go faint, and the theme spec returns to GitHub
status: done
scope: [theme, config, docs]
commit: githubG.nvim ce469ff on main (pushed)
---

## What changed

**Theme `githubG.nvim`, `main`, `ce469ff` — merged from `feature/glight`, pushed to origin:**

- The indent guide bars are drawn by snacks.nvim with the group `SnacksIndent`. The theme never
  defined that group, so snacks' own default linked it to `NonText`, which the theme sets to
  `c.grey` — `#636c76` in `glight`. That is 5.33:1 on white, and the bars read as solid black.
  `lua/onedark/highlights.lua:769` now defines the group:
  `SnacksIndent = { fg = light and c.bg3 or c.grey }`. In `glight` that resolves to `bg3` =
  `#d0d7de`, 1.45:1. No palette key was added, so the `glight`/`gdark` key parity that
  `check.lua:28-32` enforces cannot fire.
- The cursor-block bar, `SnacksIndentScope`, moved from `#59636e` to `#afb8c1`
  (`lua/onedark/palette.lua:49`): 6.11:1 to 2.01:1. One step darker than the guides, so the
  "where am I" cue still reads while both go faint.
- `scripts/check.lua` holds every group whose name contains `Indent` to a 3.0 contrast floor.
  Both new values sit below it on purpose, so each got a reasoned entry in the `KNOWN` table,
  which prints them with their measured ratio on every run. **No threshold moved.** The comment
  above `KNOWN` was reworded: its old claim, "failures no palette value can fix", no longer
  described the table, because these two *are* palette choices held low on purpose.

**This config:**

- `lua/plugins/pluginsHub.lua:3` — the GitHub spec `"ghasak/githubG.nvim"` is restored and the
  local `dir` override is gone. That closes `TEMP(T9)` from 2026-10-07-01, which said not to
  restore the spec until `feature/glight` was merged into the theme's `main`. It now is.

## Why

The owner reported the light-theme indent guides as "super solid black" and asked for gray,
almost invisible, light theme only, and coming from the theme rather than from a config
override. The measured cause was 5.33:1 for the guides and 6.11:1 for the block bar. Every real
light theme draws indent guides as a faint border tint.

## Proof

- Culprit and fix, at runtime on `NVIM v0.12.6` through the owner's real config. Before the
  change `SnacksIndent` resolved to a live `link = "NonText"` giving `#636c76`. After:
  `REAL SnacksIndent=#d0d7de SnacksIndentScope=#afb8c1`
  Command: `cd /Users/gmbp/.config/nvim && timeout 90 nvim --headless -i NONE -c "lua vim.defer_fn(function() ... end, 3000)"`.
- Theme checker: `RESULT style=glight groups=712 checked=735 known=13 fails=0`, exit 0, with both
  exceptions printed at their measured ratios 1.45 and 2.01.
  Command: `nvim --clean --headless -i NONE --cmd "set rtp^=$PWD" -c "luafile $PWD/scripts/check.lua"`.
- Load order: both orders — theme then snacks then a `ColorScheme` refire, and snacks then theme
  then a refire — leave the group at `#d0d7de`, verified independently. snacks registers its
  defaults with `default = true`, which only fills an undefined group, so it cannot clobber a
  group the theme already set.
- Dark and the other seven styles did not move. An 8-row sweep of guide / nontext / scope, one
  nvim process per style, is character-identical to the table captured before the change, except
  the `glight` row. `gdark` stays `#5c6370`. Every non-`glight` row keeps `c.grey`, exactly what
  the old `NonText` link produced.
- Two deliberate breaks were seen failing, then restored byte-for-byte and confirmed with
  `shasum -a 256`. Removing the `light and c.bg3` branch returned the runtime value to `#636c76`.
  Reverting `indent_scope` moved the printed `KNOWN` ratio from 2.01 to 6.11.
- Four independent verifier agents, none able to see the others, all returned CONFIRMED.

**A correction to the plan.** The plan said the checker's `checked` tally would stay at 736. It
is 735. `SnacksIndentScope` was being checked and passing at 6.11:1 before; it now sits in
`KNOWN`, and KNOWN groups are not counted (`check.lua:95-99`), so the tally drops by one.
`groups` 711->712 and `known` 11->13 were as predicted, and `fails=0` in both runs.

**What is NOT verified.** Pixel-level rendering was never observed: headless nvim has no UI, so
the paint call (`snacks/indent.lua:163` uses the group name) and the group's resolved colour were
verified, not screen pixels. Only `NVIM v0.12.6` was tested, and only on macOS. The `KNOWN`
reason strings are static prose and will go stale if the values change.

## Follow-ups

- [ ] `KNOWN` is name-based and unconditional, so it waives both directions for the two indent
      groups: a future drift to a *darker* guide would still print a `KNOWN` line and stay green.
      A per-group expected-ratio ceiling would close that. Pre-existing property of the
      mechanism, now covering two more groups.
- [ ] The theme's `light` style still crashes on load: 58 palette keys missing. Pre-existing.
- [ ] The theme's `dark` style still crashes on load. Pre-existing. It also breaks any style
      sweep, which must skip it.
- [ ] The theme's `feature/glight` branch is merged but still exists, locally and on origin.
      Deleting it is the owner's call.
- [ ] `scripts/check.lua` audits `glight` only; it has no dark mode.
