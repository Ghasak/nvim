local M = {}

M.config = function()
  local status_ok, fine_cmdline = pcall(require, "fine-cmdline")
  if not status_ok then
    return
  end

  fine_cmdline.setup {
    cmdline = {
      enable_keymaps = true,
      smart_history = true,
      prompt = ": ",
    },
    popup = {
      position = {
        row = "50%",
        col = "50%",
      },
      size = {
        width = "50%",
      },
      border = {
        style = "rounded",
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
      },
    },
    hooks = {
      before_mount = function(input)
        -- code
      end,
      after_mount = function(input)
        -- code
      end,
      set_keymaps = function(imap, feedkeys)
        local fn = require("fine-cmdline").fn
        -- code
        imap("<M-k>", fn.up_search_history)
        imap("<M-j>", fn.down_search_history)
        imap("<Up>", fn.up_history)
        imap("<Down>", fn.down_history)
        -- Restore default keybindings...
        -- Except for `<Tab>`, that's what everyone uses to autocomplete
        imap("<Esc>", fn.close)
        imap("<C-c>", fn.close)

        imap("<Up>", fn.up_search_history)
        imap("<Down>", fn.down_search_history)
      end,
    },
  }
end

return M
