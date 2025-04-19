local runtime_path = vim.split("package.path", ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
table.insert(runtime_path, "?/init.lua")

return {
  settings = {
    Lua = {
      completion = { callSnippet = "Replace" },

      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {
          "vim",
          "require",
          "ipairs",
          "pair",
          "pcall",
          "DiagnosticError",
          "DiagnosticLineNrError",
          "DiagnosticWarn",
          "DiagnosticInfo",
          "DiagnosticLineNrInfo",
          "DiagnosticHint",
          "DiagnosticLineNrHint",
          "DiagnosticLineNrWarn",
          "neovide",
        },
      },
      workspace = {
        library = vim
          .iter({
            vim.api.nvim_get_runtime_file("", true),
            { vim.fn.expand "$VIMRUNTIME/lua" },
            { vim.fn.expand "$VIMRUNTIME/lua/vim/lsp" },
            { vim.fn.stdpath "data" .. "/lazy/extensions/nvchad_types" },
            { vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy" },
          })
          :flatten()
          :totable(),
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
    },
  },
}
