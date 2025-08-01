local M = {}
local map = vim.keymap.set

M.color_scheme_lsp_selector = function()
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
end

-- on_attach: buffer-local keymaps and UI
function M.on_attach_global(client, bufnr)
  -- try to load blink.cmp once
  local blink_ok, blink_cmp = pcall(require, "blink.cmp")
  local function opts(desc) return { buffer = bufnr, desc = "LSP " .. desc } end

  -- ╭──────────────────────────────────────────────────────────────╮
  -- │                  Glance Keymapping                           │
  -- │     Using Glance instead of the built-in lspconfig           │
  -- │     in lsp_attach.lua file replaced with snacks.nvim         │
  -- ╰──────────────────────────────────────────────────────────────╯
  map("n", "gh", function() vim.lsp.buf.hover { border = "double" } end, opts "Hover")

  local builtin = require "telescope.builtin"

  vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
  map("n", "gd", builtin.lsp_definitions, { buffer = 0 })
  map("n", "gr", builtin.lsp_references, { buffer = 0 })
  map("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
  map("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
  map("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
  map("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
  map("n", "<space>wd", builtin.lsp_document_symbols, { buffer = 0 })

  -- map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  -- map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")

  -- map("n", "gd", "<cmd>Glance definitions<CR>", { noremap = false, silent = true })
  -- map("n", "gD", "<cmd>Glance type_definitions<CR>", { noremap = false, silent = true })
  -- map("n", "gR", "<CMD>Glance references<CR>", { noremap = false, silent = true })
  -- map("n", "gY", "<CMD>Glance type_definitions<CR>", { noremap = false, silent = true })
  -- map("n", "gM", "<CMD>Glance implementations<CR>", { noremap = false, silent = true })

  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")
  map(
    "n",
    "<leader>wl",
    function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    opts "List workspace folders"
  )
  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")

  -- blink.cmp signature help integration if available
  if blink_ok and blink_cmp.signature_help then blink_cmp.signature_help.attach(client, bufnr) end

  -- Buffer-local options
  vim.bo[bufnr].formatexpr = "v:lua.vim.lsp.formatexpr()"
  vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
  vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"

  -- Diagnostic float on cursor hold
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local float_opts = {
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
      vim.diagnostic.open_float(nil, float_opts)
    end,
  })

  -- Document highlighting if supported
  vim.opt.updatetime = 300
  if client.server_capabilities and client.server_capabilities.documentHighlightProvider then
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

  -- Diagnostic line number highlights
  vim.api.nvim_set_hl(0, "DiagnosticLineNrError", { bg = "#51202A", fg = "#FF0000", bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticLineNrWarn", { bg = "#51412A", fg = "#FFA500", bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticLineNrInfo", { bg = "#1E535D", fg = "#00FFFF", bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticLineNrHint", { bg = "#1E205D", fg = "#0000FF", bold = true })

  -- LSP signature setup (safe)
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
    client.server_capabilities.documentFormattingProvider = true
  end
  if client.name == "lua_ls" then client.server_capabilities.documentFormattingProvider = true end
end

return M
