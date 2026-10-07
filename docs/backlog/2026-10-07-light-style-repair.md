---
id: 2026-10-07-01
date: 2026-10-07
title: Light style repair and the theme/config split
status: done
scope: [theme, config]
commit: githubG.nvim 209ab19 on feature/glight (pushed)
---

## What changed

**Theme `githubG.nvim`, branch `feature/glight`, commit `209ab19`, pushed to origin:**

- `CursorLine` was painted with the same colour as `Normal` in all eight styles, so the block on the
  current line never appeared. It now uses a palette key.
- Eight new palette keys, in every style: `panel`, `panel_fg`, `cursorline_bg`, `cursor_bg`, `cursor_fg`,
  `menu_bg`, `line_nr_bg`, `indent_scope`.
- 67 light-mode groups whose background equalled the page were repointed: menus, floats, tabline,
  winbar, statusline, sign column, diff view, mini bars, nvim-tree, barbar.
- The surface groups this config used to paint by hand are now owned by the theme: the Telescope window
  groups, fzf-lua (17 groups), nvim-dap-ui (6), nvim-notify (6), `SnacksIndentScope`, Glance, Blamer and
  telekasten (`tk*`).
- Cursor: `Cursor`, `iCursor`, `vCursor`, `lCursor`, `CursorIM` and `TermCursor` carry dark blue
  `#0550ae` with white text in light. `lua/onedark/init.lua` also sets `guicursor` for every mode,
  because a terminal takes the cursor colour from the group's background and reads `reverse` as "use
  the host terminal's own cursor". Turn it off with `set_guicursor = false`.
- `scripts/check.lua`, the WCAG contrast audit, now lives in the theme repo and is explained in its
  README.

**This config:**

- The light half of every colour patch is gone; those colours now come from the theme.
- The dark half of every patch is untouched, byte for byte. `after/plugin/features_loader.lua`,
  `gi_fzf.lua`, `gi_gitsigns_nvim.lua`, `gi_nvim_ufo.lua`, `gi_glance.lua`, `gi_blamer_nvim.lua` and
  `gi_telekasten_nvim.lua` were edited for that.
- Two comments that still said "moved to features_loader.lua" were corrected, in `init.lua` and
  `lua/settings/options.lua`.

**Small deliberate changes, light mode only:**

- `Blamer` blame text moved from `#848b98` (3.43:1 on white) to `#59636e` (6.11:1).
- `tkLink`, `tkTag` and `tkBrackets` use the palette blue, purple and grey. The old values measured
  2.53:1, 1.57:1 and 3.95:1 on white.

## Why

The light style was half finished: many groups drew the same colour as the page, so menus, floats and
the current-line block were invisible, and the terminal cursor never took the theme's colour. The
colours were also split across two places — the theme and this config — so a light fix had to be made
twice.

The rule from now on: colours belong to the theme. This config only wires plugins up and keeps the few
choices that are genuinely config-level.

## Proof

- Contrast audit on the theme: `fails=1` before, `fails=0` after, now covering 736 colours.
  Command: `nvim --clean --headless -i NONE --cmd "set rtp^=<theme>" -c "luafile <theme>/scripts/check.lua"`.
- Dark did not move: a full dump of every group's fg/bg for all eight styles, taken before and after,
  differs only by new groups and by the `light` style's crash record. Zero changed colour values.
- Cursor in light: all six cursor groups resolve to `fg=#ffffff bg=#0550ae`.
- Clean startup prints nothing: `nvim --headless "+messages" +qa 2>&1`.
- Every new assertion was seen failing under a deliberate break, then restored and confirmed with
  `shasum -a 256`.
- An independent agent re-ran the checks and confirmed all five claims. It also found the three
  remaining page-coloured pickers (fzf-lua, dap-ui, notify) that the first pass missed.

## Follow-ups

- [ ] The theme's `light` style crashes on load: its palette is missing 58 keys. Pre-existing.
- [ ] Dark has 55 groups below 4.5:1, including `FidgetTitle` at 1.37:1. Deferred on purpose; dark was
      not touched this round.
- [ ] In light, `CursorLine` and `DiffChange` are both `#ddf4ff`, so inside a diff the current line is
      not distinguishable from a changed line.
- [ ] `Method` and `Struct` (used by Telescope's results) have no colour in either mode. A fix was
      written and reverted, because it would have coloured dark mode too.
- [ ] The bufferline palette is still owned by this config, not the theme.
- [ ] `scripts/check.lua` only audits `glight`; a dark mode would catch the list above.
- [ ] `lua/plugins/pluginsHub.lua` keeps the local `dir` override marked `TEMP(T9)`. Do not restore the
      GitHub spec until `feature/glight` is merged into the theme's `main`, or the config silently goes
      back to the old colours.
