---
id: 2026-11-08-01
date: 2026-11-08
title: Theme follows the OS light/dark setting; avante removed and plugins updated
status: done
scope: [config, plugins, docs]
commit: nvim ce6e9ab..c8a8e42 on feature/auto-bg-avante-removal, merged into main
---

## What changed

**Theme light/dark follows the OS — `lua/plugins/pluginsHub.lua:7-56`:**

- Startup reads one line from `stdpath("state") .. "/theme_background"` (:21-25). That file read
  is the whole startup cost, about 0.01 ms. The OS is not asked on the startup path.
- The OS query runs after startup (`vim.defer_fn(..., 0)` at :47), on `FocusGained` (:48), and on
  a 60 s timer that is `unref()`'d (:49-51). macOS reads
  `defaults read -g AppleInterfaceStyle` (:12) and treats a value starting `Dark` as dark (:13).
  Windows reads `reg query HKCU\...\Personalize /v AppsUseLightTheme` (:15) and treats `0x0` as
  dark (:16). Any other OS reports light, spawns nothing and writes no file (:18-19).
- `vim.o.background` is set from the cache before the theme loads (:53), then the style is chosen
  from that value — `gdark` or `glight` (:54). Because the style matches the background, the
  theme does not reload on startup.
- A manual `<leader>ub` flip (`lua/services/snacks_mini_services.lua:36`) stays until the OS
  itself changes. The manual value is never written to the cache: the save at :26-32 runs only on
  the first run or when the OS value differs from `sysbg` (:37-43).
- macOS "Auto" appearance already switches at the owner's chosen times, so the 60 s poll catches
  it within a minute. Windows has no built-in time-of-day switch.

**avante.nvim removed:**

- Its spec is gone from `lua/plugins/pluginsHub.lua`, and `docs/plugins/Avante.md` is deleted.
  `git grep -i avante` outside `docs/backlog` and `docs/rick` prints nothing (exit 1). Those two
  folders are append-only history and keep their old mentions.

**`:Lazy! sync`, owner-approved:**

- 113 locked plugins to 106. Removed: `avante.nvim`, `img-clip.nvim`, `mega.cmdparse`,
  `mega.logging`, `mini.pick`, `nvim-cmp` (orphan, no spec), `render-markdown.nvim` (duplicate
  checkout of `render-markdown`). Updated: `fzf-lua` `bea6a13`→`22f0bbd`, `render-markdown`
  `8e87953`→`eef0196`, `telescope.nvim` `40aedd8`→`1e1bab7`, `yazi.nvim` `125f501`→`dc53d9d`.
  The sync log has 0 errors and exit 0. Clean startup after it.
- nvim itself: `nvim --version` → `NVIM v0.12.6`, which is still the latest stable (GitHub
  release 2026-10-09). No upgrade was available, and nightly was not taken.

**obsidian ui off — `lua/plugins/pluginsHub.lua:1022-1023`:**

- `ui = { enable = false }`. render-markdown draws markdown; obsidian's ui would double-draw it.
  This clears render-markdown's health conflict and turns off obsidian's own checkbox/conceal
  decorations.

## Why

The owner asked for the theme to follow the OS appearance. On macOS the appearance is set to
Auto, so that means time-of-day switching without touching nvim. The same pass removed avante
(no longer used), updated the plugins, and cleared the render-markdown health error that obsidian's
ui caused. Startup speed had to stay where it was, which ruled out asking the OS synchronously.

## Proof

- Speed, `hyperfine -N --warmup 3 --runs 30 'nvim --headless +qa'`: `main` **54.4 ms**; the first
  version that read `defaults` synchronously **64.0 ms**; the final cached version **51.6-51.9 ms**.
  The synchronous read cost about 8 ms at startup, so it was dropped.
