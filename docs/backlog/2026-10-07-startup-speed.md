---
id: 2026-10-07-02
date: 2026-10-07
title: Startup speed - tools load on first use, dead code removed
status: done
scope: [config, docs]
commit: nvim 891db25 on feature/startup-speed
---

## What changed

**Plugin triggers, `lua/plugins/pluginsHub.lua`** — five tools no longer load while Neovim starts:

- `telescope.nvim` (:131-137): `event = "VimEnter"` removed. `cmd = "Telescope"` stays, so the
  command exists and loads it on first use. This is the big one: its config runs the extension
  loader at `lua/plugins/configs/gi_telescope.lua:269-282`, and `safe_load_extension("dap", "dap")`
  at :279 does `pcall(require, "dap")` to *check* for the plugin. A require LOADS the plugin, so
  every startup pulled in nvim-dap, nvim-dap-virtual-text, nvim-dap-ui, nio, nvim-treesitter and
  nvim-treesitter-textobjects behind it — about 50-100 ms of the startup burst.
- `telescope-ui-select.nvim` (:150) and `telescope-lsp-handlers.nvim` (:152-157): their own
  `event = "VimEnter"` removed too. Dependency specs register their own triggers, so they would
  have loaded at VimEnter on their own — and their module requires telescope, which would have
  restored the whole cascade. They now load with telescope.
- `fzf-lua` (:178-185): `event = "VimEnter"` replaced by `cmd = { "FzfLua" }` (:181). The
  keymap entry point (`<leader>p`, `lua/core/keymappings.lua:187`) loads it through the require
  hook, verified live.
- `nvim-web-devicons` (:108-124): `event = "VimEnter"` removed. It loads at VeryLazy as the
  dependency of lualine and bufferline, which is when its icons are first needed.
- `mason.nvim` (:292-317): its spec `init` (which ran `require("mason").setup{...}` at startup —
  and a require in `init` force-loads the plugin) moved to `config`. Setup still runs, now when
  mason actually loads: at VeryLazy, as nvim-lspconfig's dependency.
- `windsurf.vim` (:1115-1137): one comment added at :1126. The spec is malformed
  (`dependencies`/`config` nested inside the `cmd` list) and its config can never run; fixing it
  would change behaviour, so it is left as-is pending an owner decision.

**Deliberately kept, with reasons:**

- `undotree` (:716-721) keeps `event = "VimEnter"`. Its config (`lua/plugins/configs/gi_undotree.lua:7-26`)
  sets `undolevels`, `undoreload`, `undodir` and `set undofile` when it loads; removing the trigger
  would silently turn persistent undo off until the first `:UndotreeToggle`. Cost of keeping: 0.48 ms.
- `nvim-treesitter` (:54-67) is unchanged. In a real session it loads at VeryLazy through
  nvim-lspconfig's config requiring lspsaga; its keymaps and highlighting appear just after the UI,
  the same window as before, only moved from the VimEnter burst to VeryLazy.
- `transparent.nvim` (:15-20) stays `cond = false`; `snacks` stays eager by design.

**`lua/plugins/lazyPluginsManager.lua`** — `rest = true` removed from `performance.rtp` (:43 in the
old file): it is not an option this lazy.nvim version knows (its `rtp` table accepts only `reset`,
`paths`, `disabled_plugins`). Six exact duplicates removed from `disabled_plugins` (`tohtml`,
`gzip`, `matchit`, `tarPlugin`, `zipPlugin`, `tutor` — each appeared twice); 25 unique entries stay,
including the ones whose effect is unknown (`netrw`, `syntax`, `ftplugin`). Nothing else touched.

**`lua/settings/options.lua`** — three small removals:

- The identical `au BufWritePre * :%s/\s\+$//e` existed at :150 and :296; the second one (and its
  banner) is gone. Every `:write` ran the same substitution twice; now once (counted, see Proof).
- The VimScript block that defined `HighlightSearch`/`HighlightCursorMatch`, the `n`/`N` maps and
  the `betterSeachHighlighting` augroup ran inside a `BufEnter` autocmd — re-sourcing on every
  buffer entry. It now runs once at config load (:365-410). The block's text is byte-identical.
- `createdir` (:425-443 old) removed: never called, and it contained five `os.execute` calls.
- The netrw `Explore` block (now :419-446) is untouched: it is live (bare `nvim` opens netrw).

**Deleted — eight provably dead files** (zero references in the whole tree, including the theme):

