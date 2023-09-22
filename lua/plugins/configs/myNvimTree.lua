local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then return end

-- Added for loading the nvim-tree, it seems the above is not working at the moment, to be maintained later.
nvim_tree.setup({
    hijack_directories = {enable = false},
    -- update_to_buf_dir = {
    --   enable = false,
    -- },
    -- disable_netrw = true,
    -- hijack_netrw = true,
    -- open_on_setup = false,
    -- ignore_ft_on_setup = {
    --   "startify",
    --   "dashboard",
    --   "alpha",
    -- },
    filters = {custom = {".git"}, exclude = {".gitignore"}},
    -- auto_close = true,
    -- open_on_tab = false,
    -- hijack_cursor = false,
    update_cwd = true,
    -- update_to_buf_dir = {
    --   enable = true,
    --   auto_open = true,
    -- },
    -- --   error
    -- --   info
    -- --   question
    -- --   warning
    -- --   lightbulb
    renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = false,
        highlight_opened_files = "none",
        root_folder_modifier = ":t",
        indent_markers = {
            enable = true,
            icons = {corner = "└ ", edge = "│ ", none = "  "}
        },
        icons = {
            webdev_colors = true,
            git_placement = "before",
            padding = "  ",
            symlink_arrow = " ➛ ",
            show = {file = true, folder = true, folder_arrow = true, git = true},
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
                    symlink_open = ""
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
                    untracked = ""

                }
            }
        }
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
            hint = ""
        }
    },
    update_focused_file = {enable = true, update_cwd = true, ignore_list = {}},
    -- system_open = {
    --   cmd = nil,
    --   args = {},
    -- },
    -- filters = {
    --   dotfiles = false,
    --   custom = {},
    -- },
    git = {enable = true, ignore = true, timeout = 500}
    -- view = {
    --     width = 30,
    --     -- height = 30,
    --     hide_root_folder = false,
    --     side = "left",
    --     -- auto_resize = true,
    --     mappings = {
    --         custom_only = false,
    --         list = {
    --             {key = {"l", "<CR>", "o"}, cb = tree_cb "edit"},
    --             {key = "h", cb = tree_cb "close_node"},
    --             {key = "v", cb = tree_cb "vsplit"}
    --         }
    --     },
    --     number = false,
    --     relativenumber = false
    -- }
})

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then return end
local cmd = vim.cmd

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- Check more options using (:help nvim-tree-setup)

-- " a list of groups can be found at `:help nvim_tree_highlight`
cmd([[highlight NvimTreeFolderIcon guifg = gray]])
cmd([[highlight NvimTreeIndentMarker guifg = gray]])
--
vim.o.termguicolors = true
vim.g.nvim_tree_indent_marker = 1

-- Origianl config:
-- local icons = require("user.icons")
-- local icons = {
--   kind = {
-- 	default = "",
-- 	symlink = "",
-- 	git = {
-- 		deleted = "",
-- 		ignored = "◌",
-- 		renamed = "➜",
-- 		unmerged = " ",
-- 		staged = "ﱘ ",
-- 		unstaged = "ﱙ ",
-- 		untracked = " ",
-- 	},
-- }
-- }

-- local icons = require("plugins.configs.icons")
local tree_cb = nvim_tree_config.nvim_tree_callback

