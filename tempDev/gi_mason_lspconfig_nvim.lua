-- lua/your_module_name/mason_lua_ls.lua
local M = {}

M.setup = function()
  -- Pre settings for Rust language servers
  local rust_tools_settings = require "plugins.configs.lsp.custom_servers.rust_analyzer_server"

  -- Lua additional support from lua-dev
  -- IMPORTANT: make sure to setup lua-dev BEFORE lspconfig
  local neodev_status, neodev = pcall(require, "neodev")
  if neodev_status then neodev.setup {} end

  ---- *****************************************************************************************
  ----                     Mason Loader (similar to nvim-lsp-installer)
  ---- *****************************************************************************************
  -- 1.) >> Main lsp Mason LSP <<
  require("mason").setup {
    ui = {
      check_outdated_packages_on_open = true,
      border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
    },
  }

  -- 2.) >> Loading Mason lspconfig (mason-config) <<
  local mason_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not mason_status_ok then
    vim.notify("Couldn't load Mason-LSP-Config" .. mason_lspconfig, vim.log.levels.ERROR)
    return
  end

  -- Extension to bridge mason.nvim with the lspconfig plugin
  require("mason-lspconfig").setup {
    ensure_installed = {
      "pyright", -- Python LSP
      "lua_ls", -- Lua LSP
      "rust_analyzer", -- Rust LSP
      "texlab", -- LaTeX LSP
      "clangd", -- C/C++ LSP
      "jdtls", -- Java LSP
      "cmake", -- CMake LSP
      "jqls", -- JQ LSP
    },
    ui = {
      check_outdated_packages_on_open = true,
      border = "double",
    },
  }

  -- Mason-tool-installer
  require("mason-tool-installer").setup {
    ensure_installed = {
      -- Formatters
      "stylua",
      "shfmt",
      "black",
      "isort",
      "prettierd",
      -- Linters
      "shellcheck",
      -- Debug Adapters
      "codelldb",
      "debugpy",
      "java-debug-adapter",
      "bash-debug-adapter",
      -- Java-specific tools
      "java-test",
      "vscode-java-decompiler",
      -- Other tools
      "cpptools",
    },
    auto_update = false,
    run_on_start = true,
  }

  -- 4.) >> lspconfig main loader for the lsp
  local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
  if not lspconfig_status_ok then
    vim.notify("Couldn't load LSP-Config" .. lspconfig, vim.log.levels.ERROR)
    return
  else
    require("lspconfig.ui.windows").default_options.border = "double"
  end

  -- ==========================================================================
  -- =                         Main LSP Engine                                =
  -- ==========================================================================

  -- Setup diagnostics globally
  local diagnostics = require "plugins.configs.lsp.lsp_settings"
  diagnostics.setup() -- Call sign definitions globally

  local lspconfig = require "lspconfig"
  local capabilities = require("plugins.configs.lsp.lsp_capabilities").capabilities
  -- get the extracted on_attach
  local on_attach = require("plugins.configs.lsp.lsp_attach").on_attach

  -- base options
  local base_opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 500 },
  }

  -- ==========================================================================
  -- =                    LSP Server Configurations                          =
  -- ==========================================================================

  -- ── Lua ─────────────────────────────────────────────────────────────
  -- build base + override
  -- registry-style lua_ls setup, combining on_init tweaks and your existing on_attach/capabilities
  local attach = require("plugins.configs.lsp.lsp_attach").on_attach
  local capabilities = require("plugins.configs.lsp.lsp_capabilities").capabilities

  -- base options
  local final_opts = {
    on_attach = attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 500 },
    on_init = function(client)
      -- conditional early bail-out like the example
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath "config" and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
          return
        end
      end

      -- ensure the Lua settings table exists
      client.config.settings = client.config.settings or {}
      client.config.settings.Lua = client.config.settings.Lua or {}

      -- deep-extend runtime/workspace as in the modern example
      client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
        runtime = {
          version = "LuaJIT",
          path = { "lua/?.lua", "lua/?/init.lua" },
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
          },
        },
      })
    end,
    settings = {
      Lua = {}, -- baseline so the key exists; on_init will augment it
    },
  }

  -- register and enable
  vim.lsp.config["lua_ls"] = vim.tbl_deep_extend("force", vim.lsp.config.lua_ls or {}, final_opts)
  vim.lsp.enable "lua_ls"
end
return M
