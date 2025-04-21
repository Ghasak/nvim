-- lua/plugins/configs/diagnostics.lua
local M = {}

-- 1.  Global diagnostic configuration (runs once at startup)
M.setup = function()
  vim.diagnostic.config({
    -- ⬇️  Signs ───────────────────────────────────────────────
    signs = {
      -- icon that appears in the sign column
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN]  = "",
        [vim.diagnostic.severity.HINT]  = "󰌵",
        [vim.diagnostic.severity.INFO]  = "",
      },
      -- (optional) highlight group to use for the *line‑number*
      numhl = {
        [vim.diagnostic.severity.ERROR] = "DiagnosticLineNrError",
        [vim.diagnostic.severity.WARN]  = "DiagnosticLineNrWarn",
        [vim.diagnostic.severity.HINT]  = "DiagnosticLineNrHint",
        [vim.diagnostic.severity.INFO]  = "DiagnosticLineNrInfo",
      },
    },

    -- ⬇️  Everything else you already had ─────────────────────
    virtual_text = {
      spacing  = 20,
      source   = "if_many",
      prefix   = "■",
      severity = { max = vim.diagnostic.severity.WARN },
    },
    virtual_lines = true,  --: triggered by  by diagnositc_toggle.lua commands
                           --: DiagLinesOn and DiagLinesOff, better than later use
                           --: <leader>ud from snacks, as it willshow a gutter and close only the virtual_lines.
    -- virtual_lines = {
    --   severity = { min = vim.diagnostic.severity.ERROR },
    -- },
    underline         = true,
    update_in_insert  = false,
    severity_sort     = true,
    float             = { source = "if_many" },
  })
end

-- 2.  Optional per‑client override (call inside your LSP on_attach)
M.on_attach = function(client, _)
  -- example: for this client show only ERRORs as virtual text
  vim.diagnostic.config(
    { virtual_text = { severity = { max = vim.diagnostic.severity.ERROR } } },
    client.id      -- namespace = that client
  )
end

return M

