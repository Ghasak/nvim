---
id: 2026-10-12-02
date: 2026-10-12
title: nvim-treesitter master on 0.12 — re-register predicates/directives with the list unwrap
status: done
scope: [config]
commit: nvim 07927d8 on hotfix/treesitter-master-012-directives, merged into main as 13ae80c
---

# 2026-10-12 — treesitter master 0.12 directive fix

## What changed

- `lua/plugins/configs/gi_treesitter.lua` — new `M.fix_nvim_treesitter_master_on_012()`,
  called at the end of `M.setup()`: re-registers all six handlers from nvim-treesitter
  `master`'s `query_predicates.lua` (`nth?`, `is?`, `kind-eq?`, `set-lang-from-mimetype!`,
  `set-lang-from-info-string!`, `downcase!`) with `{ force = true }` and a
  `first(match, id)` unwrap, so they take the first node of 0.12's per-capture node list.
- 113 lines, including a header comment; the block is deleted when the config migrates to the
  `main` branch (queued).

## Why

On nvim 0.12 every query match value is a **list** of nodes ("correct match behavior");
`master`'s handlers still treat it as a single node and pass the list to
`vim.treesitter.get_node_text` → `get_range` → `attempt to call method 'range' (a nil value)`
inside the highlighter's decoration provider. Owner-visible as a red error on every redraw
while previewing markdown in telescope. Upstream: nvim-treesitter/nvim-treesitter#8636
(same stack; unwrap suggested) and neovim/neovim#39032 (closed as an upstream issue);
`master`'s README states 0.12 is not supported.

Reproduced deterministically: `CLAUDE.md` open + telescope find in `~/.config/nvim`,
filter `docs`, `Esc`, then `j`/`k` previews → crash in 2 of 3 baseline runs
(exact text: `languagetree.lua:215: treesitter.lua:197: attempt to call method 'range'`).

## Proof

- Baseline: 2/3 runs crashed (flaky due to async parse timing — one clean run proves nothing).
- After the fix: **9/9 runs clean** (6× filter `docs`, 3× filter `md`) — p≈(1/3)^9 under the
  broken rate.
- Fence injection intact: `children: lua,markdown_inline` on a fenced-lua markdown file.
- Syntax (`loadfile`) OK; clean startup prints nothing.

## Follow-ups

- The `main`-branch migration stays the planned next task: it removes this block, fixes text
  objects (still crash on 0.12 — different code path, `tsrange.lua:27`), and folds in the
  pre-existing `move`-nested-in-`select` bug.
- 0.12.6 is 2 days old; check if a patch release changes the match shape before re-testing
  the migration.

## Rollback

- Delete the `M.fix_nvim_treesitter_master_on_012()` call and function (commit 07927d8 is the
  only change).
