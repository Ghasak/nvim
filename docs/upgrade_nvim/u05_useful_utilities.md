# Useful Information

- This is just followign the right direction from the current objective as you
  can see in the follow item.

```lua
------------------------------------------------------------------
-- configurations placeholder to be removed later - to be added to the githubG
-- vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = "#d0d8df" })
-- vim.api.nvim_set_hl(0, "@variable", { fg = "#d0d8df" })

------------------------------------------------------------------
-- this is not desribale as it will affect `telescope`,
-- vim.o.winborder = 'double'
------------------------------------------------------------------
-- this is need for given a color background to the Glance but it will affect all the other windows.
-- vim.cmd [[
--   highlight Normal guibg=#1e222a
-- ]]

------------------------------------------------------------------
-- this configurations is made for gd or gD using Glance which will request it
-- require("notify").setup {
--   background_colour = "#1e222a", -- Replace with your desired color
-- }
------------------------------------------------------------------
--

--
-- end

-- vim.diagnostic.set(
--   vim.api.nvim_create_namespace("my_test_ns"), -- namespace (unique to your test)
--   0,                                           -- current buffer
--   { -- diagnostics list
--     {
--       lnum = 0,                                -- line (0-indexed, so line 1)
--       col = 0,                                 -- column (0-indexed)
--       severity = vim.diagnostic.severity.HINT, -- HINT = 'k'
--       source = "My Test",                      -- source of the diagnostic
--       message = "This is a test hint!",        -- message shown on hover
--     },
--     {
--       lnum = 2,                                -- line 3 (0-indexed)
--       col = 0,
--       severity = vim.diagnostic.severity.ERROR, -- ERROR = 'e'
--       source = "My Test",
--       message = "This is a test error!",
--     },
--   }
-- )
-- :verbose map
-- vim.diagnostic.reset(vim.api.nvim_create_namespace("my_test_ns"), 0)


```

## Useful utilities

```lua
-- #####################################################################
--                 Loading buffer (init.lua) automatically
-- #####################################################################
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = "*/lua/plugins/configs/*.lua",
--   callback = function(args)
--     require("plenary.reload").reload_module("plugins.configs." .. vim.fn.fnamemodify(args.file, ":t:r"), true)
--     require("plugins.configs." .. vim.fn.fnamemodify(args.file, ":t:r")).setup()
--     print("Reloaded " .. args.file)
--   end,
-- })
-- in the top of your init.lua

-- -- 1) grab plenary.reload
-- local reload_mod = require("plenary.reload").reload_module
--
-- -- 2) define a function that reloads your theme plugin and re-applies it
-- local function reload_github_theme()
--   -- clear out the old module(s)
--   reload_mod("github-theme", true)
--   -- re-run setup
--   require("github-theme").setup {
--     -- ... your custom overrides here ...
--   }
--   -- vim.cmd "colorscheme github_dark"
--   -- print("🔄 Reloaded github-theme")
-- end
--
-- -- 3) wire it up to a user command
-- vim.api.nvim_create_user_command("ReloadGithubTheme", reload_github_theme, {
--   desc = "Hot-reload my local neo-github-nvim-theme",
-- })
--
-- -- 4) optionally, auto-reload when you save init.lua
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = "init.lua",
--   callback = function()
--     dofile(vim.fn.stdpath "config" .. "/init.lua")
--     -- print("🔄 Sourced init.lua")
--   end,
-- })
--
-- -- 5) optionally, auto-reload the theme whenever you save any file under
-- --    your local theme repo
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = "/Users/gmbp/Desktop/devCode/luaHub/neo-github-nvim-theme/**/*.lua",
--   callback = reload_github_theme,
-- })
--
--

-- vim.cmd [[colorscheme github_dark
-- ]]
-- #####################################################################
--               Captilzied the colors of the constant
-- #####################################################################
-- -- TODO: must be chagned with the given colorscheme
-- -- NOTE: this ha been included in our current final work
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = { "github_dark", "github_dark_dimmed", "github_light" },
--   callback = function(event)
--     local scheme = event.match or vim.g.colors_name
--
--     -- then set up the CapsConstant group per‐scheme
--     if scheme == "github_light" then
--       -- vim.api.nvim_set_hl(0, "CapsConstant", { fg = "#d696dc", bg = "NONE" , ctermfg = "bold" })
--     else
--       vim.api.nvim_set_hl(0, "CapsConstant", { fg = "#E8E8B7", bg = "NONE" })
--     end
--
--     -- finally, re-add the regex match and stash its ID
--     vim.g.capsconst_match = vim.fn.matchadd(
--       "CapsConstant",
--       [[\<[A-Z_][A-Z0-9_]*\>]]
--     )
--   end,
-- })
--


```
