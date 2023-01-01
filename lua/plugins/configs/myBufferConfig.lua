M = {}


local colors = {
  white = "#E4FDE1",
  darker_black = "#22272e",
  black = "#282828", --  nvim bg
  black2 = "#2e2e2e",
  one_bg = "#353535",
  one_bg2 = "#3f3f3f",
  one_bg3 = "#444444",
  grey = "#464646",
  grey_fg = "#4e4e4e",
  grey_fg2 = "#505050",
  light_grey = "#565656",
  red = "#fb4934",
  baby_pink = "#cc241d",
  pink = "#ff75a0",
  --line = "#2c2f30",            -- for lines like vertsplit
  line = "#ff75a0", -- for lines like vertsplit
  --green = "#b8bb26",
  --green = '#C6EBC5',
  green = '#6cb6ff',
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
  statusline_bg = "#2c2c2c",
  lightbg = "#353535",
  lightbg2 = "#303030",
  pmenu_bg = "#83a598",
  folder_bg = "#83a598",
  beautiful_black = "#22272e",

}


--- @module "bufferline.colors"

M.setup = function()

  require("bufferline").setup {
    options = {
      numbers = "ordinal",
      right_mouse_command = "bdelete! %d",
      left_mosue_command = "buffer %d",
      -- indicator_icon = '▎',
      indicator = {
        icon ='▐',
        style = "icon",
      },
      buffer_close_icon = '',
      modified_icon = '', --'●',
      close_icon = '',
      left_trunc_marker = '',
      right_trunc_marker = '',
      max_name_length = 14,
      max_prefix_length = 13,
      tab_size = 20,
      show_tab_indicators = true,
      enforce_regular_tabs = false,
      view = "multiwindow",
      show_buffer_close_icons = true,
      separator_style = "thin",
      always_show_bufferline = true,
      --diagnostics = false, -- "or nvim_lsp"
      diagnostics = 'nvim_lsp', -- "or nvim_lsp"
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
      background = {
        fg = colors.black0,
        --bg = colors.black2,
        bg = colors.beautiful_black,
      },

      -- buffers
      buffer_selected = {
        fg = colors.white,
        --bg = colors.black,
        bg = colors.beautiful_black,
        fmt = "bold",
      },
      buffer_visible = {
        fg = colors.grey,
        --bg = colors.black2,
        bg = colors.beautiful_black,
      },

      -- FOR DIAGNOSTICS = "NVIM_LSP"
      error = {
        fg = colors.beautiful_black,
        bg = colors.beautiful_black,
      },
      error_diagnostic = {
        fg = colors.beautiful_black,
        bg = colors.beautiful_black,
      },

      -- close buttons
      close_button = {
        fg = colors.beautiful_black,
        bg = colors.beautiful_black,
      },
      close_button_visible = {
        fg = colors.beautiful_black,
        bg = colors.beautiful_black,
      },
      close_button_selected = {
        fg = colors.red,
        bg = colors.beautiful_black,
      },
      fill = {
        fg = colors.grey,
        bg = colors.beautiful_black, -- This is the color that will fill the entire tab bar
      },
      indicator_selected = {
        fg = colors.green,
        bg = colors.beautiful_black,
      },

      -- modified
      modified = {
        fg = colors.red,
        bg = colors.beautiful_black,
      },
      modified_visible = {
        fg = colors.red,
        bg = colors.beautiful_black,
      },
      modified_selected = {
        fg = colors.green,
        bg = colors.beautiful_black,
      },

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
        --fg = colors.black2,
        fg = colors.beautiful_black,
        bg = colors.beautiful_black,
      },
      -- tabs
      tab = {
        fg = colors.beautiful_black,
        bg = colors.beautiful_black,
      },
      tab_selected = {
        fg = colors.beautiful_black,
        bg = colors.beautiful_black,
      },
      tab_close = {
        fg = colors.red,
        bg = colors.beautiful_black,
      },

    }
  }

end

return M
