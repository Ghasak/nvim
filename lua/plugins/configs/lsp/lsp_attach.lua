local M = {}
------------------------------------------------------------------------------------------
-- helper to set the LSP “reference” highlights
------------------------------------------------------------------------------------------
local function apply_lsp_reference_hl()
  local scheme = vim.g.colors_name
  local bg

  if scheme == "github_dark" then
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
------------------------------------------------------------------------------
--       keymap on attaches for lsp  server_capabilities
------------------------------------------------------------------------------
local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  -- keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration({border='double',})<CR>", opts)
  -- keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition({border='double',})<CR>", opts)
  keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover({border='double', })<CR>", opts) --{border = 'double',}
  keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format()<cr>", opts)
  keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
  keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
  keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
  keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
  keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
  keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
  keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  -- Enable completion triggered by <c-x><c-o>
end

M.custom_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  lsp_keymaps(bufnr)
  buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

  -- This will add an error message in rounded popmenu to show the error which is same as the virtual-text.
  -- Read More Here : https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
  -- Also Read: https://jdhao.github.io/2022/10/05/nvim-v08-release/
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
        -- border = 'rounded',

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
  if client.server_capabilities.documentHighlightProvider then -- Since Nvim v.0.8
    -- your existing CursorHold → vim.lsp.buf.document_highlight() setup
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
    -- previous config before the helper function above
    -- vim.cmd [[
    --       hi LspReferenceRead  cterm=bold ctermbg=NONE guibg=#4a535f  "guifg=black
    --       hi LspReferenceText  cterm=bold ctermbg=NONE guibg=#4a535f  "guifg=black
    --       hi LspReferenceWrite cterm=bold ctermbg=NONE guibg=#4a535f  "guifg=black
    --      ]]
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_clear_autocmds {
      buffer = bufnr,
      group = "lsp_document_highlight",
    }
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
  vim.cmd [[
         highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
         highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
         highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
         highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

         ]]
  -- Customization for at the colorscheme level (onedark)
  -- DiagnosticVirtualTextError
  -- DiagnosticVirtualTextWarn
  -- DiagnosticVirtualTextInfo
  -- DiagnosticVirtualTextHint
  -----------------------------------------------------------------------------------
  --          Adding more features specific for Rust-language
  --          https://github.com/hrsh7th/nvim-cmp/wiki/Language-Server-Specific-Samples#rust-with-rust-toolsnvim
  -----------------------------------------------------------------------------------
  vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.api.nvim_buf_set_option(bufnr, "tagfunc", "v:lua.vim.lsp.tagfunc")
  -----------------------------------------------------------------------------------
  --          The above keymapping will be overwritten by lsp-saga
  -----------------------------------------------------------------------------------
  -- Allow saga to do its magic (show diagnostic on hover of the line with error)
  -- vim.api.nvim_command("autocmd CursorHold * Lspsaga show_line_diagnostics")
  -- require("plugins.configs.mySaga").conf()
  -----------------------------------------------------------------------------------
  --          							lsp signture with nvim
  -----------------------------------------------------------------------------------
  local cfg = require "plugins.configs.p11_mySignture"
  require("lsp_signature").on_attach(cfg, bufnr)

  if client.name == "tsserver" then
    -- client.resolved_capabilities.document_formatting = false  -- deperated since nvim 0.8
    client.server_capabilities.document_formatting = true
  end

  if client.name == "lua_ls" then client.server_capabilities.document_formatting = true end

  --   local status_ok, illuminate = pcall(require, "illuminate")
  --   if not status_ok then
  --     return
  --   end
  --   illuminate.on_attach(client)
end

return M
