local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- Added for loading the nvim-tree, it seems the above is not working at the moment, to be maintained later.
vim.cmd [[highlight NvimTreeFolderIcon guifg = gray]]
vim.cmd [[highlight NvimTreeIndentMarker guifg = gray]]
-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1
vim.o.termguicolors = true
vim.g.nvim_tree_indent_marker = 1

nvim_tree.setup {
  hijack_directories = { enable = false },
  filters = { custom = { ".git" }, exclude = { ".gitignore" } },
  update_cwd = true,
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    highlight_opened_files = "none",
    root_folder_modifier = ":t",
    indent_markers = {
      enable = true,
      icons = { corner = "└ ", edge = "│ ", none = "  " },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = "  ",
      symlink_arrow = " ➛ ",
      show = { file = true, folder = true, folder_arrow = true, git = true },
      glyphs = {

        default = "󰈙",
        symlink = "",
        -- bookmark = "",
        bookmark = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },

        git = {
          -- unstaged = "",
          -- staged = "S",
          unmerged = "",
          renamed = "➜",
          -- untracked = "U",
          deleted = "",
          ignored = "◌",
          staged = "󰝚",
          unstaged = "󰝛",
          untracked = "",
        },
      },
    },
  },

  diagnostics = {
    enable = true,
    icons = {
      -- hint = "",
      -- info = "",
      -- warning = "",
      -- error = "",
      error = "",
      info = "",
      warning = " ",
      hint = "",
    },
  },
  update_focused_file = { enable = true, update_cwd = true, ignore_list = {} },
  git = { enable = true, ignore = true, timeout = 500 },
}
