local M = {}

M.keys = require("core.keymappings").yazi_keys

---@type YaziConfig | {}
M.opts = {
  -- if you want to open yazi instead of netrw, see below for more info
  open_for_directories = false,
  keymaps = {
    show_help = "<f1>",
  },

  -- the floating window scaling factor. 1 means 100%, 0.9 means 90%, etc.
  floating_window_scaling_factor = 0.8,

  -- the transparency of the yazi floating window (0-100). See :h winblend
  yazi_floating_window_winblend = 0,
 -- the type of border to use for the floating window. Can be many values,
    -- including 'none', 'rounded', 'single', 'double', 'shadow', etc. For
    -- more information, see :h nvim_open_win
    yazi_floating_window_border = "double",
}

-- 👇 if you use `open_for_directories=true`, this is recommended
M.init = function()
  -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
  -- vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
end

return M
