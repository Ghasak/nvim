local M = {}

M.setup = function()
  -- local c = require "onedark.colors"
  require("toggleterm").setup {
    -- size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == "horizontal" then
        return 25
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
    open_mapping = [[<c-\>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = "3", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = "float", --'float',            --'vertical' | 'horizontal' | 'window' | 'float',
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- Highlight wihchi map to a highlight group name and a talbe of it's values
    -- NOTE: this is only a subset of alvues , any group palced here will be set for the terminal
    highlights = {
      FloatBorder = {
        -- guifg = "#B2C9AB",
        -- guibg = "#B2C9AB",
      },

      NormalFloat = {
        --guibg = "#181a1f",
        link = "Normal",
      },

      -- Normal = {
      --   guibg = "#2d333b",
      -- },
      -- Normal = {
      --   guibg = c.bg0
      -- },
    },
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      -- The border key is *almost* the same as 'nvim_open_win'
      -- see :h nvim_open_win for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border = "double", --'double', --'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
      --width = 150,
      --height = 30,
      winblend = 10,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
  }
end

return M

