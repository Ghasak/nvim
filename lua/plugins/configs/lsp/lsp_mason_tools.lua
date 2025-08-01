local M = {}

M.tool_setup = function()
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
end
return M
