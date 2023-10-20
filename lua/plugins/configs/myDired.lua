local M = {}
M.config = function()
  require("dired").setup {
    --path_separator = "/",
    show_banner = false,
    show_hidden = true,
    show_dot_dirs = true,
    show_colors = true,
  }

  -- ---------------------------------------------------
  --                For current dired
  -- ---------------------------------------------------
  vim.api.nvim_set_keymap("n", "<Leader>fj", ":Dired <CR>", { noremap = true, silent = false })
  local dired_group = vim.api.nvim_create_augroup("dired", { clear = true })

  -- Create a mapping function based on the buffer name
  local function dired_key_mapping()
    local map = vim.api.nvim_buf_set_keymap
    local opt = { silent = true, noremap = true }
    -- Check if the filetype is `dired`
    if vim.bo.filetype == "dired" then
      -- Set buffer-local mappings based on your requirements
      map(0, "n", "<C-h>", "<Plug>(dired_back)", opt)
      map(0, "n", "<C-l>", "<Plug>(dired_enter)", opt)
    end
  end
  -- This is a modern lua api for autocmd  that will check always for the FileType
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "dired",
    callback = function()
      dired_key_mapping()
    end,
    group = dired_group,
  })
  -- These are not working as they will stick to any other buffer.
  -- -- Move to the parent directory
  -- vim.api.nvim_set_keymap("n", "h", "", {
  --   noremap = true,
  --   callback = function()
  --     -- Getting file name from file-path then remove the extension
  --     if vim.bo.filetype == "dired" then
  --       ---@diagnostic disable-next-line: undefined-field
  --       vim.api.nvim_exec("DiredGoBack", false)
  --     end
  --   end,
  --   desc = "Prints my current test ... ",
  -- })
  --
  -- -- Move to child directory
  -- vim.api.nvim_set_keymap("n", "l", "", {
  --   noremap = true,
  --   callback = function()
  --     -- Getting file name from file-path then remove the extension
  --     if vim.bo.filetype == "dired" then
  --       ---@diagnostic disable-next-line: undefined-field
  --       vim.api.nvim_exec(":DiredEnter<cr>", false)
  --     end
  --   end,
  --   desc = "Prints my current test ... ",
  -- })
  -- ---------------------------------------------------
end
return M
