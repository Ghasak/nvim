-- lua/plugins/configs/lsp/lsp_attach.lua
local M = {}

------------------------------------------------------------------------------------------
-- helper to set the LSP "reference" highlights
------------------------------------------------------------------------------------------
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

-- run it now (for your startup colorscheme)
apply_lsp_reference_hl()

-- re-apply on theme change
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = { "github_dark", "github_light" },
  callback = apply_lsp_reference_hl,
})

-- try to load blink.cmp once
local blink_ok, blink_cmp = pcall(require, "blink.cmp")

-- central on_attach for LSP clients
function M.on_attach(client, bufnr)
  -- Set omnifunc for completion
  -- Set buffer options using the modern API
  vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"

  -- Diagnostic float on cursor hold
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = {
          "BufLeave",
          "CursorMoved",
          "InsertEnter",
          "FocusLost",
        },
        border = {
          "╔",
          "═",
          "╗",
          "║",
          "╝",
          "═",
          "╚",
          "║",
        },
        source = "always",
        prefix = " ",
        scope = "cursor",
      }
      vim.diagnostic.open_float(nil, opts)
    end,
  })

  -- Document highlighting if supported
  vim.opt.updatetime = 300
  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup("lsp_document_highlight_" .. bufnr, { clear = true })

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = group,
      buffer = bufnr,
      callback = function() vim.lsp.buf.document_highlight() end,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      group = group,
      buffer = bufnr,
      callback = function() vim.lsp.buf.clear_references() end,
    })
  end

  -- put this once (e.g., early in your config) to make highlights obvious for debugging
  -- vim.api.nvim_set_hl(0, "LspReferenceText", { underline = true, bold = true, fg = "#FFFF00" })
  -- vim.api.nvim_set_hl(0, "LspReferenceRead", { underline = true, bold = true, fg = "#FFAA00" })
  -- vim.api.nvim_set_hl(0, "LspReferenceWrite", { underline = true, bold = true, fg = "#00FFAA" })

  -- Custom diagnostic line number highlights
  -- Responsible this part on the colors of the
  --Those are custom highlight group definitions for the line number column when there’s
  -- a diagnostic on that line. Neovim’s diagnostics infrastructure exposes special groups like:

  vim.api.nvim_set_hl(0, "DiagnosticLineNrError", { bg = "#51202A", fg = "#FF0000", bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticLineNrWarn", { bg = "#51412A", fg = "#FFA500", bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticLineNrInfo", { bg = "#1E535D", fg = "#00FFFF", bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticLineNrHint", { bg = "#1E205D", fg = "#0000FF", bold = true })

  -- LSP signature setup (with safe loading)
  local signature_ok, signature_cfg = pcall(require, "plugins.configs.gi_lsp_signature")
  if signature_ok then
    local lsp_signature_ok, lsp_signature = pcall(require, "lsp_signature")
    if lsp_signature_ok and type(lsp_signature.on_attach) == "function" then
      lsp_signature.on_attach(signature_cfg, bufnr)
    else
      vim.notify("lsp_signature plugin not available or missing on_attach", vim.log.levels.WARN)
    end
  else
    vim.notify("Signature config gi_lsp_signature not found", vim.log.levels.WARN)
  end

  -- Server-specific formatting capability enabling
  if client.name == "tsserver" or client.name == "ts_ls" then
    -- only if you intend to use its formatter
    client.server_capabilities.documentFormattingProvider = true
  end

  if client.name == "lua_ls" then client.server_capabilities.documentFormattingProvider = true end

  local function bufmap(mode, lhs, rhs, desc)
    if desc then desc = "LSP: " .. desc end
    vim.keymap.set(mode, lhs, rhs, {
      buffer = bufnr,
      silent = true,
      noremap = true,
      desc = desc,
    })
  end

  -- Hover with border
  bufmap("n", "gh", function() vim.lsp.buf.hover { border = "double" } end, "hover with border")

  -- Core navigation / actions
  bufmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
  bufmap("n", "gr", vim.lsp.buf.references, "References")
  bufmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
  bufmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
  bufmap("n", "<leader>e", vim.diagnostic.open_float, "Peek diagnostic")

  -- Diagnostics navigation (replacement for deprecated goto_prev/next)
  bufmap("n", "[d", function() vim.diagnostic.jump { count = -1 } end, "Prev diagnostic")
  bufmap("n", "]d", function() vim.diagnostic.jump { count = 1 } end, "Next diagnostic")

  -- blink.cmp signature help integration if available
  if blink_ok and blink_cmp.signature_help then blink_cmp.signature_help.attach(client, bufnr) end
end

return M