`after/plugin/autoUpdatebuffer.lua` (198 lines; its only registering call was commented out),
`after/plugin/myCommandWrapper.lua`, `after/plugin/myQuickTerminal.lua` (the live terminal config
is `lua/settings/myQuickTerminal.lua`), `lua/units/init.lua`, `lua/colors/custom_github_theme.lua`,
`lua/plugins/configs/gi_terminal.lua` (0 bytes), `lua/plugins/configs/legacy/myCopilot.lua`,
`lua/plugins/configs/legacy/myDashboard.lua`.
Kept: `lua/plugins/configs/icons.lua` — its only mention is a commented-out `require` at
`lua/plugins/configs/gi_lualine_nvim.lua:93`, which reads like a restore hint.

**Not changed, and why:** `lua/patches/*` stays on the startup path. A deferral was built and
measured in a scratch copy: every interactive launch shape fires the deferral events before the UI
appears anyway, so the win exists only in no-buffer sessions (~5 ms), while the patches would stop
being installed unconditionally. A deliberate break (patches removed) proved they are load-bearing:
attaching clients lose the shim and `supports_method_compat`. The patch files are untouched.

**Theme `githubG.nvim`: no changes this pass.** Findings recorded under Follow-ups.

## Why

The owner asked for a faster launch. Measured, the real launch (a pty session, the way the editor
is actually used) spent about 140-180 ms before the first frame and ~220-275 ms before the
post-startup batch finished — while the config-only load was 39 ms. The difference was the
VimEnter burst: two full pickers, the whole debugger stack (pulled in by a "check" that loads what
it checks), plus treesitter, loaded before the user had done anything. Tools people use minutes
later do not need to wake up before the first keystroke. Separately, dead code and duplicated work
were removed so the map matches the territory and every write does one substitution, not two.

## Proof

Measured on `NVIM v0.11.5`, fresh processes, against a `git archive main` (3272d2c) baseline:

- Real launch (pty, `TERM=xterm-256color script -q /dev/null nvim --startuptime f ...`):

  | marker | before | after |
  |---|---|---|
  | `--- NVIM STARTED ---` (Embedded) | ~140-180 ms | **~60-79 ms** |
  | VimEnter processed | ~131-171 ms | **~51-66 ms** |
  | `User VeryLazy` fired | ~216-275 ms | **~123-199 ms** |

- Require tracer (counts `require` of dap / nvim-treesitter / fzf-lua at VimEnter): **20
  VimEnter-rooted events before** (dap 13, fzf-lua 5, treesitter 2); after, **dap 0 and fzf-lua
  0**, and the two nvim-treesitter requires now root at the VeryLazy handler (nvim-lspconfig's
  config requiring lspsaga) instead of the VimEnter burst — headless reports 0 because VeryLazy
  never fires there. Break check: re-adding `event = "VimEnter"` to telescope (scratch copy)
  flips the tracer back to 15 VimEnter-rooted events (20 with fzf-lua's trigger also restored),
  rooted at `gi_telescope.lua:270`; restored, `shasum -a 256` matches.
- Config-only load (`nvim --headless -i NONE --startuptime f +qa`): ~38-40 ms before, ~32-37 ms
  after (run-to-run noise).
- Clean startup prints nothing, before and after: `nvim --headless "+messages" +qa 2>&1` → empty,
  exit 0.
- Loaded-state at settle (pty): telescope, fzf-lua, nvim-dap **no longer loaded**; devicons,
  treesitter, mason, undotree, lualine, bufferline, notify, leap, lspconfig, snacks, githubG still
  loaded — each on its designed trigger.
- Entry points, each verified live in a pty by two different agents: `:Telescope` (opens
  TelescopePrompt), `:FzfLua` (ft=fzf), `<leader>p` (ft=fzf), `:UndotreeToggle` (undotree + diff
  windows), `:Mason` (ft=mason). `:messages` empty in every run.
- T2 equivalence, isolated scratch copies (HEAD vs working, same plugin data dir): the effective
  `disabled_rtp_plugins` key set and the sorted runtimepath are identical.
- T3 counting, `set verbose=12` on one `:write`: the substitution line appears twice before, once
  after (a naive `+messages` count double-reports — verify on the live stream). The netrw block is
  byte-identical: extracted 34 lines, `shasum -a 256` `a3f8ad78…` both sides.
- Eight deletions: zero-reference grep per file (symbols included, e.g. the `CMD` global); no
  dynamic loader exists in the config; the loaded matrix after deletion is identical to before.
- Three independent testers re-ran everything above and confirmed it. They also corrected two
  wording errors in the coordinator's working notes (devicons and treesitter do load at VeryLazy,
  correctly) and found one counting trap (above).
- Not verified: the interactive selection step inside the pickers (windows and filetypes were
  proven, not choosing a result); cold OS file cache; Windows/Linux behaviour (macOS only).

## Rollback

**Whole change:** `git revert -m 1 <merge-sha>` after the merge, or
`git checkout 3272d2c -- <paths>` for any part before it (3272d2c = `main` before this work).
Every file in this entry is one `git checkout 3272d2c -- <path>` away from its old state.

