local M = {}

M.setup = function()

  ---- *****************************************************************************************
  ----                                Prerequisites settings supports
  ---- *****************************************************************************************
  -- Pre settings for Rust language servers
  local rust_tools_settings = require("plugins.configs.lsp.custom_servers.rust_analyzer_server")
  -- Configurations for the lsp, offers varities of settings for the diagnostics
  -- messages and Icons on the gutters. (custom the erro icons mainly)
  require("plugins.configs.lsp.lsp_settings").setup()

  ---- *****************************************************************************************
  ----                     Mason Loader (similar to nvim-lsp-installer)
  ---- *****************************************************************************************
  -- 1.) >> Main lsp Mason LSP <<
  require("mason").setup()

  -- 2.) >> Loading Mason lspconfig (mason-config) <<
  local mason_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not mason_status_ok then
    vim.notify("Couldn't load Mason-LSP-Config" .. mason_lspconfig, "error")
    return
  end

  -- Extension to bridge mason.nvim with the lspconfig plugin
  mason_lspconfig.setup({
    -- A list of servers to automatically install if they're not already installed.
    ensure_installed = { "pyright", "sumneko_lua", "rust_analyzer", "tsserver", "texlab", "clangd" }
  })
  -- 3.) >> Mason-tool-installer: installing speicific linterning and tools for specific lps.
  -- Tools for serers
  require("mason-tool-installer").setup {
    ensure_installed = { "codelldb", "stylua", "shfmt", "shellcheck", "black", "isort", "prettierd" },
    auto_update = false,
    run_on_start = true,
  }
  -- 4.) >> lspconfig main loader for the lsp
  local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
  if not lspconfig_status_ok then
    vim.notify("Couldn't load LSP-Config" .. lspconfig, "error")
    return
  end

  -- ==========================================================================
  -- =                                                                        =
  -- =                                                                        =
  -- =                                                                        =
  -- =                         Main LSP Engine                                =
  -- =                   Custom Language Server (CLS)                         =
  -- =                                                                        =
  -- =                                                                        =
  -- =                                                                        =
  -- ==========================================================================
  -- Read more Here: https://github.com/williamboman/mason.nvim/discussions/92#discussioncomment-3173425
  --         flags = {debounce_text_changes = 500},


  local opts = {
    on_attach      = require("plugins.configs.lsp.lsp_attach").custom_attach,
    capabilities   = require("plugins.configs.lsp.lsp_capabilities").capabilities,
    handlers       = require("plugins.configs.lsp.lsp_handlers").handlers,
    special_attach = require("plugins.configs.lsp.lsp_special_attach").custom_attach
  }
  --
  mason_lspconfig.setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- Default handler (optional)
      lspconfig[server_name].setup {
        on_attach    = opts.on_attach,
        capabilities = opts.capabilities,
        handlers     = opts.handlers
      }
    end,
    ["sumneko_lua"] = function()

      local sumneko_settings = require "plugins.configs.lsp.custom_servers.sumneko_lua_server"
      opts = vim.tbl_deep_extend("force", sumneko_settings, opts)
      lspconfig.sumneko_lua.setup({
        on_attach    = opts.on_attach,
        capabilities = opts.capabilities,
        handlers     = opts.handlers,
        flags        = { debounce_text_changes = 500 },
        settings     = opts.settings
      })
    end,

    -- Next, you can provide targeted overrides for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["rust_analyzer"] = function()

      -- Requesting rust_tools: for Rust analyzer
      local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
      if not rust_tools_status_ok then
        return
      end
      rust_tools.setup { -- Defined above
        tools = {
          on_initialized = function()
            --   vim.cmd [[
            --   autocmd BufEnter,CursorHold,InsertLeave,BufWritePost *.rs silent! lua vim.lsp.codelens.refresh()
            -- ]]
            vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
              pattern = { "*.rs" },
              callback = function()
                vim.lsp.codelens.refresh()
              end

            })
          end,

          executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
          reload_workspace_from_cargo_toml = true,
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "<-",
            other_hints_prefix = "=>",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          hover_actions = {
            border = "rounded",
            auto_focus = true,
          },
        },

        server = {
          on_attach = opts.on_attach,
          handlers = opts.handlers,
          settings = rust_tools_settings,
        },
      }

    end,

    ["texlab"] = function()
      lspconfig.texlab.setup({
        on_attach = opts.custom_attach,
        handlers = opts.handlers,
        settings = {
          latex = {
            rootDirectory = ".",
            build = {
              args = {
                "-pdf", "-interaction=nonstopmode", "-synctex=1", "-pvc"
              },
              forwardSearchAfter = true,
              onSave = true
            },
            forwardSearch = {
              executable = "zathura",
              args = { "--synctex-forward", "%l:1:%f", "%p" },
              onSave = true
            }
          }
        }
      })

    end,

    ["pyright"] = function()
      lspconfig.pyright.setup({
        on_attach    = opts.on_attach,
        capabilities = opts.capabilities,
        handlers     = opts.handlers,
        settings     = {
          python = {
            analysis = {
              -- Disable strict type checking
              typeCheckingMode = "off"
            }
          }
        },
      })
    end,
  })

end
return M
