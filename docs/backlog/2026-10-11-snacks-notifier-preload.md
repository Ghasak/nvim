---
id: 2026-10-11-02
date: 2026-10-11
title: snacks notifier preloaded — fast-event callers can no longer poison it
status: done
scope: [config, plugins]
commit: nvim 20aa223 + 9446deb on hotfix/snacks-notifier-fast-event, merged into main as 83bdcb1
---

# 2026-10-11 — snacks notifier preload

## What changed

- `lua/plugins/pluginsHub.lua`, snacks spec `config`: after `require("snacks").setup(opts)`, a
  `require("snacks.notifier")` now loads the notifier module at startup (5 lines incl. comment).
- Nothing else. Snacks stays pinned at `v2.23.0`.

## Why

Reproduced on nvim 0.12.6: when the pyrefly LSP client exits abnormally, nvim calls `vim.notify`
from the client-exit path (`runtime/lua/vim/lsp/client.lua:1443-1459`); snacks routes that to
`Snacks.notify` (`snacks/init.lua:209`), which `require`s `snacks.notifier` for the first time.
That module calls `vim.api.nvim_create_namespace` at **top level** (`snacks/notifier.lua:152`) —
forbidden in a fast event context → `E5560`, and the half-loaded module stays poisoned
("loop or previous error loading module 'snacks.notifier'"), breaking every later notification.

## Proof

- Failing state, recorded before the fix (real pty, python buffer, pyrefly exit):
  `LSP[pyrefly]: Error ON_EXIT_CALLBACK_ERROR: ... snacks/notifier.lua:152: E5560:
  nvim_create_namespace must not be called in a fast event context`.
- Deterministic fail→pass pair (headless; a `vim.uv` timer callback = a true fast event; `vim.notify`
  called inside it):
  - pre-fix state (module not preloaded): `ok=false err=...notifier.lua:152: E5560 ...`
  - fixed state (module preloaded at startup): `ok=true err=nil`.
  The break was simulated by clearing `package.loaded["snacks.notifier"]` inside the test — the
  changed file was never edited for the break, so no restore was needed.
- Post-fix pty runs of the same python scenario: 3 runs, no `E5560` anywhere in the raw stream.
- Clean startup: `nvim --headless "+messages" +qa 2>&1` → no output, exit 0.

## Follow-ups

- The ambient trigger (pyrefly exiting abnormally on a project-less file) is not deterministic; the
  post-fix pty runs could not re-exhibit the exit itself. The timer test above covers the mechanism
  deterministically.
- The preload is a workaround for snacks internals. The repo already has snacks tags up to
  `v2.31.0`; if snacks is ever unpinned/updated, re-check whether the preload is still needed.
- Reported in the same session, not reproduced on a fresh session (likely artifacts of windows
  that stayed open across the nvim/runtime swap): a treesitter decoration-provider crash and a
  lazy.nvim "Failed to source" popup. Owner to confirm on a fresh window; details if it returns.

## Rollback

- Delete the `require("snacks.notifier")` line (with its comment) — commit `20aa223` contains
  nothing else.
