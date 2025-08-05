-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 🧠  Module Overview                                                          │
-- ├──────────────────────────────────────────────────────────────────────────────┤
-- │ 📦  Purpose                                                                  │
-- │   Provides centralized, registry-style setup for language servers (LSP) with │
-- │   sensible defaults, global hooks, and per-language customization tailored   │
-- │   to your Neovim environment.                                                │
-- │                                                                              │
-- │ 🔄  Design Principles                                                        │
-- │   • Non-intrusive: respects existing on_attach/on_init flow.                 │
-- │   • Idempotent: avoids duplicate clients via guards.                         │
-- │   • Deferred heavy setup (e.g., rust-tools) until necessary.                 │
-- │   • Unified capabilities and diagnostics management for consistency.         │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
-- ┌──────────────────────────────────────────────────────────────────────────────┐
-- │  ┌────────────────────*           ┌────────────────* ┌─────────────────────* │
-- │  │lsp_capabilities.lua│           │ lsp_attach.lua │ │    lsp_setting      │ │
-- │  └──────────┬─────────┘           └───────┬────────┘ │ (diagnostics setup) │ │
-- │             │                             ▼          └─────────┬───────────┘ │
-- │             │          ┌──────────────────────*                │             │
-- │             └─────────▶│   M.setup() builds   │◀───────────────┘             │
-- │                        │ vim.lsp.config calls │                              │
-- │                        └──────────────────────┘                              │
-- │                                     ▲                                        │
-- │  ┌─────────────────────────────*    │                                        │
-- │  │ lsp_mason_tools.tool_setup()│────┘                                        │
-- │  │   (bootstraps external bins)│                                             │
-- └──────────────────────────────────────────────────────────────────────────────┘

-- lua/your_module_name/lsp_core.lua
local M = {}
-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 🧩  Initialization & Dependencies                                            │
-- ╰──────────────────────────────────────────────────────────────────────────────╯
--  🔧  Neodev integration
--    • Attempts to load `neodev` for enhanced Lua development experience
--      (runtime type awareness, improved completions, library introspection).
--    • Must be setup before lspconfig so that lua_ls can inherit its benefits.
-- Lua additional support from lua-dev
-- IMPORTANT: make sure to setup lua-dev BEFORE lspconfig
local neodev_status, neodev = pcall(require, "neodev")
if neodev_status then neodev.setup {} end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 🛠  on_init override                                                         │
-- │   • Custom `on_init` that disables semantic tokens if the server advertises  │
-- │     support — avoids potential visual/performance issues from default token  │
-- │     rendering in your workflow.                                              │
-- ╰──────────────────────────────────────────────────────────────────────────────╯

-- on_init: tweak client capabilities (disable semantic tokens if supported)
function M.on_init(client, _)
  if client.supports_method and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

-- ╭──────────────────────────────────────────────────────────────────────────────╮
-- │ 🌐  Global attach & capabilities                                             │
-- │   • Imports shared `on_attach_global` which encapsulates buffer-local keymaps│
-- │     and behaviors.                                                           │
-- ╰──────────────────────────────────────────────────────────────────────────────╯

M.on_attach_global = require("plugins.configs.lsp.lsp_attach").on_attach_global

-- ╭────────────────────────────────────────────────────────────────────────────────╮
-- │ 🧪  Diagnostics setup                                                          │
-- │   • Calls the shared diagnostics module to define signs, handlers, and styling │
-- │     globally — ensures uniform diagnostic presentation across servers.         │
-- ╰────────────────────────────────────────────────────────────────────────────────╯

-- Setup diagnostics globally
local diagnostics = require "plugins.configs.lsp.lsp_settings"
diagnostics.setup() -- Call sign definitions globally

