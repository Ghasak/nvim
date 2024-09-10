local M = {}

M.setup = function()
  ---- *****************************************************************************************
  ----                                Prerequisites settings supports
  ---- *****************************************************************************************
  -- Pre settings for Rust language servers
  local rust_tools_settings = require "plugins.configs.lsp.custom_servers.rust_analyzer_server"
  -- ------------------------------------------------
  -- Configurations for the lsp, offers varities of settings for the diagnostics
  -- messages and Icons on the gutters. (custom the erro icons mainly)
  require("plugins.configs.lsp.lsp_settings").setup()
  -- ------------------------------------------------
  -- Lua additional support from lua-dev
  -- IMPORTANT: make sure to setup lua-dev BEFORE lspconfig
  local neodev_status, neodev = pcall(require, "neodev")
  if neodev_status then
    neodev.setup {}
  end

  ---- *****************************************************************************************
  ----                     Mason Loader (similar to nvim-lsp-installer)
  ---- *****************************************************************************************
  -- 1.) >> Main lsp Mason LSP <<
  require("mason").setup {
    ui = {
      -- Whether to automatically check for new versions when opening the :Mason window.
      check_outdated_packages_on_open = true,
      -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
      -- border = "rounded",
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
  mason_lspconfig.setup {
    -- A list of servers to automatically install if they're not already installed.,
    ensure_installed = {
      "pyright",
      "lua_ls",
      "rust_analyzer",
      --"ts_ls",
      "texlab",
      "clangd", -- "dockerls", "docker_compose_language_service", "jsonls", "r_language_server", "vimls"
      "r_language_server",
      "jqls",
      "cmake",
    },
    ui = {
      -- Whether to automatically check for new versions when opening the :Mason window.
      check_outdated_packages_on_open = true,
      -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
      border = "double",
    },
  }
  -- 3.) >> Mason-tool-installer: installing speicific linterning and tools for specific lps.
  -- Tools for serers
  require("mason-tool-installer").setup {
    ensure_installed = {
      "stylua",
      "codelldb",
      "shfmt",
      "shellcheck",
      "black",
      "isort",
      "prettierd",
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
    -- Adding a boarder to the lspInfo window.
    require("lspconfig.ui.windows").default_options.border = "double"
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
    on_attach = require("plugins.configs.lsp.lsp_attach").custom_attach,
    capabilities = require("plugins.configs.lsp.lsp_capabilities").capabilities,
    handlers = require("plugins.configs.lsp.lsp_handlers").handlers,
    special_attach = require("plugins.configs.lsp.lsp_special_attach").custom_attach,
  }

  --
  mason_lspconfig.setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- Default handler (optional)
      lspconfig[server_name].setup {
        on_attach = opts.on_attach,
        capabilities = vim.deepcopy(opts.capabilities),
        handlers = opts.handlers,
      }
    end,
    ["lua_ls"] = function()
      local sumneko_settings = require "plugins.configs.lsp.custom_servers.sumneko_lua_server"
      opts = vim.tbl_deep_extend("force", sumneko_settings, opts)
      lspconfig.lua_ls.setup {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        handlers = opts.handlers,
        flags = { debounce_text_changes = 500 },
        settings = opts.settings,
      }
    end,
    -- Next, you can provide targeted overrides for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["rust_analyzer"] = function()
      local install_root_dir = vim.fn.stdpath "data" .. "/mason"
      local extension_path = install_root_dir .. "/packages/codelldb/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

      -- Requesting rust_tools: for Rust analyzer
      local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
      if not rust_tools_status_ok then
        return
      end
      rust_tools.setup { -- Defined above
        tools = {
          on_initialized = function()
            vim.api.nvim_create_autocmd({
              "BufWritePost",
              "BufEnter",
              "CursorHold",
              "InsertLeave",
            }, {
              pattern = { "*.rs" },
              callback = function()
                -- Getting loading the codelens without popup an error message.
                local _, _ = pcall(vim.lsp.codelens.refresh)
              end,
            })
          end,
          executor = require("rust-tools/executors").termopen, -- can be quickfix or termopen
          reload_workspace_from_cargo_toml = true,
          runnables = { use_telescope = true }, -- added for supporting telescope to run
          inlay_hints = {
            auto = true,
            only_current_line = false,
            show_parameter_hints = true,
            parameter_hints_prefix = "  ",
            other_hints_prefix = "  ",
            max_len_align = false,
            max_len_align_padding = 1,
            right_align = false,
            right_align_padding = 7,
            highlight = "Comment",
          },
          hover_actions = { border = "double", auto_focus = true },
        },

        server = {
          on_attach = opts.on_attach,
          handlers = opts.handlers,
          capabilities = opts.capabilities, -- aslo added here new
          settings = rust_tools_settings,
        },
        -- debugging stuff
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    end,
    ["texlab"] = function()
      lspconfig.texlab.setup {
        on_attach = opts.custom_attach,
        handlers = opts.handlers,
        settings = {
          latex = {
            rootDirectory = ".",
            build = {
              args = {
                "-pdf",
                "-interaction=nonstopmode",
                "-synctex=1",
                "-pvc",
              },
              forwardSearchAfter = true,
              onSave = true,
            },
            forwardSearch = {
              executable = "zathura",
              args = { "--synctex-forward", "%l:1:%f", "%p" },
              onSave = true,
            },
          },
        },
      }
    end,
    ["pyright"] = function()
      lspconfig.pyright.setup {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        handlers = opts.handlers,
        settings = {
          python = {
            analysis = {
              -- Disable strict type checking
              typeCheckingMode = "off",
            },
          },
        },
      }
    end,
    ["ts_ls"] = function() -- Deprecates the tsserver server
      lspconfig.ts_ls.setup {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        handlers = opts.handlers,
        -- Language Server JavaScript/TypScript, npm install -g typescript-language-server typescript
        -- Already installed with Mason, so if you don't want to use this, you should uncomment cmd
        -- https://www.npmjs.com/package/typescript-language-server
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = {
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "javascript",
        },
      }
    end,
    ["r_language_server"] = function()
      lspconfig.r_language_server.setup {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        handlers = opts.handlers,
        filetypes = { "r", "rmd" },
        cmd = { "R", "--slave", "-e", "languageserver::run()" },
      }
    end,
    -- For C/C++ language
    ["clangd"] = function()
      lspconfig.clangd.setup {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        handlers = opts.handlers,
        filetypes = { "cpp", "c" },
        ---@diagnostic disable-next-line: unused-local
        on_new_config = function(new_config, new_cwd)
          local status, cmake = pcall(require, "cmake-tools")
          if status then
            cmake.clangd_on_new_config(new_config)
          end
        end,
      }
    end,
  }
end
return M
