-- ==========================================================================
-- 	                    LAZY UTILITIES LOADER
-- ==========================================================================
local plugins = require("plugins.pluginsHub")

--- Install lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
    }
end
vim.opt.rtp:prepend(lazypath)
-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then return end
-- Change the color of the lazynvim floating window
vim.api.nvim_set_hl(0, "NormalFloat", {bg = "#1e222a"})

-- Configure lazy.nvim
lazy.setup(plugins, {
    defaults = {lazy = true, version = nil},
    install = {
        missing = true,
        colorscheme = {"onedark", "tokyonight", "gruvbox"}
    },
    checker = {enabled = true},
    ui = {border = {"╔", "═", "╗", "║", "╝", "═", "╚", "║"}},
    performance = {
        cache = {enabled = true},
        rtp = {
            disabled_plugins = {
                "gzip", "matchit", "matchparen", "netrwPlugin", "tarPlugin",
                "tohtml", "tutor", "zipPlugin"
            }
        }
    }
})
vim.keymap.set("n", "<leader>z", "<cmd>:Lazy<cr>", {desc = "Plugin Manager"})

vim.opt.termguicolors = true
-- do not remove the colorscheme!
vim.cmd([[colorscheme onedark]])

