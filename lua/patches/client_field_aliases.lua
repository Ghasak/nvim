-- ╭──────────────────────────────────────────────────────────────────────────╮
-- │ 🛠  **LEGACY LSP‑CLIENT FIELD SHIMS**                                    │
-- │                                                                          │
-- │  • Purpose : Re‑expose the *deprecated* table‑style fields that some     │
-- │    plugins still call (`client.is_stopped`, `client.request`,            │
-- │    `client.supports_method`).                                            │
-- │  • How    :  When the `vim.lsp.client` module is first required it       │
-- │    returns a *prototype* table ⇢ `vim.lsp.Client`. We add thin wrappers  │
-- │    that simply delegate to the modern method form.                       │
-- │  • Safe   :  Checks that the alias isn’t already present, so we don’t    │
-- │    override a plugin that may have patched it earlier.                   │
-- │  • Remove :  Once every plugin in your stack uses the method form (and   │
-- │    you’re on Nvim ≥ 0.13) you can delete this whole block.               │
-- ╰──────────────────────────────────────────────────────────────────────────╯
-- place early in your init.lua
local Client = vim.lsp.Client
if Client and not Client.is_stopped then
  -- keep plugins happy until they migrate
  Client.is_stopped = function(c)
    return c:is_stopped()
  end
  Client.request = function(c, ...)
    return c:request(...)
  end
  Client.supports_method = function(c, ...)
    return c:supports_method(...)
  end
end
