local M = {}
-- Only return setup options (no plugin declaration here)

M.config = function()
  require("oil").setup {
    columns = { "icon" },
    keymaps = {
      -- ["<C-h>"] = false,
      ["<M-h>"] = "actions.select_split",
    },
    view_options = {
      show_hidden = true,
    },

    win_options = {
      winbar = "%!v:lua.get_oil_winbar()",
    },
  }

  -- Open parent directory in current window
  -- vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

  -- Open parent directory in floating window
  vim.keymap.set("n", "<space>-", require("oil").toggle_float)
  vim.api.nvim_set_keymap("n", "<Leader>fj", "<CMD>Oil<CR>", { noremap = true, silent = false })
  -- Open parent directory in floating window
  vim.keymap.set("n", "<space>-", require("oil").toggle_float)
end

return M
