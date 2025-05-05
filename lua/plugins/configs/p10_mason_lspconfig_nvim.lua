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
  -- require("plugins.configs.lsp.lsp_settings").setup()

  -- ------------------------------------------------
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
  require("mason-lspconfig").setup {
    -- A list of LSP servers to automatically install if they're not already installed.
    ensure_installed = {
      "pyright", -- Python LSP
      "lua_ls", -- Lua LSP
      "rust_analyzer", -- Rust LSP
      "texlab", -- LaTeX LSP
      "clangd", -- C/C++ LSP
      "jdtls", -- Java LSP
      "cmake", -- CMake LSP
      "jqls", -- JQ LSP
      -- "java-language-server",
    },
    ui = {
      -- Whether to automatically check for new versions when opening the :Mason window.
      check_outdated_packages_on_open = true,
      -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
      border = "double",
    },
  }

  -- Mason-tool-installer: installing specific linters, formatters, debug adapters, and other tools
  -- You can use ::MasonToolsUpdate
  require("mason-tool-installer").setup {
    ensure_installed = {
      -- Formatters
      "stylua", -- Lua formatter
      "shfmt", -- Shell formatter
      "black", -- Python formatter
      "isort", -- Python import sorter
      "prettierd", -- Multi-language formatter

      -- Linters
      "shellcheck", -- Shell script linter

      -- Debug Adapters
      "codelldb", -- C/C++/Rust debug adapter
      "debugpy", -- Python debug adapter
      -- Java debug adapter not availale from: https://open-vsx.org/api/vscjava/vscode-java-debug/0.58.1/file/vscjava.vscode-java-debug-0.58.1.vsix
      "java-debug-adapter",
      "bash-debug-adapter", -- Bash debug adapter

      -- Java-specific tools
      "java-test", -- Java test runner for JUnit not avaialable from: https://open-vsx.org/api/vscjava/vscode-java-test/0.43.0/file/vscjava.vscode-java-test-0.43.0.vsix
      "vscode-java-decompiler", -- Java decompiler

      -- Other tools
      "cpptools", -- C/C++ debug tools
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

  -- ╭──────────────────────────────────────────────────────────────────────────────╮
  -- │ 🧠 Modern Neovim v0.11+ LSP Diagnostics Setup                                │
  -- ├──────────────────────────────────────────────────────────────────────────────┤
  -- │ ✨ Updated for Neovim v0.11+:                                                │
  -- │   • `vim.lsp.with()` is deprecated ❌                                        │
  -- │   • `vim.lsp.handlers.hover()` and others are deprecated or removed ❌       │
  -- │   • New `vim.diagnostic.config(cfg, ns_id)` is required ✅                   │
  -- │                                                                              │
  -- │ 🔧 What we did:                                                              │
  -- │   • ✅ Global sign icons defined via `lsp_diagnostics.setup()`               │
  -- │   • ✅ Per-client diagnostic config using `vim.diagnostic.config(...)`       │
  -- │        now wrapped in `diagnostics.on_attach(client, bufnr)`                 │
  -- │   • ✅ Our `opts.on_attach` now merges diagnostic setup + our old attach     │
  -- │                                                                              │
  -- │ 📦 Modular Design:                                                           │
  -- │   • `plugins.configs.lsp.lsp_diagnostics` handles signs + per-client setup   │
  -- │   • `on_attach()` keeps things DRY and per-client namespaces accurate        │
  -- │                                                                              │
  -- │ 🚀 Benefits:                                                                 │
  -- │   • No more deprecated LSP handler calls                                     │
  -- │   • Stable with future Neovim versions                                       │
  -- │   • Cleaner and more maintainable LSP code                                   │
  -- ╰──────────────────────────────────────────────────────────────────────────────╯

  -- on attachment
  local diagnostics = require "plugins.configs.lsp.lsp_settings"
  diagnostics.setup() -- Call sign definitions globally
  local base_on_attach = require("plugins.configs.lsp.lsp_attach").custom_attach

  local opts = {
    on_attach = function(client, bufnr)
      diagnostics.on_attach(client, bufnr) -- Per-client diagnostic config
      base_on_attach(client, bufnr) -- Your existing on_attach logic
    end,
    capabilities = require("plugins.configs.lsp.lsp_capabilities").capabilities,
    special_attach = require("plugins.configs.lsp.lsp_special_attach").custom_attach,
  }

  -- ╭────────────────────────────────────────────────────────────────────────────╮
  -- │ 🚀 LSP Server Setup via `mason-lspconfig.setup_handlers()`                 │
  -- ├────────────────────────────────────────────────────────────────────────────┤
  -- │ 🎯 Modernized for Neovim v0.11+:                                           │
  -- │   • 🧠 Uses `vim.lsp.config()` and `vim.lsp.enable()` per new API          │
  -- │   • ❌ Avoids deprecated `lspconfig.SERVER.setup()` for custom servers     │
  -- │   • ✅ Ensures full control over settings, capabilities & attach logic     │
  -- │   • 🔄 Supports deep-merging of custom configs using `tbl_deep_extend()`   │
  -- │                                                                            │
  -- │ 📦 Structure:                                                              │
  -- │   • A default handler installs basic LSPs using `opts.on_attach`           │
  -- │   • Specialized language handlers (e.g. Lua, Rust, Python) override this   │
  -- │     to apply extended configurations and tool integrations                 │
  -- │                                                                            │
  -- │ 🛠️ Examples:                                                               │
  -- │   • Lua (lua_ls): Uses custom runtime settings & global definitions        │
  -- │   • Rust (rust_analyzer): Uses rust-tools for inlay hints, DAP, etc.       │
  -- │   • Python (pyright): Tweaks analysis type-checking + extraPaths           │
  -- │   • C/C++ (clangd): Auto-injected with CMake tools                         │
  -- │                                                                            │
  -- │ ✨ Benefits:                                                               │
  -- │   • 🚫 No more deprecated setup methods                                    │
  -- │   • 🔌 Seamless integration with Mason, custom servers, and tools          │
  -- │   • 🔍 Precise per-language behavior with complete LSP fidelity            │
  -- ╰────────────────────────────────────────────────────────────────────────────╯

  -- Setup handlers for all installed servers
  mason_lspconfig.setup_handlers {

    -- Default handler
    function(server_name)
      lspconfig[server_name].setup {
        on_attach = opts.on_attach,
        capabilities = vim.deepcopy(opts.capabilities),
      }
    end,

    --------------------------- Lua Language Server -----------------------------
    -- Custom handler for lua_ls using Neovim v0.11+ APIs
    ["lua_ls"] = function()
      local lua_opts = require "plugins.configs.lsp.custom_servers.sumneko_lua_server"
      local base_opts = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        flags = { debounce_text_changes = 500 },
      }

      -- Deep-merge base config and custom lua settings
      local merged_opts = vim.tbl_deep_extend("force", base_opts, lua_opts)

      -- Register config with new v0.11+ API
      vim.lsp.config("lua_ls", merged_opts)
    end,

    --------------------------- Python Language Server -----------------------------

    ["pyright"] = function()
      local site_package_path = vim.fn.systemlist("python3 -c 'import site; print(site.getsitepackages()[0])'")[1]
      local pyright_opts = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        -- handlers = opts.handlers,
        flags = { debounce_text_changes = 500 },
        settings = {
          python = {
            analysis = {
              -- pythonPath = vim.fn.expand "~" .. "/anaconda3/bin/python3",
              -- typeCheckingMode = "off", -- Disable strict type checking
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              -- extraPaths = { "./src" }, -- Add custom paths for analysis
              extraPaths = { "./src", site_package_path },
            },
          },
        },
      }

      -- Register config using new API
      vim.lsp.config("pyright", pyright_opts)
    end,

    --------------------------- Rust Language Server -----------------------------
    ["rust_analyzer"] = function()
      -- Set up the LSP client as usual (without rust-tools yet)
      local rust_opts = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        -- handlers = opts.handlers,
        flags = { debounce_text_changes = 500 },
        settings = rust_tools_settings, -- your custom settings
      }

      vim.lsp.config("rust_analyzer", rust_opts)

      -- Defer rust-tools setup until entering Rust filetype
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "rust",
        once = true, -- Only trigger once per session
        callback = function()
          local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
          if not rust_tools_status_ok then return end

          local install_root_dir = vim.fn.stdpath "data" .. "/mason"
          local extension_path = install_root_dir .. "/packages/codelldb/extension/"
          local codelldb_path = extension_path .. "adapter/codelldb"
          local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"

          rust_tools.setup {
            tools = {
              executor = require("rust-tools/executors").termopen,
              reload_workspace_from_cargo_toml = true,
              runnables = { use_telescope = true },
              hover_actions = { border = "double", auto_focus = true },
              inlay_hints = {
                auto = true,
                show_parameter_hints = true,
                parameter_hints_prefix = "  ",
                other_hints_prefix = "  ",
                highlight = "Comment",
              },
              on_initialized = function()
                vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
                  pattern = { "*.rs" },
                  callback = function() pcall(vim.lsp.codelens.refresh) end,
                })
              end,
            },
            server = rust_opts,
            dap = {
              adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
            },
          }
        end,
      })
    end,

    -- ["rust_analyzer"] = function()
    --   if vim.bo.filetype ~= "rust" then return end
    --   local install_root_dir = vim.fn.stdpath "data" .. "/mason"
    --   local extension_path = install_root_dir .. "/packages/codelldb/extension/"
    --   local codelldb_path = extension_path .. "adapter/codelldb"
    --   local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
    --
    --   -- Load rust-tools plugin safely
    --   local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
    --   if not rust_tools_status_ok then return end
    --
    --   -- Define Rust LSP settings
    --   local rust_opts = {
    --     on_attach = opts.on_attach,
    --     capabilities = opts.capabilities,
    --     handlers = opts.handlers,
    --     flags = { debounce_text_changes = 500 },
    --     settings = rust_tools_settings, -- assuming you define this elsewhere
    --   }
    --
    --   -- Register the config with Neovim 0.11+
    --   vim.lsp.config("rust_analyzer", rust_opts)
    --   vim.lsp.enable "rust_analyzer"
    --
    --   -- Optional: use rust-tools to extend functionality
    --   rust_tools.setup {
    --     tools = {
    --       executor = require("rust-tools/executors").termopen,
    --       reload_workspace_from_cargo_toml = true,
    --       runnables = { use_telescope = true },
    --       hover_actions = { border = "double", auto_focus = true },
    --       inlay_hints = {
    --         auto = true,
    --         only_current_line = false,
    --         show_parameter_hints = true,
    --         parameter_hints_prefix = "  ",
    --         other_hints_prefix = "  ",
    --         max_len_align = false,
    --         max_len_align_padding = 1,
    --         right_align = false,
    --         right_align_padding = 7,
    --         highlight = "Comment",
    --       },
    --       on_initialized = function()
    --         vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
    --           pattern = { "*.rs" },
    --           callback = function() pcall(vim.lsp.codelens.refresh) end,
    --         })
    --       end,
    --     },
    --     server = rust_opts, -- pass the same config as registered above
    --     dap = {
    --       adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
    --     },
    --   }
    -- end,
    --
    --------------------------- LaTeX Language Server -----------------------------
    ["texlab"] = function()
      local texlab_opts = {
        on_attach = opts.custom_attach,
        capabilities = opts.capabilities,
        -- handlers = opts.handlers,
        flags = { debounce_text_changes = 500 },
        settings = {
          latex = {
            rootDirectory = ".", -- Set root directory for LaTeX project
            build = {
              args = {
                "-pdf",
                "-interaction=nonstopmode",
                "-synctex=1",
                "-pvc", -- continuous preview on change
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

      -- Register config with Neovim's LSP client
      vim.lsp.config("texlab", texlab_opts)
    end,

    --------------------------- TypeScript / JavaScript -----------------------------
    ["ts_ls"] = function()
      local ts_opts = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        -- handlers = opts.handlers,
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = {
          "typescript",
          "typescriptreact",
          "typescript.tsx",
          "javascript",
        },
      }

      -- Register with Neovim v0.11+ API
      vim.lsp.config("ts_ls", ts_opts)
    end,

    --------------------------- R Language Server -----------------------------
    ["r_language_server"] = function()
      local r_opts = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        -- handlers = opts.handlers,
        filetypes = { "r", "rmd" },
        cmd = { "R", "--slave", "-e", "languageserver::run()" },
      }

      vim.lsp.config("r_language_server", r_opts)
    end,

    --------------------------- SQL Language Server -----------------------------
    ["sqlls"] = function()
      local sql_opts = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        -- handlers = opts.handlers,
        filetypes = { "sql" },
        cmd = { "sql-language-server", "up", "--method", "stdio" },
        root_dir = function(fname)
          return require("lspconfig.util").root_pattern ".git"(fname)
            or vim.fs.dirname(fname)
            or require("lspconfig.util").root_pattern "config.yml"(fname)
            or vim.fn.getcwd()
        end,
      }

      vim.lsp.config("sqlls", sql_opts)
    end,

    --------------------------- C / C++ Language Server -----------------------------
    ["clangd"] = function()
      local clangd_opts = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        -- handlers = opts.handlers,
        filetypes = { "cpp", "c" },
        on_new_config = function(new_config, new_cwd)
          local ok, cmake = pcall(require, "cmake-tools")
          if ok then cmake.clangd_on_new_config(new_config) end
        end,
      }

      vim.lsp.config("clangd", clangd_opts)
    end,
    --------------------------- Java (JDTLS) -----------------------------
    ["jdtls"] = function()
      -- Skipped: `jdtls` is handled by `ftplugin/java.lua` or `nvim-jdtls`
      -- If not using `nvim-jdtls`, configure your JDT Language Server here.
      -- See official setup: https://github.com/mfussenegger/nvim-jdtls
    end,
  }

  -- Enable the server
  -- Optional: enable it explicitly
  vim.lsp.enable "lua_ls"
  vim.lsp.enable "pyright"
  vim.lsp.enable "texlab"
  vim.lsp.enable "rust_analyzer"
  vim.lsp.enable "ts_ls"
  vim.lsp.enable "r_language_server"
  vim.lsp.enable "sqlls"
  vim.lsp.enable "clangd"
end

return M
