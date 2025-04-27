local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then return end

-- helper that actually applies the highlights
local function apply_github_gitsigns()
  local name = vim.g.colors_name
  local cfg

  if name == "github_dark" or name == "onedark" then
    cfg = {
      bg = "#2c333c",
      Add = "#048BA8",
      Change = "#ffff00",
      ChangeDelete = "#ff4500",
      Delete = "#ff0000",
      Topdelete = "#ff6347",
    }
  elseif name == "github_light" then
    cfg = {
      bg = "#f0f0f0",
      Add = "#026670",
      Change = "#daaa00",
      ChangeDelete = "#cc5500",
      Delete = "#cc0000",
      Topdelete = "#c1440e",
    }
  else
    return
  end

  -- loop over each kind + the Ln/Nr suffixes
  for kind, fg in pairs(cfg) do
    for _, suf in ipairs { "", "Ln", "Nr" } do
      vim.api.nvim_set_hl(0, "GitSigns" .. kind .. suf, { fg = fg, bg = cfg.bg })
    end
  end
end

-- apply once immediately (so your initial colorscheme gets it)
apply_github_gitsigns()

-- then re-apply whenever you switch themes
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = { "github_dark", "github_light" },
  callback = apply_github_gitsigns,
})
--
-- -- Set up the highlight groups
-- vim.api.nvim_set_hl(0, 'GitSignsAdd', { fg = '#048BA8', bg = '#2c333c' })
-- vim.api.nvim_set_hl(0, 'GitSignsAddLn', { fg = '#048BA8', bg = '#2c333c' })
-- vim.api.nvim_set_hl(0, 'GitSignsAddNr', { fg = '#048BA8', bg = '#2c333c' })
--
-- vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#ffff00', bg = '#2c333c' })
-- vim.api.nvim_set_hl(0, 'GitSignsChangeLn', { fg = '#ffff00', bg = '#2c333c' })
-- vim.api.nvim_set_hl(0, 'GitSignsChangeNr', { fg = '#ffff00', bg = '#2c333c' })
--
-- vim.api.nvim_set_hl(0, 'GitSignsChangedelete', { fg = '#ff4500', bg = '#2c333c' })
-- vim.api.nvim_set_hl(0, 'GitSignsChangedeleteLn', { fg = '#ff4500', bg = '#2c333c' })
-- vim.api.nvim_set_hl(0, 'GitSignsChangedeleteNr', { fg = '#ff4500', bg = '#2c333c' })
--
-- vim.api.nvim_set_hl(0, 'GitSignsDelete', { fg = '#ff0000', bg = '#2c333c' })
-- vim.api.nvim_set_hl(0, 'GitSignsDeleteLn', { fg = '#ff0000', bg = '#2c333c' })
-- vim.api.nvim_set_hl(0, 'GitSignsDeleteNr', { fg = '#ff0000', bg = '#2c333c' })
--
-- vim.api.nvim_set_hl(0, 'GitSignsTopdelete', { fg = '#ff6347', bg = '#2c333c' })
-- vim.api.nvim_set_hl(0, 'GitSignsTopdeleteLn', { fg = '#ff6347', bg = '#2c333c' })
-- vim.api.nvim_set_hl(0, 'GitSignsTopdeleteNr', { fg = '#ff6347', bg = '#2c333c' })
--
-- Set up gitsigns
gitsigns.setup {
  signs = {
    -- deprecated v.10
    -- add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    -- change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    -- delete = { hl = "GitSignsDelete", text = "󰇝", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    -- topdelete = { hl = "GitSignsDelete", text = "󰇝", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    -- changedelete = { hl = "GitSignsChangedelete", text = "󰇝", numhl = "GitSignsChangedeleteNr", linehl = "GitSignsChangedeleteLn" },
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "󰇝" },
    topdelete = { text = "󰇝" },
    changedelete = { text = "󰇝" },
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
  -- current_line_blame_formatter_opts = {
  --   relative_time = false,
  -- },
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
  -- yadm = {
  --   enable = false,
  -- },
}
