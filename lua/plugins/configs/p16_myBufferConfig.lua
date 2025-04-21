M = {}

local colors = {
  white = "#ffffff",
  darker_black = "#2d333b",
  black = "#2d333b", --  nvim bg
  black2 = "#2d333b",
  one_bg = "#2d333b",
  one_bg2 = "#2d333b",
  one_bg3 = "#2d333b",
  grey = "#adbac7",
  grey_e = "#adbac7",
  grey_fg = "#adbac7",
  grey_fg2 = "#adbac7",
  light_grey = "#adbac7",
  red = "#fb4934",
  baby_pink = "#cc241d",
  pink = "#ff75a0",
  -- line = "#2c2f30",            -- for lines like vertsplit
  line = "#ff75a0", -- for lines like vertsplit
  -- green = "#b8bb26",
  green = "#C6EBC5",
  blue_e = "#6cb6ff",
  vibrant_green = "#a9b665",
  nord_blue = "#83a598",
  blue = "#458588",
  yellow = "#d79921",
  sun = "#fabd2f",
  purple = "#b4bbc8",
  dark_purple = "#d3869b",
  teal = "#749689",
  orange = "#e78a4e",
  cyan = "#82b3a8",
  statusline_bg = "#2d333b",
  lightbg = "#2d333b",
  lightbg2 = "#2d333b",
  pmenu_bg = "#83a598",
  folder_bg = "#83a598",
  beautiful_black = "#2d333b",
}

--- @module "bufferline.colors"

M.config = function()
  require("bufferline").setup {
    options = {
      numbers = "ordinal",
      right_mouse_command = "bdelete! %d",
      left_mosue_command = "buffer %d",
      indicator = {
        icon = "█ ",
        "▎ ", -- this should be omitted if indicator style is not 'icon'
        style = "icon",
      },

      buffer_close_icon = "",
      modified_icon = " ", -- '●',
      close_icon = "",
      left_trunc_marker = "",
      right_trunc_marker = "",
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,
      show_tab_indicators = true,
      enforce_regular_tabs = false,
      view = "multiwindow",
      show_buffer_close_icons = true,
      separator_style = "thin",
      always_show_bufferline = true,
      -- diagnostics = false, -- "or nvim_lsp"
      diagnostics = "nvim_lsp", -- "or nvim_lsp"
      custom_filter = function(buf_number)
        -- Func to filter out our managed/persistent split terms
        local present_type, type = pcall(function()
          return vim.api.nvim_buf_get_var(buf_number, "term_type")
        end)

        if present_type then
          if type == "vert" then
            return false
          elseif type == "hori" then
            return false
          else
            return true
          end
        else
          return true
        end
      end,
    },

    highlights = {
      background = { fg = colors.grey_e, bg = colors.beautiful_black },

      -- buffers
      buffer_selected = {
        fg = colors.white,
        bg = colors.beautiful_black,
        fmt = "bold",
      },
      buffer_visible = {
        fg = colors.white,
        bg = colors.beautiful_black,
      },
      -- close buttons
      close_button = {
        fg = colors.red,
        bg = colors.beautiful_black,
      },
      close_button_visible = {
        fg = colors.red,
        bg = colors.beautiful_black,
      },
      close_button_selected = {
        fg = colors.red,
        bg = colors.beautiful_black,
      },
      fill = {
        fg = colors.beautiful_black,
        bg = colors.beautiful_black, -- This is the color that will fill the entire tab bar
      },
      indicator_selected = {
        fg = colors.blue_e,
        bg = colors.beautiful_black,
      },

      -- modified
      modified = { fg = colors.red, bg = colors.beautiful_black },
      modified_visible = { fg = colors.red, bg = colors.beautiful_black },
      modified_selected = { fg = colors.red, bg = colors.beautiful_black },

      -- separators
      separator = {
        fg = colors.beautiful_black,
        bg = colors.beautiful_black,
      },
      separator_visible = {
        fg = colors.beautiful_black,
        bg = colors.beautiful_black,
      },
      separator_selected = {
        -- fg = colors.black2,
        fg = colors.beautiful_black,
        bg = colors.beautiful_black,
      },
      -- tabs
      tab = { fg = colors.beautiful_black, bg = colors.beautiful_black },
      tab_selected = {
        fg = colors.beautiful_black,
        bg = colors.beautiful_black,
      },
      tab_close = { fg = colors.red, bg = colors.beautiful_black },
      -- Style for the numbers in the tab
      numbers = {
        fg = colors.grey,
        bg = colors.beautiful_black,
        bold = true,
      },

      numbers_visible = { fg = colors.grey, bg = colors.beautiful_black },
      numbers_selected = {
        fg = colors.blue_e,
        bg = colors.beautiful_black,
        bold = true,
        -- italic = true,
      },
      pick_selected = {
        fg = colors.red,
        -- bg = '<colour-value-here>',
        bold = true,
        italic = true,
      },
      pick_visible = {
        fg = colors.red,
        -- bg = '<colour-value-here>',
        bold = true,
        italic = true,
      },
      pick = {
        fg = colors.red,
        -- bg = '<colour-value-here>',
        bold = true,
        italic = true,
      },
      -- pick_visible = {
      --   fg = '<colour-value-here>',
      --   bg = '<colour-value-here>',
      --   bold = true,
      --   italic = true,
      -- },
      -- pick = {
      --   fg = '<colour-value-here>',
      --   bg = '<colour-value-here>',
      --   bold = true,
      --   italic = true,
      -- },
    },
  }
end

return M
