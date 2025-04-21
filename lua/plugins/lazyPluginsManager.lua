-- ==========================================================================
-- 	                    LAZY UTILITIES LOADER
-- ==========================================================================
local lazyManagerConfig = {
  defaults = { lazy = true, version = nil },
  install = {
    missing = true,
    colorscheme = { "onedark", "tokyonight", "gruvbox" },
  },
  lockfile = vim.fn.stdpath "data" .. "/lazy/lazy-lock.json", -- lockfile generated after running update.
  checker = { enabled = false },
  ui = {
    border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
    -- size = { width = 0.5, height = 0.8 },
    -- wrap = true, -- wrap the lines in the ui
    -- icons = {
    --   cmd = "",
    --   config = "",
    --   event = "⚡",
    --   ft = "",
    --   init = "",
    --   import = "",
    --   keys = "",
    --   lazy = "󰒲",
    --   loaded = "✓",
    --   not_loaded = "",
    --   plugin = "",
    --   runtime = "",
    --   source = "",
    --   start = "",
    --   task = "✔",
    --   list = {
    --     "●", -- for top-level entries
    --     "◆", -- for nested items
    --     "▶", -- collapsed
    --     "▼", -- expanded
    --   },
  },
  performance = {
    cache = { enabled = true },
    reset_packpath = true, -- reset the package path to improve startup time
    rtp = {
      rest = true,
      ---@type string[]
      -- paths = {}, -- add any custom paths here that you want to includes in the rtp
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        -- "netrwPlugin",
        -- "netrwSettings",
        -- "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
}
-- ==========================================================================
-- 	                    LAZY UTILITIES LOADER
-- ==========================================================================
local plugins = require "plugins.pluginsHub"

--- Install lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
  return
end

-- Change the color of the lazynvim floating window
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" })
vim.api.nvim_set_hl(0, "Pmenu", { bg = "#2d333b" })
-- Configure lazy.nvim
lazy.setup(plugins, lazyManagerConfig)
