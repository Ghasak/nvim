local runtime_path = vim.split("package.path", ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return {
  settings = {
    Lua = {
      runtime = {
        -- LuaJIT inn the case of Neovim
        version = "LuaJIT",
        path = vim.split(package.path, ";")
      },
      diagnostics = { globals = { "vim", "use", "packer_plugins" } },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          vim.api.nvim_get_runtime_file("", true),
        },
        maxPreload = 100000,
        preloadFileSize = 10000
      },
      telemetry = { enable = false }
    }
  }


}
