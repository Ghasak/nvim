local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

-- Set up the highlight groups
vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#048BA8', bg = '#2c333c' })
vim.api.nvim_set_hl(0, 'GitSignsAddLn', { fg = '#048BA8', bg = '#2c333c' })
vim.api.nvim_set_hl(0, 'GitSignsAddNr', { fg = '#048BA8', bg = '#2c333c' })

vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#ffff00', bg = '#2c333c' })
vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { fg = '#ffff00', bg = '#2c333c' })
vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { fg = '#ffff00', bg = '#2c333c' })

vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { fg = '#ff4500', bg = '#2c333c' })
vim.api.nvim_set_hl(0, 'GitSignsChangedeleteLn', { fg = '#ff4500', bg = '#2c333c' })
vim.api.nvim_set_hl(0, 'GitSignsChangedeleteNr', { fg = '#ff4500', bg = '#2c333c' })

vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#ff0000', bg = '#2c333c' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { fg = '#ff0000', bg = '#2c333c' })
vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { fg = '#ff0000', bg = '#2c333c' })

vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { fg = '#ff6347', bg = '#2c333c' })
vim.api.nvim_set_hl(0, 'GitSignsTopdeleteLn', { fg = '#ff6347', bg = '#2c333c' })
vim.api.nvim_set_hl(0, 'GitSignsTopdeleteNr', { fg = '#ff6347', bg = '#2c333c' })

-- Set up gitsigns
gitsigns.setup {
  signs = {
    -- deprecated v.10
    -- add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    -- change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    -- delete = { hl = "GitSignsDelete", text = "󰇝", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    -- topdelete = { hl = "GitSignsDelete", text = "󰇝", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    -- changedelete = { hl = "GitSignsChangedelete", text = "󰇝", numhl = "GitSignsChangedeleteNr", linehl = "GitSignsChangedeleteLn" },
    add = {text = "▎"},
    change = { text = "▎"},
    delete = { text = "󰇝"},
    topdelete = { text = "󰇝"},
    changedelete = {  text = "󰇝"},
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
}

