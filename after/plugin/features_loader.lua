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

-- Also owns the config's diagnostic line-number colors.
-- Light values: GitHub Primer, readable on #ffffff. Dark values: unchanged.
local function apply_custom_hl()
  local light = vim.o.background == "light"
  local set = vim.api.nvim_set_hl

  if not light then -- light: the theme's LspReference* (c.bg2); dark keeps the config's value
    for _, group in ipairs { "LspReferenceRead", "LspReferenceText", "LspReferenceWrite" } do
      set(0, group, { bg = "#4a535f", bold = true })
    end
  end

  if not light then -- light: the theme's ColorColumn (c.bg2); dark keeps the config's value
    vim.cmd("highlight ColorColumn ctermbg=black guibg=#373d46")
  end

  -- line-number highlights used by vim.diagnostic numhl (lsp_settings.lua)
  if light then
    set(0, "DiagnosticLineNrError", { bg = "#ffebe9", fg = "#cf222e", bold = true })
    set(0, "DiagnosticLineNrWarn", { bg = "#fff8c5", fg = "#9a6700", bold = true })
    set(0, "DiagnosticLineNrInfo", { bg = "#ddf4ff", fg = "#0969da", bold = true })
    set(0, "DiagnosticLineNrHint", { bg = "#fbefff", fg = "#8250df", bold = true })
  else
    set(0, "DiagnosticLineNrError", { bg = "#51202A", fg = "#FF0000", bold = true })
    set(0, "DiagnosticLineNrWarn", { bg = "#51412A", fg = "#FFA500", bold = true })
    set(0, "DiagnosticLineNrInfo", { bg = "#1E535D", fg = "#00FFFF", bold = true })
    set(0, "DiagnosticLineNrHint", { bg = "#1E205D", fg = "#0000FF", bold = true })
  end
end

-- centralized augroup so we can manage related autocommands if needed
local hl_group = vim.api.nvim_create_augroup("custom-lsp-reference-hl", { clear = false })

-- apply once on startup (after colorscheme is already loaded)
vim.api.nvim_create_autocmd("VimEnter", {
  group = hl_group,
  callback = apply_custom_hl,
})

-- reapply when the colorscheme changes (catch all, or restrict if you want)
vim.api.nvim_create_autocmd("ColorScheme", {
  group = hl_group,
  callback = apply_custom_hl,
})