- Theme behaviour, `NVIM v0.12.6`, fresh headless processes:
  - dark cache file + `PATH=/var/empty` → `background=dark`, `Normal` bg `#212830`
  - light cache → `background=light`, `Normal` bg `#ffffff`
  - no cache → light first, then dark; cache file written as `dark`
  - garbage cache → light, no error
  - manual `<leader>ub` flip kept; `<leader>ub` flips `gdark`↔`glight`
  - Windows simulation with CRLF `reg` output: `0x0`→dark, `0x1`→light, exit 1→light
  - a shadow `defaults` that sleeps 3 s → startup finishes in 0.05 s, so the startup path is not
    blocked by the OS query
  - deliberate breaks were seen failing, then restored byte-for-byte with identical
    `shasum -a 256`
- Clean startup: `nvim --headless "+messages" +qa 2>&1` prints nothing.
- avante removal: `git grep -i avante -- . ':!docs/backlog' ':!docs/rick'` → no output, exit 1.
  `docs/plugins/Avante.md` no longer exists.
- Plugin sync: the lockfile diff is 113 → 106 entries; the removed set is exactly the seven names
  above, and no plugin was added. `sync.exit` is `exit=0`; `grep -ci error` on the sync log is 0.
- obsidian: the saved checkhealth capture goes from
  `❌ ERROR obsidian: installed` (`health/rm-break.txt:70`) to
  `✅ OK obsidian: installed but should not conflict` (`health/rm-after.txt:70` and
  `health/rm-restored.txt:70`). The render-markdown section drops from 5 WARNING + 1 ERROR to
  5 WARNING + 0 ERROR.
- checkhealth totals before the obsidian fix: **10 ERROR, 30 WARNING**. One of the 10 was the
  obsidian conflict; nine remain, none caused by this change. Five of the nine are stale-runtime
  errors: the `vim.health Runtime` error names 14 old 0.11 files under
  `/usr/local/share/nvim/runtime`, and the four optional-provider errors have tracebacks in
  `provider/*/health.lua` under that same directory. None of the 14 files appears in
  `~/dev/neovim/build/install_manifest.txt` (`grep -c` → 0 for `lua/vim/_editor.lua` and
  `lua/provider/node/health.lua`).
- Incident and repair: a tester launched nvim with a copy of `main`'s config. It redirected
  `XDG_CONFIG_HOME` and `XDG_STATE_HOME` but not the data dir, so lazy re-installed the seven
  removed plugins into the shared `~/.local/share/nvim/lazy` and rewrote the lockfile. Repaired:
  the lockfile was copied back, and `t5/lazy-lock.restored.json` is byte-identical to the
  post-sync lock (`cmp` exit 0, 106 entries). The live
  `~/.local/share/nvim/lazy/lazy-lock.json` also matches it (`cmp` exit 0).

**What is NOT verified.** Real Windows — only a shell simulation of `reg` with CRLF output was
run. A real OS appearance flip while nvim is running was not observed; the cache values and the
simulated commands were tested instead. GUI and pixel-level rendering were not observed; every
run was headless. An A/B speed comparison of `main` and the branch in one session was not done;
the numbers above come from separate runs in the delivery session.

## Follow-ups

- [ ] The 14 stale 0.11 files in `/usr/local/share/nvim/runtime` cause one `vim.health Runtime`
      error and the four optional-provider errors. Fix needs owner sudo:
      `sudo rm -rf /usr/local/share/nvim/runtime && cd ~/dev/neovim && sudo make install`.
- [ ] `~/.local/state/nvim/avante/` (an empty `pasted_images/`) and `~/.local/state/nvim/avante.log`
      remain after the removal. Deleting them is the owner's decision.
- [ ] `lua/plugins/configs/others.lua:5,12` — `myAutopairs` reads `require("cmp")` and calls
      `autopairs_completion.setup` without checking that the require succeeded. With nvim-cmp
      gone it would throw if called. It is never called: `grep -rn myAutopairs` finds only the
      definition at `:3`. Dead code.
- [ ] The Windows branch was only run against a simulated `reg`; it has not run on real Windows.
- [ ] render-markdown warns that the `latex` and `yaml` tree-sitter parsers are not installed.
- [ ] A corrupt `theme_background` file is only rewritten when the OS value differs from the
      cached default, so it can stay corrupt while the value agrees. Harmless.
