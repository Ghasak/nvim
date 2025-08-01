-- lua/plugins/configs/lsp/custom_servers/sumneko_lua_server.lua

-- NOTE: Recommended to have folke/neodev.nvim loaded and setup before this runs.
-- If using neodev.nvim, it will automatically enrich workspace.library appropriately.

local runtime_path = vim.split(package.path, ";")
-- keep typical Lua module search patterns
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

return {
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },

      runtime = {
        version = "LuaJIT", -- Neovim uses LuaJIT
        path = runtime_path,
      },

      diagnostics = {
        globals = {
          "vim",
          "require",
          "ipairs",
          "pairs", -- fixed typo from "pair"
          "pcall",
          -- If you have custom diagnostic highlight names or UI (e.g., from plugins):
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
        -- Populate with all Neovim runtime Lua files (safer and more complete than manual list)
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false, -- disable prompt about third-party library checking if undesired

        -- performance tuning (you can adjust if you hit scaling issues)
        maxPreload = 100000,
        preloadFileSize = 10000,
      },

      telemetry = {
        enable = false,
      },
    },
  },
}

