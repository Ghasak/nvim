-- "===========================================================================
-- "
-- "        ███╗░░██╗███████╗░█████╗░██╗░░░██╗██╗██████╗░███████╗
-- "        ████╗░██║██╔════╝██╔══██╗██║░░░██║██║██╔══██╗██╔════╝
-- "        ██╔██╗██║█████╗░░██║░░██║╚██╗░██╔╝██║██║░░██║█████╗░░
-- "        ██║╚████║██╔══╝░░██║░░██║░╚████╔╝░██║██║░░██║██╔══╝░░
-- "        ██║░╚███║███████╗╚█████╔╝░░╚██╔╝░░██║██████╔╝███████╗
-- "        ╚═╝░░╚══╝╚══════╝░╚═══╝░░░░╚═╝░░░╚═╝╚═════╝░╚══════╝
-- "
-- "===========================================================================
-- " Source:
-- "   - https://github.com/Kethku/neovide/wiki/Configuration
-- set guifont=VictorMono\ Nerd\ Font\:h15
-- let g:neovide_refresh_rate=75
-- let g:neovide_transparency=0.8
-- let g:neovide_cursor_animation_length=0.10
-- let g:neovide_cursor_trail_length=0.3
-- let g:neovide_cursor_antialiasing=v:true
-- " cursor Particle:  torpedo, Pixiedust, sonicboom, Ripple
-- let g:neovide_cursor_vfx_mode = "torpedo"
-- "
local M = {}

M.neovide_config = function()

    --vim.cmd([[set guifont=VictorMono_NF:h14]]) -- Main
    -- vim.cmd([[set guifont=SFMono_Nerd_Font:h14]])
    -- vim.opt.guifont = { "VictorMono NF", ":h14" }
    -- vim.opt.guifont                            = { "VictorMono NF", ":h14", ":bold" }
    -- vim.opt.guifont                            = { "Hack_Nerd_Font", ":h14" }
    -- vim.opt.guifont = {"RobotoMono_NF", ":h14", ":bold"}
    -- vim.opt.guifont                            = { "SFMono Nerd Font", ":h14",":w13", }
    -- vim.opt.guifont                            = { "SFMono Nerd Font", ":h14:w3.4" }
    vim.cmd([[set guifont=VictorMono_NF:h14:w16]])
    -- vim.cmd([[set guifont=SFMono_Nerd_Font:h14/-1/5/-10/0/0/0/1/0]])
    vim.g.neovide_scale_factor = 1.0
    vim.g.neovide_refresh_rate = 60
    vim.g.neovide_cursor_vfx_mode = "torpedo"
    vim.g.neovide_no_idle = true
    vim.g.neovide_cursor_animation_length = 0.03
    vim.g.neovide_cursor_trail_length = 0.05
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_cursor_vfx_opacity = 80.0
    vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
    vim.g.neovide_cursor_vfx_particle_speed = 20.0
    vim.g.neovide_cursor_vfx_particle_density = 5.0
    vim.g.neovide_transparency = 0.0
    vim.g.transparency = 1.0
    vim.g.neovide_background_color = "#343a43"
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0
    vim.g.neovide_cursor_trail_size = 0.94
end

return M
