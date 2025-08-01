# Things that I have changed

    "kyazdani42/nvim-tree.lua",
    "X3eRo0/dired.nvim",
    "hrsh7th/nvim-cmp",
    "tzachar/cmp-tabnine",

```lua

-- minimal_lua_ls_explicit.lua
local M = {}

function M.setup()
  -- ensure mason & mason-lspconfig are running
  require("mason").setup()
  require("mason-lspconfig").setup {
    ensure_installed = { "lua_ls" },
    automatic_installation = true,
  }

  -- basic capabilities
  local caps = vim.lsp.protocol.make_client_capabilities()

  -- explicit lua_ls setup (not registry-style) with vim globals/runtime
  local lspconfig = require("lspconfig")
  lspconfig.lua_ls.setup {
    capabilities = caps,
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  }

  -- simple attach for keymaps (optional)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local bufnr = args.buf
      vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
      vim.keymap.set("n", "gh", function() vim.lsp.buf.hover { border = "double" } end, { buffer = bufnr, desc = "hover" })
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "definition" })
    end,
  })
end

return M


## Old way to write the correct

  -- Shared attach logic via LspAttach
  -- vim.api.nvim_create_autocmd("LspAttach", {
  --   callback = function(args)
  --     local client = vim.lsp.get_client_by_id(args.data.client_id)
  --     if client then M.on_attach(client, args.buf) end
  --   end,
  -- })

```
