-- ~/.config/nvim/lua/config/snacks/config.lua

local M = {}

M.opts = {
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  explorer = {
    enabled = true,
    replace_netrw = false, -- Replace netrw with the snacks explorer
    layout = {
      layout = {
        preset = "sidebar",
        width = vim.g.shared_sidebar_width or 30,
      },
      preview = false,
    },
  },
  indent = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true, timeout = 3000 },
  picker = {
    enabled = true,
    sources = {
      explorer = {
        layout = {
          layout = {
            preset = "sidebar",
            width = vim.g.shared_sidebar_width or 30,
          },
          preview = false,
        },

        notifications = {
          wo = { wrap = false }, -- Enable wrap for notifications picker
        },
        show_history = {
          wo = { wrap = false }, -- Enable wrap for history picker (if this source exists)
        },
      },
    },
  },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  styles = {
    notification = {
      wo = { wrap = false },
    },
  },
}

return M
