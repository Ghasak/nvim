local M = {}

-- Mapping function for the telescope which are defined globally using (vim.g.nmap/imap/vmap/tmap)
local map = function(op, outer)
  outer = outer or { silent = true, noremap = true }
  return function(lhs, rhs, opts)
    if type(lhs) ~= "table" then
      lhs = { lhs }
    end

    opts = vim.tbl_extend("force", outer, opts or {})

    for _, v in pairs(lhs) do
      vim.keymap.set(op or "n", v, rhs, opts)
    end
  end
end

vim.g.nmap = map "n"
vim.g.imap = map "i"
vim.g.vmap = map "v"
vim.g.tmap = map "t"

-- Will be loaded
local telescope = require "telescope"
local builtin = require "telescope.builtin"
local actions = require "telescope.actions"
local themes = require "telescope.themes"

-- Allow to open help files in bigger sized window
-- read here: https://stackoverflow.com/questions/4687009/opening-help-in-a-full-window
vim.cmd [[
set helpheight=80
  ]]

M.setup = function()
  local ivy = themes.get_ivy {
    show_untracked = true,
  }
  vim.g.nmap("<leader>ff", function()
    -- if not pcall(builtin.git_files, ivy) then
    --   builtin.find_files(themes.get_ivy { no_ignore = true })
    -- end
    builtin.find_files { sorter = require("telescope.sorters").get_generic_fuzzy_sorter {} }
  end)

  vim.g.nmap("<leader>fv", function()
    telescope.extensions.frecency.frecency { sorter = require("telescope.sorters").get_generic_fuzzy_sorter {} }
  end)

  vim.g.nmap("<leader>fg", function()
    builtin.live_grep()
  end)

  vim.g.nmap("<leader>fb", function()
    builtin.buffers(themes.get_dropdown {
      previewer = false,
    })
  end)

  vim.g.nmap("<leader>fh", function()
    -- builtin.help_tags(ivy)
    --builtin.help_tags({ sorter = require('telescope.sorters').get_generic_fuzzy_sorter({}) })
    builtin.help_tags {}
  end)

  -- The functions telescope_live_grep_in_path is created.
  vim.keymap.set("n", "<leader>fD", function()
    telescope_live_grep_in_path()
  end)
  -- vim.keymap.set('n', '<leader><space>',
  --                function() telescope_files_or_git_files() end)
  vim.keymap.set("n", "<leader>fd", function()
    telescope_find_files_in_path()
  end)

  vim.g.nmap("<leader>fy", function()
    -- builtin.help_tags(ivy)
    --builtin.help_tags({ sorter = require('telescope.sorters').get_generic_fuzzy_sorter({}) })
    telescope.extensions.yank_history.yank_history {}
  end)
  vim.g.nmap("<leader>fp", function()
    telescope.extensions.project.project {}
  end)
  vim.g.nmap("<leader>U", function()
    telescope.extensions.undo.undo {}
  end)

  vim.g.nmap("<leader>th", function()
    builtin.colorscheme(ivy)
  end)

  vim.keymap.set("n", ";e", function()
    builtin.diagnostics()
  end)
end

M.config = function()
  telescope.setup {
    defaults = {
      find_command = {
        "fd",
        ".",
        "--type",
        "file",
        "--hidden",
        "--strip-cwd-prefix",
      },

      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      borderchars = {
        "═",
        "║",
        "═",
        "║",
        "╔",
        "╗",
        "╝",
        "╚",
        --"╭", "─", "╮", "│", "╯", "─", "╰", "│"
        --  "▛", "▀", "▜", "▐", "▟", "▄", "▙", "▌"
      },

      preview = {
        check_mine_type = false,
        timeout = 100,
      },
      prompt_prefix = "    ",
      selection_caret = "   ",
      selection_strategy = "reset",
      -- prompt_prefix = "> ",
      -- selection_caret = "> ",
      initial_mode = "insert",
      sorting_strategy = "ascending",
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = {},
      winblend = 0,
      color_devicons = true,
      use_less = true,
      file_ignore_patterns = { ".git/" },
      layout_config = {
        horizontal = {
          prompt_position = "bottom",
          mirror = false,
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },

      mappings = {
        i = {
          ["<c-k>"] = actions.move_selection_previous,
          ["<c-j>"] = actions.move_selection_next,
          ["<c-d>"] = actions.delete_buffer,
        },
        n = {
          ["<Esc>"] = actions.close,
        },
      },
    },
    set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
    file_previewer = require("telescope.previewers").vim_buffer_cat.new,
    grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
    qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

    dynamic_preview_title = true,
    pickers = {
      find_files = {
        --find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        -- find_command = {"rg", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case"},
        find_command = {
          "fd",
          ".",
          "--type",
          "file",
          "--hidden",
          "--strip-cwd-prefix",
        },
      },
    },

    extensions = {
      ["ui-select"] = {
        require("telescope.themes").get_dropdown {
          -- even more opts
        },
      },
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
      project = {
        hidden_files = true,
      },
      frecency = {
        --db_root = "/home/my_username/path/to/db_root",
        show_scores = false,
        show_unindexed = true,
        ignore_patterns = { "*.git/*", "*/tmp/*" },
        disable_devicons = false,
      },
      yank_history = {
        picker = {
          select = {
            action = nil, -- nil to use default put action
          },
          telescope = {
            mappings = nil, -- nil to use default mappings
          },
        },
      },
      lsp_handlers = {
        location = {
          telescope = {},
          no_results_message = "No references found",
        },
        symbol = {
          telescope = {},
          no_results_message = "No symbols found",
        },
        call_hierarchy = {
          telescope = {},
          no_results_message = "No calls found",
        },
        disable = {
          ["textDocument/codeAction"] = true,
        },
        code_action = {
          telescope = require("telescope.themes").get_dropdown {},
        },
      },
      -- Jump on markdown headers
      heading = {
        treesitter = true,
        picker_opts = {
          layout_config = { width = 0.8, preview_width = 0.5 },
          layout_strategy = "horizontal",
        },
      },
      undo = {
        use_delta = true,
        side_by_side = false,
        diff_context_lines = vim.o.scrolloff,
        entry_format = "state #$ID, $STAT, $TIME",
        vertical = {
          height = 0.8,
          mirror = false,
          preview_cutoff = 120,
          prompt_position = "bottom",
          width = 0.87,
        },
        mappings = {
          i = {
            ["<cr>"] = require("telescope-undo.actions").yank_additions,
            ["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
            ["<C-cr>"] = require("telescope-undo.actions").restore,
          },
        },
      },
    },
  }

  --telescope.load_extension('project')
  telescope.load_extension "fzf"
  -- This is the best option to open window for selection instead the regular selection in cmdline
  telescope.load_extension "ui-select"
  -- Jump to most common places
  --telescope.load_extension "frecency"
  -- See more feature about lazygit
  --telescope.load_extension "lazygit"
  -- Allow us to jump to dap point and other features
  telescope.load_extension "dap"
  -- Allow us to see the register nicely for our current selection (<leader>fy)
  --telescope.load_extension "yank_history"
  -- This will allow us to jump to any go to definition using the lspconfig
  telescope.load_extension "lsp_handlers"
  -- Jump on markdown heading easily within the given document (:Telescope heading), markdown files only.
  telescope.load_extension "heading"
  -- Undo Telescope
  telescope.load_extension "undo"
end

M.setup()

return M
