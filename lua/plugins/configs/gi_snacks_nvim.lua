-- ~/.config/nvim/lua/config/snacks/config.lua
local M = {}

M.opts = {
  bigfile = { enabled = true },
  dashboard = { enabled = false },

  -- Explorer UI/layout stays here
  explorer = {
    enabled = true,
    replace_netrw = false,
    layout = {
      layout = { preset = "sidebar", width = vim.g.shared_sidebar_width or 30 },
      preview = false,
    },
  },

  picker = {
    enabled = true,
    sources = {
      explorer = {
        layout = {
          layout = { preset = "sidebar", width = vim.g.shared_sidebar_width or 30 },
          preview = false,
        },

        -- ✅ Define actions that receive (_, item). Use item.file for the path.
        actions = {
          copy_filename = {
            action = function(_, item)
              if not (item and item.file) then
                Snacks.notify.warn("No file/dir under cursor")
                return
              end
              local name = vim.fn.fnamemodify(item.file, ":t") -- filename.ext (also works for dir name)
              vim.fn.setreg("+", name)
              Snacks.notify.info("Yanked filename → “" .. name .. "” to clipboard (+)")
            end,
          },
          copy_abs_path = {
            action = function(_, item)
              if not (item and item.file) then
                Snacks.notify.warn("No file/dir under cursor")
                return
              end
              local abs = vim.fn.fnamemodify(item.file, ":p") -- absolute path
              vim.fn.setreg("+", abs)
              Snacks.notify.info("Yanked absolute path → " .. abs .. " to clipboard (+)")
            end,
          },
        },

        -- ✅ Bind keys to those actions in the list window
        win = {
          list = {
            keys = {
              ["y"] = "copy_filename",
              ["Y"] = "copy_abs_path",
            },
          },
        },
      },
    },
  },

  indent = { enabled = true },
  input = { enabled = true },
  notifier = { enabled = true, timeout = 3000 },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scroll = { enabled = true },
  statuscolumn = { enabled = true },
  words = { enabled = true },
  styles = { notification = { wo = { wrap = false } } },
}

return M

