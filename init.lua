-- ############################################################################################################
-- #                                                                                                          #
-- #                                                                                                          #
-- #                                                .a@@@@@#########@@@@a.                                    #
-- #                                            .a@@######@@@mm@@mm######@@@a.                                #
-- #                                       .a####@@@@@@@@@@@@@@@@@@@mm@@##@@v;%%,.                            #
-- #                                    .a###v@@@@@@@@vvvvvvvvvvvvvv@@@@#@v;%%%vv%%,                          #
-- #                                 .a##vv@@@@@@@@vv%%%%;S,  .S;%%vv@@#v;%%'/%vvvv%;                         #
-- #                               .a##@v@@@@@vv%%vvvvvv%%;SssS;%%vvvv@v;%%./%vvvvvv%;                        #
-- #                             ,a##vv@@@vv%%%@@@@@@@@@@@@mmmmmmmmmvv;%%%%vvvvvvvvv%;                        #
-- #                             .a##@@@@@@@@@@@@@@@@@@@@@@@mmmmmvv;%%%%%vvvvvvvvvvv%;                        #
-- #                            ###vv@@@v##@v@@@@@@@@@@mmv;%;%;%;%;%;%;%;%;%;%;%,%vv%'                        #
-- #                           a#vv@@@@v##v@@@@@@@@###@@@@@v%v%v%v%v%v%v%       ;%%;'                         #
-- #                          ',a@@@@@@@v@@@@@@@@v###v@@@nvnvnvnvnvnvnvnv'      .%;'                          #
-- #                          a###@@@@@@@###v@@@v##v@@@mnmnmnmnmnmnmnmnmn.      ;'                            #
-- #                         ,###vv@@@@v##v@@@@@@v@@@@v##v@@@@@v###v@@@##@.                                   #
-- #                         ###vv@@@@@@v@@###v@@@@@@@@v@@@@@@v##v@@@v###v@@.                                 #
-- #                        a@vv@@@@@@@@@v##v@@@@@@@@@@@@@@;@@@v@@@@v##v@@@@@@a                               #
-- #                       ',@@@@@@;@@@@@@v@@@@@@@@@@@@@@@;%@@@@@@@@@v@@@@;@@@@@a                             #
-- #                      .@@@@@@;%@@;@@@@@@@;;@@@@@;@@@@;%%;@@@@@;@@@@;@@@;@@@@@@.                           #
-- #                     ,a@@@;vv;@%;@@@@@;%%v%;@@@;@@@;%vv%%;@@@;%;@@;%@@@;%;@@;%@@a                         #
-- #                       .@@@@@@;%@@;@@@@@@@;;@@@@@;@@@@;%%;@@@@@;@@@@;@@@;@@@@@@ear                        #
-- #                     ,a@@@;vv;@%;@@@@@;%%v%;@@@;@@@;%vv%%;@@@;%;@@;%@@@;%;@@;%@@a                         #
-- #                      a@;vv;%%%;@@;%%;vvv;%%@@;%;@;%vvv;%;@@;%%%;@;%;@;%%%@@;%%;.`                        #
-- #                     ;@;%;vvv;%;@;%%;vv;%%%%v;%%%;%vv;%%v;@@;%vvv;%;%;%;%%%;%%%%;.%,                      #
-- #                     %%%;vv;%;vv;%%%v;%%%%;vvv;%%%v;%%%;vvv;%;vv;%%%%%;vv;%%%;vvv;.%%%,                   #
-- #                                                                                                          #
-- #                    You are about to experience a potent dosage of Neovim Watch your steps.               #
-- #                                               Version 0.11.0                                             #
-- #                                                                                                          #
-- #                                  ░█▀█░█▀▀░█▀█░█░█░▀█▀░█▄█░░░▀█░░▀█░                                      #
-- #                                  ░█░█░█▀▀░█░█░▀▄▀░░█░░█░█░░░░█░░░█░                                      #
-- #                                  ░▀░▀░▀▀▀░▀▀▀░░▀░░▀▀▀░▀░▀░░░▀▀▀░▀▀▀                                      #
-- #                             ╔══════════════════════════════════════════╗                                 #
-- #                             ║           ⎋  HERE BE VIMPIRES ⎋          ║                                 #
-- #                             ╚══════════════════════════════════════════╝                                 #
-- ############################################################################################################

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

-- Loading the neovide configurations, once it neovide is lunched.
if vim.g.neovide then
  local status, neovide_config = pcall(require("units.neovideConfig").neovide_config)
  if not status then
    -- Handle any errors or exceptions
    vim.print("Error: ", vim.log.levels.WARN, neovide_config)
  end
end

-- Adding transprancency to nvim
vim.g.transparent_enabled = false

if vim.g.transparent_enabled then
  local transparent = require "transparent"

  -- Clear prefixes for specific plugins
  transparent.clear_prefix "BufferLine"
  transparent.clear_prefix "NeoTree"
  -- Uncomment the line below to clear prefix for lualine if needed
  -- transparent.clear_prefix("lualine")
end

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

