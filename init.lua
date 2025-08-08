-- ╭────────────────────────────────────────────────────────────────────────────────────────────────────╮
-- │                                                                                                    │
-- │                                         .a@@@@@#########@@@@a.                                     │
-- │                                     .a@@######@@@mm@@mm######@@@a.                                 │
-- │                                .a####@@@@@@@@@@@@@@@@@@@mm@@##@@v;%%,.                             │
-- │                             .a###v@@@@@@@@vvvvvvVVvvvvvv@@@@#@v;%%%vv%%,                           │
-- │                          .a##vv@@@@@@@@vv%%%%;S,  .S;%%vv@@#v;%%'/%vvvv%;                          │
-- │                        .a##@v@@@@@vv%%vvvvvv%%;SssS;%%vvvv@v;%%./%vvvvvv%;                         │
-- │                      ,a##vv@@@vv%%%@@@@@@@@@@@@mmmmmmmmmvv;%%%%vvvvvvvvv%;                         │
-- │                      .a##@@@@@@@@@@@@@@@@@@@@@@@mmmmmvv;%%%%%vvvvvvvvvvv%;                         │
-- │                     ###vv@@@v##@v@@@@@@@@@@mmv;%;%;%;%;%;%;%;%;%;%;%,%vv%'                         │
-- │                    a#vv@@@@v##v@@@@@@@@###@@@@@v%v%v%v%v%v%v%       ;%%;'                          │
-- │                   ',a@@@@@@@v@@@@@@@@v###v@@@nvnvnvnvnvnvnvnv'      .%;'                           │
-- │                   a###@@@@@@@###v@@@v##v@@@mnmnmnmnmnmnmnmnmn.      ;'                             │
-- │                  ,###vv@@@@v##v@@@@@@v@@@@v##v@@@@@v###v@@@##@.                                    │
-- │                  ###vv@@@@@@v@@###v@@@@@@@@v@@@@@@v##v@@@v###v@@.                                  │
-- │                 a@vv@@@@@@@@@v##v@@@@@@@@@@@@@@;@@@v@@@@v##v@@@@@@a                                │
-- │                ',@@@@@@;@@@@@@v@@@@@@@@@@@@@@@;%@@@@@@@@@v@@@@;@@@@@a                              │
-- │               .@@@@@@;%@@;@@@@@@@;;@@@@@;@@@@;%%;@@@@@;@@@@;@@@;@@@@@@.                            │
-- │              ,a@@@;vv;@%;@@@@@;%%v%;@@@;@@@;%vv%%;@@@;%;@@;%@@@;%;@@;%@@a                          │
-- │             .@@@@@@;%@@;@@@@@@@;;@@@@@;@@@@;%%;@@@@@;@@@@;@@@;@@@@@@ear@ea                         │
-- │            ,a@@@;vv;@%;@@@@@;%%v%;@@@;@@@;%vv%%;@@@;%;@@;%@@@;%;@@;%@@a@@ea                        │
-- │            a@;vv;%%%;@@;%%;vvv;%%@@;%;@;%vvv;%;@@;%%%;@;%;@;%%%@@;%%;.`@@@ea                       │
-- │           ;@;%;vvv;%;@;%%;vv;%%%%v;%%%;%vv;%%v;@@;%vvv;%;%;%;%%%;%%%%;.%,@@@ea                     │
-- │           %%%;vv;%;vv;%%%v;%%%%;vvv;%%%v;%%%;vvv;%;vv;%%%%%;vv;%%%;vvv;.%%%,$l;a                   │
-- │                                                                                                    │
-- │          You are about to experience a potent dosage of Neovim Watch your steps.                   │
-- │                                    Version 0.11.3                                                  │
-- │                  Copyright (c) 2025 Author. All Rights Reserved.                                   │
-- │                                                                                                    │
-- │                              \ | __|  _ \\ \   /_ _|  \  |                                         │
-- │                             .  | _|  (   |\ \ /   |  |\/ |                                         │
-- │                            _|\_|___|\___/  \_/  ___|_|  _|                                         │
-- │                    ╔══════════════════════════════════════════╗                                    │
-- │                    ║           ⎋  HERE BE VIMPIRES ⎋          ║                                    │
-- │                    ╚══════════════════════════════════════════╝                                    │
-- ╰────────────────────────────────────────────────────────────────────────────────────────────────────╯

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

-- Loading the neovi
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

-- set the indent guide to a soft green, no bg
vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = "#eef6fb", bg = "NONE" })

-- temp error with nvim.progress and nvim.lspsaga [to be updated ]
vim.deprecate = function() end





