-- --------------------------------------------------------------
--                                                             --
--           ░█▀█░█▀▀░█▀█░█░█░▀█▀░█▄█░░░▀█░░▀█░                --
--           ░█░█░█▀▀░█░█░▀▄▀░░█░░█░█░░░░█░░░█░                --
--           ░▀░▀░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░▀░░░▀▀▀░▀▀▀                --
--      ╔══════════════════════════════════════════╗         ----
--      ║           ⎋  HERE BE VIMPIRES ⎋          ║         ----
--      ╚══════════════════════════════════════════╝         ----
-- --------------------------------------------------------------

local load_module = function(mod_name)
  local ok, err = pcall(require, mod_name)
  if not ok then
    local msg = "failed loading: " .. mod_name .. "\n " .. err
    vim.notify(msg, vim.log.levels.ERROR)
  end
end

local init_modules = {
  "services",
  "patches",
  "plugins",
  "core",
  "settings",
  -- 'scripts',
  -- 'dev'
}

for _, module in ipairs(init_modules) do
  load_module(module)
end

-- for many years this could be the same for our
--

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
-- lua/after/plugin/diag_virtual_lines.lua  (or wherever you like)
--

-- local function sync_undotree_width_to_snacks(fraction)
--   local total_columns = vim.o.columns
--   local width = math.floor(total_columns * (fraction or 0.2))
--   vim.g.undotree_SplitWidth = width
-- end
-- sync_undotree_width_to_snacks(0.2)
--
