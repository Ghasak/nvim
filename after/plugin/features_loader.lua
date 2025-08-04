-- Got it from kickstart by TJ.
-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 🔗  **LspAttach Auto‑Commands & Keymaps**                                    │
-- ├──────────────────────────────────────────────────────────────────────────────┤
-- │ 🗂  When it runs                                                             │
-- │   • Fired **once per buffer** whenever an LSP client attaches (`LspAttach`). │
-- │   • Lets us set buffer‑local keymaps and autocommands *only* where the LSP   │
-- ├──────────────────────────────────────────────────────────────────────────────┤
-- │ 🚀  Why it matters                                                           │
-- ╰──────────────────────────────────────────────────────────────────────────────╯

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 🧪  LSP reference highlights                                                 │
-- │   • Automatically applies context-sensitive highlight colors for reference   │
-- │     under cursor (read/write/text) based on theme.                           │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- previous location for this module is on top of the `on_attach_global` function
-- this is just acolor selector, and the changes happen based on the lsp server in
-- the lsp_attach.lua triggerd by : vim.lsp.buf.document_highlight()

local function apply_lsp_reference_hl()
  local scheme = vim.g.colors_name
  local bg

  if scheme == "github_dark" or scheme == "onedark" then
    bg = "#4a535f"
  elseif scheme == "github_light" then
    bg = "#79c0ff"
  else
    return
  end

  for _, group in ipairs { "LspReferenceRead", "LspReferenceText", "LspReferenceWrite" } do
    vim.api.nvim_set_hl(0, group, {
      bg = bg,
      bold = true,
    })
  end
end

-- centralized augroup so we can manage related autocommands if needed
local hl_group = vim.api.nvim_create_augroup("custom-lsp-reference-hl", { clear = false })

-- apply once on startup (after colorscheme is already loaded)
vim.api.nvim_create_autocmd("VimEnter", {
  group = hl_group,
  callback = apply_lsp_reference_hl,
})

-- reapply when the colorscheme changes (catch all, or restrict if you want)
vim.api.nvim_create_autocmd("ColorScheme", {
  group = hl_group,
  callback = apply_lsp_reference_hl,
})