-- ╭────────────────────────────────────────────────────────────────────────────────╮
-- │ 🧪  capabilities for the lsp setting                                           │
-- │   • Loads centralized capability enhancements (e.g., completion tweaks) so     │
-- │     all servers start from the same baseline.                                  │
-- ╰────────────────────────────────────────────────────────────────────────────────╯
-- capabilities (can be replaced/extended later)
M.capabilities = require("plugins.configs.lsp.lsp_capabilities").capabilities or {}

-- ╭────────────────────────────────────────────────────────────────────────────────╮
-- │ 🎨  Color scheme selector                                                      │
-- │   • Invokes custom logic to apply LSP-aware highlight tweaks (for/if/loops on  │
-- │     cursor hold) so code semantics are visually reinforced.                    │
-- ╰────────────────────────────────────────────────────────────────────────────────╯
-- local color_scheme_lsp_selector = require("plugins.configs.lsp.lsp_attach").color_scheme_lsp_selector
-- color_scheme_lsp_selector()
-- ╭────────────────────────────────────────────────────────────────────────────────╮
-- │ 🚀  Entry Point: M.setup()                                                     │
-- ├────────────────────────────────────────────────────────────────────────────────┤
-- │ 🎯  Purpose                                                                    │
-- │   Declares and configures all language servers in one place, including guards, │
-- │   project-scoped root logic, deferred tooling (rust-tools), and enables the    │
-- │   desired ones explicitly.                                                     │
-- ╰────────────────────────────────────────────────────────────────────────────────╯
function M.setup()
  -- ╭────────────────────────────────────────────────────────────────────────────╮
  -- │ 🈳  Lua Language Server (lua_ls) Setup                                     │
  -- ╰────────────────────────────────────────────────────────────────────────────╯
  -- ── Lua ─────────────────────────────────────────────────────────────
  local lua_lsp_settings = require("plugins.configs.lsp.custom_servers.sumneko_lua_server_settings").settings
  local lua_lsp_on_init = require("plugins.configs.lsp.custom_servers.sumneko_lua_server_on_init").lua_lsp_on_init
  -- ╭────────────────────────────────────────────────────────────────────────────╮
  -- │ 🌍  Global LSP config fallback / wildcard registration                     │
  -- │     (applies to any language/server unless overridden)                     │
  -- ╰────────────────────────────────────────────────────────────────────────────╯

  vim.lsp.config("*", { capabilities = M.capabilities, on_init = M.on_init, on_attach = M.on_attach_global })
  vim.lsp.config(
    "lua_ls",
    { settings = lua_lsp_settings, on_init = lua_lsp_on_init, flags = { debounce_text_changes = 500 } }
  )

  -- ── Python ─────────────────────────────────────────────────────────────
  local function ensure_single_client(name, root_dir)
    for _, client in ipairs(vim.lsp.get_clients()) do
      if client.name == name and client.config and client.config.root_dir == root_dir then
        return true -- already running
      end
    end
    return false
  end
  local root = require("lspconfig.util").root_pattern("pyproject.toml", ".git")(vim.fn.getcwd())
  --
  -- -- Using pyright-lsp
  local site_package_path = vim.fn.systemlist("python3 -c 'import site; print(site.getsitepackages()[0])'")[1]
  vim.lsp.config("pyright", {
    on_init = M.on_init,
    on_attach = M.on_attach_global,
    capabilities = M.capabilities,
    flags = { debounce_text_changes = 500 },
    cmd = { "pyright-langserver", "--stdio" },
    settings = {
      python = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          extraPaths = { "./src", site_package_path },
        },
      },
    },
  })
  --

  if not ensure_single_client("pyrefly", root) then
    -- Using pyrefly-lsp from meta
    vim.lsp.config("pyrefly", {
      on_init = M.on_init,
      on_attach = M.on_attach_global,
      capabilities = M.capabilities,
      -- cmd = { "uv", "run", "pyrefly", "lsp" },
      -- cmd = { "sh", "-c", "uv run pyrefly lsp" },
      flags = { debounce_text_changes = 500, exit_timeout = 5000 },
      cmd = { "pyrefly", "lsp" },
      -- cmd = { "uv", "run", "pyrefly", "lsp" },
      filetypes = { "python" },
      root_markers = {
        "pyrefly.toml",
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        ".git",
      },

      on_exit = function(code, _, _)
        os.execute "pkill -f 'pyrefly lsp'"
        vim.notify("Closing Pyrefly LSP exited with code: " .. code, vim.log.levels.INFO)
      end,
    })
  end

  -- ── Rust ─────────────────────────────────────────────────────────────

  -- Pre settings for Rust language servers
  local rust_tools_settings = require "plugins.configs.lsp.custom_servers.rust_analyzer_server"
  local rust_opts = {
    on_attach = M.on_attach_global,
    capabilities = M.capabilities,
    flags = { debounce_text_changes = 500 },
    settings = rust_tools_settings,
  }
  vim.lsp.config("rust_analyzer", rust_opts)

  -- Defer rust-tools setup until entering Rust filetype
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "rust",
    once = true,
    callback = function()
      local ok, rust_tools = pcall(require, "rust_tools")
      if not ok then return end
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
            parameter_hints_prefix = "  ",
            other_hints_prefix = "  ",
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

  -- ── Other LSP servers (keeping your existing configs) ─────────────────

  -- Latex
  vim.lsp.config("texlab", {
    on_attach = M.on_attach_global,
    capabilities = M.capabilities,
    flags = { debounce_text_changes = 500 },
    settings = {
      latex = {
        rootDirectory = ".",
        build = {
          args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-pvc" },
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
  })

  -- TypeScript / JavaScript
  vim.lsp.config("ts_ls", {
    on_attach = M.on_attach_global,
    capabilities = M.capabilities,
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript" },
  })

  -- R Language Server
  vim.lsp.config("r_language_server", {
    on_attach = M.on_attach_global,
    capabilities = M.capabilities,
    filetypes = { "r", "rmd" },
    cmd = { "R", "--slave", "-e", "languageserver::run()" },
  })

  -- SQL Language Server
  vim.lsp.config("sqlls", {
    on_attach = M.on_attach_global,
    capabilities = M.capabilities,
    filetypes = { "sql" },
    cmd = { "sql-language-server", "up", "--method", "stdio" },
    root_dir = function(fname)
      return require("lspconfig.util").root_pattern ".git"(fname)
        or vim.fs.dirname(fname)
        or require("lspconfig.util").root_pattern "config.yml"(fname)
        or vim.fn.getcwd()
    end,
  })

  -- C / C++ Language Server
  vim.lsp.config("clangd", {
    on_attach = M.on_attach_global,
    capabilities = M.capabilities,
    filetypes = { "cpp", "c" },
    on_new_config = function(new_config, new_cwd)
      local ok, cmake = pcall(require, "cmake-tools")
      if ok then cmake.clangd_on_new_config(new_config) end
    end,
  })

  -- ╭────────────────────────────────────────────────────────────────────────────────╮
  -- │ 🧪  Explicit Enable List & Tooling Bootstrap                                   │
  -- │   • Force-enable the desired language servers                                  │
  -- │     (makes sure they’re considered in your  registry / startup logic)          │
  -- ╰────────────────────────────────────────────────────────────────────────────────╯

  vim.lsp.enable {
    "lua_ls",
    "pyright",
    "pyrefly",
    "rust_analyzer",
    "texlab",
    "ts_ls",
    "r_language_server",
    "sqlls",
    "clangd",
  }

  -- ╭────────────────────────────────────────────────────────────────────────────────╮
  -- │ 🧪  Explicit Enable List & Tooling Bootstrap                                   │
  -- │   • Mason / mason-lspconfig / mason-tool-installer bootstrap.                  │
  -- │     (Ensures external binary dependencies are installed                        │
  -- │         and kept in sync with config expectations. )                           │
  -- ╰────────────────────────────────────────────────────────────────────────────────╯
  require("plugins.configs.lsp.lsp_mason_tools").tool_setup()
end

return M
