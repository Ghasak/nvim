-- ╭────────────────────────────────────────────────────────────────────────────╮
-- │ 🔄 **SHIM FOR vim.lsp.get_active_clients()**                               │
-- │                                                                            │
-- │  • Purpose : Silence the deprecation warning until all plugins             │
-- │    migrate to the newer `vim.lsp.get_clients()` introduced in Nvim 0.10.   │
-- │  • Logic   :  ▸ Prefer the new API when it exists                          │
-- │              ▸ Fallback to the old implementation for 0.9 or earlier       │
-- │              ▸ Return `{}` as a last‑ditch guard on *very* old builds      │
-- │  • Idempotent : Uses an internal flag (`_get_active_clients_shim`) so      │
-- │    multiple `require()`s of this file won’t redeclare the function.        │
-- │  • Remove :  Safe to delete once you (and your plugins) require Nvim ≥ 0.13│
-- ╰────────────────────────────────────────────────────────────────────────────╯
do
  local lsp = vim.lsp or {}

  -- avoid redefining if we already ran once
  if not lsp._get_active_clients_shim then
    -- preserve the original (in case you need to debug later)
    local deprecated_impl = lsp.get_active_clients

    -- replace it with a wrapper that calls the modern API when possible
    ---@diagnostic disable-next-line: duplicate-set-field
    lsp.get_active_clients = function(opts)
      if type(lsp.get_clients) == "function" then
        -- ✅ Modern path (Nvim 0.10+)
        -- Neovim ≥ 0.10: use the new implementation (no warning)
        return lsp.get_clients(opts or {})
      elseif deprecated_impl then
        -- ♻️  Legacy path (Nvim 0.9 or plugin‑patched)
        -- Older Nvim: fall back to the original to stay compatible
        return deprecated_impl(opts)
      else
        -- 🚫  Ancient builds: fail gracefully
        -- very old builds: degrade gracefully
        return {}
      end
    end

    lsp._get_active_clients_shim = true
  end
end
