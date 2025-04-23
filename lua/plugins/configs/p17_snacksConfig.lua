-- ~/.config/nvim/lua/config/snacks/config.lua

local M = {}

M.opts = {
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  explorer = {
    enabled = true,
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
      wo = { wrap = true },
    },
  },
}

return M
