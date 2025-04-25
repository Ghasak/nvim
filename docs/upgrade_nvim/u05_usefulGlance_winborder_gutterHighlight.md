
# Useful Information



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
