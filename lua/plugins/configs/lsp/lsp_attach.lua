local M = {}
local map = vim.keymap.set

-- on_attach: buffer-local keymaps and UI
function M.on_attach_global(client, bufnr)
  -- try to load blink.cmp once
  local blink_ok, blink_cmp = pcall(require, "blink.cmp")
  local function opts(desc) return { buffer = bufnr, desc = "LSP " .. desc } end

  -- ╭──────────────────────────────────────────────────────────────╮
  -- │  🧪 Glance vs telescope Keymapping                           │
  -- │  •  Using Glance instead of the built-in lspconfig           │
  -- │     in lsp_attach.lua file replaced with snacks.nvim         │
  -- ╰──────────────────────────────────────────────────────────────╯
  -- try to load glance
  local has_glance, glance = pcall(require, "glance")

  -- telescope builtin as fallback
  local builtin = require "telescope.builtin"
  vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
  -- Definition of the fallback vs glance mappings
  if has_glance then
    -- Glance is loaded: use its commands
    map("n", "gd", "<cmd>Glance definitions<CR>", { noremap = false, silent = true, buffer = 0 })
    map("n", "gD", "<cmd>Glance type_definitions<CR>", { noremap = false, silent = true, buffer = 0 })
    map("n", "gR", "<cmd>Glance references<CR>", { noremap = false, silent = true, buffer = 0 })
    map("n", "gY", "<cmd>Glance type_definitions<CR>", { noremap = false, silent = true, buffer = 0 })
    map("n", "gM", "<cmd>Glance implementations<CR>", { noremap = false, silent = true, buffer = 0 })
  else
    -- Glance not available: fallback to Telescope
    -- definitions / references / declaration / type def
    map("n", "gd", builtin.lsp_definitions, { buffer = 0, desc = "Goto Definition (Telescope fallback)" })
    map("n", "gr", builtin.lsp_references, { buffer = 0, desc = "Goto References (Telescope fallback)" })
    map("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "Goto Declaration" })
    map("n", "gT", vim.lsp.buf.type_definition, { buffer = 0, desc = "Goto Type Definition" })
    -- document symbols / workspace symbols
    map("n", "<space>wd", builtin.lsp_document_symbols, { buffer = 0, desc = "Document Symbols" })
    map("n", "gO", builtin.lsp_document_symbols, { buffer = 0, desc = "Open Document Symbols" })
    map("n", "gW", builtin.lsp_dynamic_workspace_symbols, { buffer = 0, desc = "Open Workspace Symbols" })
    -- rename & code action
    map("n", "grn", vim.lsp.buf.rename, { buffer = 0, desc = "[R]e[n]ame" })
    map({ "n", "x" }, "gra", vim.lsp.buf.code_action, { buffer = 0, desc = "[G]oto Code [A]ction" })
    -- alternate references/implementations/definitions/type definitions via Telescope
    map("n", "grr", builtin.lsp_references, { buffer = 0, desc = "[G]oto [R]eferences" })
    map("n", "gri", builtin.lsp_implementations, { buffer = 0, desc = "[G]oto [I]mplementation" })
    map("n", "grd", builtin.lsp_definitions, { buffer = 0, desc = "[G]oto [D]efinition" })
    map("n", "grt", builtin.lsp_type_definitions, { buffer = 0, desc = "[G]oto [T]ype Definition" })
  end

  -- Common mappings (always)
  map("n", "gh", function() vim.lsp.buf.hover { border = "double" } end, opts "Hover")
  map("n", "<leader>cr", vim.lsp.buf.rename, { buffer = 0 })
  map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = 0 })
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

  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │ 🧪  LSP reference highlights                                                 │
  -- │   •  here is the actual highlight refelcted in nvim                          │
  -- │     It depends on the apply_lsp_reference_hl function in the .               │
  -- │   ~/.config/nvim/after/plugin/features_loader.lua                            │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯

  -- Document highlighting if supported is based on : vim.opt.updatetime = 300 find it in option.lua
  -- unique augroup per buffer to isolate and auto-clear prior definitions
  local group_name = "lsp_document_highlight_" .. bufnr
  local group = vim.api.nvim_create_augroup(group_name, { clear = true })

  -- highlight symbol under cursor after idle
  -- must watch for the color for background located here:
  -- ~/.config/nvim/after/plugin/features_loader.lua
  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    group = group,
    buffer = bufnr,
    callback = function() vim.lsp.buf.document_highlight() end,
  })

  -- clear the highlights as soon as the cursor moves
  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
    group = group,
    buffer = bufnr,
    callback = function() vim.lsp.buf.clear_references() end,
  })

  -- cleanup on detach: clear references and remove this buffer's highlight autocmds
  vim.api.nvim_create_autocmd("LspDetach", {
    -- separate detach group so it doesn’t interfere with per-buffer highlight group
    group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = false }),
    buffer = bufnr,
    callback = function(event)
      vim.lsp.buf.clear_references()
      -- explicitly clear the highlight autocmds for this buffer
      vim.api.nvim_clear_autocmds { group = group_name, buffer = event.buf }
    end,
  })

  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │ 🧪  LSP line diagnostic highlight                                            │
  -- │   • this will chang the colors of the icons on the side gutter               │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯

  -- Diagnostic line number highlights
  vim.api.nvim_set_hl(0, "DiagnosticLineNrError", { bg = "#51202A", fg = "#FF0000", bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticLineNrWarn", { bg = "#51412A", fg = "#FFA500", bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticLineNrInfo", { bg = "#1E535D", fg = "#00FFFF", bold = true })
  vim.api.nvim_set_hl(0, "DiagnosticLineNrHint", { bg = "#1E205D", fg = "#0000FF", bold = true })

  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │ 🧪  Integrate with lsp signature                                             │
  -- │   • lsp signature loaded with the configs                                    │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯
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

  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │ ⚙️  Server specific features                                                 │
  -- │   • For tsserver and lus_ls                                                  │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯

  -- Server-specific formatting capability enabling
  if client.name == "tsserver" or client.name == "ts_ls" then
    client.server_capabilities.documentFormattingProvider = true
  end
  if client.name == "lua_ls" then client.server_capabilities.documentFormattingProvider = true end

  -- [Optional] per‑client override (call inside your LSP on_attach)
  -- example: for this client show only ERRORs as virtual text
  vim.diagnostic.config(
    { virtual_text = { severity = { max = vim.diagnostic.severity.ERROR } } },
    client.id -- namespace = that client
  )
end

return M
