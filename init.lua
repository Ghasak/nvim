--   ----------------------------------------------------------------------------------------------------------------------------

--                                                                                                                             --
--                       ███╗  ██╗███████╗ █████╗ ██╗   ██╗██╗███╗   ███╗  ██╗███╗  ██╗██╗████████╗                            --
--                       ████╗ ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║  ██║████╗ ██║██║╚══██╔══╝                            --
--                       ██╔██╗██║█████╗  ██║  ██║╚██╗ ██╔╝██║██╔████╔██║  ██║██╔██╗██║██║   ██║                               --
--                       ██║╚████║██╔══╝  ██║  ██║ ╚████╔╝ ██║██║╚██╔╝██║  ██║██║╚████║██║   ██║                               --
--                       ██║ ╚███║███████╗╚█████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║  ██║██║  ███║██║   ██║   ██╗                         --
--                       ╚═╝  ╚══╝╚══════╝ ╚════╝    ╚═╝   ╚═╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚══╝╚═╝   ╚═╝   ╚═╝                         --
--                               █▀▄▀█ █▀█ █▀▄ █▀▀ █▀█ █▄ █   █▄ █ █▀▀ █▀█ █ █ █ █▀▄▀█                                         --
--                               █ ▀ █ █▄█ █▄▀ ██▄ █▀▄ █ ▀█   █ ▀█ ██▄ █▄█ ▀▄▀ █ █ ▀ █                                         --
--                                                                                                                             --
--                                                 .a@@@@@#########@@@@a.                                                      --
--                                             .a@@######@@@mm@@mm######@@@a.                                                  --
--                                        .a####@@@@@@@@@@@@@@@@@@@mm@@##@@v;%%,.                                              --
--                                     .a###v@@@@@@@@vvvvvvvvvvvvvv@@@@#@v;%%%vv%%,                                            --
--                                  .a##vv@@@@@@@@vv%%%%;S,  .S;%%vv@@#v;%%'/%vvvv%;                                           --
--                                .a##@v@@@@@vv%%vvvvvv%%;SssS;%%vvvv@v;%%./%vvvvvv%;                                          --
--                              ,a##vv@@@vv%%%@@@@@@@@@@@@mmmmmmmmmvv;%%%%vvvvvvvvv%;                                          --
--                              .a##@@@@@@@@@@@@@@@@@@@@@@@mmmmmvv;%%%%%vvvvvvvvvvv%;                                          --
--                             ###vv@@@v##@v@@@@@@@@@@mmv;%;%;%;%;%;%;%;%;%;%;%,%vv%'                                          --
--                            a#vv@@@@v##v@@@@@@@@###@@@@@v%v%v%v%v%v%v%       ;%%;'                                           --
--                           ',a@@@@@@@v@@@@@@@@v###v@@@nvnvnvnvnvnvnvnv'      .%;'                                            --
--                           a###@@@@@@@###v@@@v##v@@@mnmnmnmnmnmnmnmnmn.      ;'                                              --
--                          ,###vv@@@@v##v@@@@@@v@@@@v##v@@@@@v###v@@@##@.                                                     --
--                          ###vv@@@@@@v@@###v@@@@@@@@v@@@@@@v##v@@@v###v@@.                                                   --
--                         a@vv@@@@@@@@@v##v@@@@@@@@@@@@@@;@@@v@@@@v##v@@@@@@a                                                 --
--                        ',@@@@@@;@@@@@@v@@@@@@@@@@@@@@@;%@@@@@@@@@v@@@@;@@@@@a                                               --
--                       .@@@@@@;%@@;@@@@@@@;;@@@@@;@@@@;%%;@@@@@;@@@@;@@@;@@@@@@.                                             --
--                      ,a@@@;vv;@%;@@@@@;%%v%;@@@;@@@;%vv%%;@@@;%;@@;%@@@;%;@@;%@@a                                           --
--                        .@@@@@@;%@@;@@@@@@@;;@@@@@;@@@@;%%;@@@@@;@@@@;@@@;@@@@@@ear                                          --
--                      ,a@@@;vv;@%;@@@@@;%%v%;@@@;@@@;%vv%%;@@@;%;@@;%@@@;%;@@;%@@a                                           --
--                       a@;vv;%%%;@@;%%;vvv;%%@@;%;@;%vvv;%;@@;%%%;@;%;@;%%%@@;%%;.`                                          --
--                      ;@;%;vvv;%;@;%%;vv;%%%%v;%%%;%vv;%%v;@@;%vvv;%;%;%;%%%;%%%%;.%,                                        --
--                      %%%;vv;%;vv;%%%v;%%%%;vvv;%%%v;%%%;vvv;%;vv;%%%%%;vv;%%%;vvv;.%%%,                                     --
--                                                                                                                             --
--                     You are about to experience a potent dosage of Neovim Watch your steps.                                 --
--                                                Version 0.9                                                                  --
--                              ╔══════════════════════════════════════════╗                                                   --
--                              ║           ⎋  HERE BE VIMPIRES ⎋          ║                                                   --
--                              ╚══════════════════════════════════════════╝                                                   --
-- ------------------------------------------------------------------------------------------------------------------------------

local load_module = function(mod_name)
  local ok, err = pcall(require, mod_name)
  if not ok then
    local msg = "failed loading: " .. mod_name .. "\n " .. err
    vim.notify(msg, vim.log.levels.ERROR)
  end
end

local init_modules = {
  "plugins",
  "core",
  "settings", -- 'scripts', 'dev'
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
  require("transparent").clear_prefix "BufferLine"
  require('transparent').clear_prefix('NeoTree')
  --require('transparent').clear_prefix('lualine')
end