Per change, for surgical reverts:

| File | Change | Revert step |
|---|---|---|
| `lua/plugins/pluginsHub.lua` | telescope `event` removed (:131-137) | add `event = "VimEnter",` in the spec table |
| " | ui-select `{ "....nvim" }` (:150) | restore `, event = "VimEnter"` |
| " | lsp-handlers `event` removed (:152-157) | add `event = "VimEnter",` |
| " | fzf-lua `cmd = { "FzfLua" }` (:181) | replace with `event = "VimEnter",` |
| " | devicons `event` removed (:107-110) | add `event = "VimEnter",` |
| " | mason `config` → (:308) | rename back to `init` |
| " | windsurf comment (:1126) | delete the comment line |
| `lua/plugins/lazyPluginsManager.lua` | `rest` + 6 duplicates removed | re-add `rest = true,` and the six duplicate strings |
| `lua/settings/options.lua` | duplicate `BufWritePre` removed | re-add banner + `vim.cmd [[au BufWritePre * :%s/\s\+$//e]]` |
| " | hoisted block (:365-410) | wrap the `vim.cmd [[ ... ]]` in the old `nvim_create_autocmd("BufEnter", {nested=true, callback=function() ... end,})` |
| " | `createdir` removed | restore the function text (see 3272d2c) |
| 8 deleted files | deletion | `git checkout 3272d2c -- <path>` each (paths above) |

## Follow-ups

Ponytail review of the whole project (an independent auditor, read-only, ranked with evidence).
Nothing here was applied in this pass; each item lists its own verification.

- [ ] **Delete-safe (provably dead, zero references):** the dead half of `lua/core/utils.lua`
      (`remove_disabled_keys`, the no-op `load_mappings` and its telescope `init` caller,
      `load_module`); 8 of 9 functions in `lua/plugins/configs/others.lua` (only `colorizer()` is
      called; `better_escape` calls a `load_config` that does not exist); ~150 dead lines in
      `lua/settings/special_color_highlight.lua` plus its NvimTree `BufEnter` walk (nvim-tree is
      not installed); `lua/plugins/configs/lspkind_icons.lua` + the `onsails/lspkind-nvim` dep
      (`pluginsHub.lua:258`); `lua/plugins/configs/dap/.../dap_dap_cpp_codelldb.lua` (dap_engine
      loads the other three cpp files); `lua/core/myInspectorFucntions.lua`; two 0-byte files under
      `lua/plugins/configs/dap/dap_custom_languages_settings/`; `disable_distribution_plugins()`
      (`options.lua:272-291`, never called).
- [ ] **Simplify (no runtime effect):** 17 of the 25 `disabled_plugins` entries match no runtime
      plugin file (lazy matches file basenames; `syntax`/`ftplugin`/`compiler` are directories);
      the hand-rolled built-in-plugin block at `options.lua:246-291` is redundant with lazy;
      duplicate/overridden option sets in `options.lua` (~20 lines); `opt.syntax = "enable"`
      (:132) is a no-op; python2 leftovers (:227-230); nine commented-out spec fragments in
      `pluginsHub.lua`.
- [ ] **Needs owner:** transparency is fully inert (`init.lua:71-80` + `cond = false` spec);
      `lua/settings/myQuickTerminal.lua` is a third terminal entry point duplicating snacks and
      lspsaga keys; `lua/services/hide_copilot_on_suggestion.lua` requires copilot at startup
      while copilot is parked (`cond = false`, not installed); three pickers (telescope, fzf-lua,
      snacks) all have live entry points — consolidation is a usage call; `vim.deprecate` is
      silenced process-wide (`init.lua:86`).
- [ ] **windsurf spec**: malformed (see What changed); fix or strip is an owner decision.
- [ ] **Theme `githubG.nvim`:** the default style `"dark"` crashes on load — `palette.lua` has 8
      styles but `styles_list` expects 9; reproduced standalone: `E5113` at `colors.lua:5`
      (`tbl_extend` with a nil table). The live config masks it by always passing
      `style = "glight"`. Also: root `onedark_config.lua` (13.5 KB) is unreachable by `require`
      (outside `lua/`) and unreferenced; the highlight loop costs 3.1 ms per colorscheme apply
      (measured) — do not rewrite it without a full `:highlight` diff as proof.
- [ ] **Docs staleness:** `docs/Fundamentals.md:440` points at `lua/scripts/myCommandWrapper.lua`
      (path never existed; the file was deleted this pass); `docs/tabnine.md`,
      `docs/nvim_tree_cheat_sheet.md` and `docs/Fundamentals.md:666-679` describe tools that are
      not installed.
