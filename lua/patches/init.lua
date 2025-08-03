-- ╭────────────────────────────────────────────────────────────────────────────╮
-- │ 📦  *plugins/patches/init.lua*                                             │
-- │                                                                            │
-- │  List here **only the filenames** (without “.lua”) you want to load.       │
-- │  Each entry becomes:  `require("plugins.patches.<filename>")`              │
-- ╰────────────────────────────────────────────────────────────────────────────╯
local patch_files = {
  -- 🛠  Re‑expose deprecated table‑style LSP client fields
  "client_field_aliases",

  -- 🔄  Shim for vim.lsp.get_active_clients() → vim.lsp.get_clients()
  "get_active_clients_shim",

  -- Shim for client using (.) v10 or (:) v+11
  "supports_method_autopatch",
}

local prefix = "patches."

for _, fname in ipairs(patch_files) do
  local module = prefix .. fname
  local ok, err = pcall(require, module)
  if not ok then
    -- Pretty, non‑fatal error so the rest of NVim can still start
    vim.notify(("❌  Failed loading %s\n%s"):format(module, err), vim.log.levels.ERROR, { title = "patch loader" })
  end
end
