return {
  {
    "ghasak/githubG.nvim",
    cond = true, -- load this plugin
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
      require("onedark").setup { style = "gdark" }
      vim.cmd [[colorscheme onedark]]
    end,
    config = function() vim.opt.termguicolors = true end,
  },


  -- ==========================================================================
  -- 	                      Utilities for NVIM IDE Env
  -- ==========================================================================
  { "nvim-lua/popup.nvim", lazy = true }, -- An implementation of the Popup API from vim in Neovim
  { "nvim-lua/plenary.nvim", branch = "master", lazy = true },


  -- ==========================================================================
  -- 	                      Core Dependencies and Utilities
  -- ===========================================================================
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    -- lazy = true,
    -- event = "BufReadPre",
    -- event = "VimEnter",
    -- event = { "BufRead", "BufNewFile" },
    -- build = ":TSUpdate",
    config = function() require("plugins.configs.gi_treesitter").setup() end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects", -- vaf, vif, vac,
      event = "InsertEnter",
    },
  },

  ----------------------------------------------------------------
  --                  treesitter tools
  --  {all were in the dependencies of nvim-treesitter}
  ----------------------------------------------------------------
  { "windwp/nvim-ts-autotag", event = "InsertEnter" },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "InsertEnter",
  },

  { "RRethy/nvim-treesitter-textsubjects", event = "InsertEnter" },
  {
    -- This plugin is alternative to nvim.context
    "nvim-treesitter/nvim-treesitter-context",
    cond = true, -- Loading the context, if false it will not be loaded,
    cmd = { "TSContextDisable", "TSContextEnable", "TSContextToggle" },
    event = "InsertEnter",
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        multiwindow = false, -- Enable multiwindow support.
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end,
  },


  -- a playground plugin deals with the treesitter configurations
  -- necessary for checking the treesitter colorsscheme - dev
  { "nvim-treesitter/playground", event = "InsertEnter" }, -- Better icons
  {
    "kyazdani42/nvim-web-devicons",
    event = "VimEnter",
    config = function()
      require("nvim-web-devicons").setup {
        default = true,
        -- takes effect when `strict` is true
        override_by_filename = {
          [".gitignore"] = {
            icon = "",
            color = "#f1502f",
            name = "Gitignore",
          },
          ["tex"] = { icon = "󰙩", color = "#70B77E", name = "tex" },
        },
      }
    end,
  },


  -- ==========================================================================
  -- 	                     Navigation and Explorer
  -- ==========================================================================
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8", -- working with nvim v.0.11.0
    lazy = true,
    event = "VimEnter",
    cmd = "Telescope",
    init = function() require("core.utils").load_mappings "telescope" end,
    config = function() require("plugins.configs.gi_telescope").config() end,
    -- Dependencies are for the telescope extensions, check last segement of the telescope.
    dependencies = {

      {
        -- This native loading fzf written in C
        -- https://github.com/nvim-telescope/telescope-fzf-native.nvim
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
        event = "InsertEnter",
      },
      -- This is ui for showing menu for io.popen
      -- It will open most output to a selection including, dap, gen.nvim (AI)
      -- https://github.com/nvim-telescope/telescope-ui-select.nvim
      { "nvim-telescope/telescope-ui-select.nvim", event = "VimEnter" },
      -- This will provide us with a nicer window for our telescope
      -- to jump to definitions using multiple jump points instead
      -- of always jumping horizontally from `vim.buf.lsp`, which
      -- is always stuck and requires pressing `:q` to escape.
      {
        "gbrlsnchs/telescope-lsp-handlers.nvim",
        --cond = false, -- Loading the dap, if false it will not be loaded,
        event = "VimEnter",
      },
      {
        "crispgm/telescope-heading.nvim",
        ft = { "makrdown" },
        event = "InsertEnter",
        ensure_installed = {
          "markdown",
          "rst",
        },
      },
      {
        "debugloop/telescope-undo.nvim",
        event = "InsertEnter",
      },

      { "nvim-telescope/telescope-dap.nvim", event = "InsertEnter" },
    },
  },

  -- FZF Lua
  {
    "ibhagwan/fzf-lua",
    lazy = true,
    dependencies = { "kyazdani42/nvim-web-devicons" },
    -- event = "BufEnter",
    event = "VimEnter",
    config = function() require "plugins.configs.gi_fzf" end,
  },

  -- Floating Terminal
  {
    "akinsho/toggleterm.nvim",
    keys = { [[<C-\>]] },
    cmd = { "ToggleTerm", "TermExec" },
    config = function() require("plugins.configs.gi_toggleterm").setup() end,
  }, -- Using floating terminal

  { "christoomey/vim-system-copy", lazy = true, event = "InsertEnter" },
  -- Yazi File Explorer
  {
    "mikavilpas/yazi.nvim",
    event = "InsertEnter",
    dependencies = {
      -- check the installation instructions at
      -- https://github.com/folke/snacks.nvim
      "folke/snacks.nvim",
    },
    keys = require("plugins.configs.gi_yazi").keys,
    opts = require("plugins.configs.gi_yazi").opts,
    init = require("plugins.configs.gi_yazi").init,
  },

  -- =========================================================================
  -- 	                  Programming Language Servers
  -- =========================================================================
  {
    "saghen/blink.cmp", -- the blink completion plugin
    version = "*", -- track latest release
    -- build = "cargo build --release", -- for optional Rust speedups
    build = function()
      if vim.fn.empty(vim.fn.glob(vim.fn.stdpath "data" .. "/lazy/blink.cmp/target/release/libblink_cmp.dylib")) == 1 then
        vim.fn.system "cargo build --release"
      end
    end,
    event = "InsertCharPre",
    dependencies = {
      "L3MON4D3/LuaSnip", -- snippet engine
      "rafamadriz/friendly-snippets", -- snippet definitions
      {
        "Kaiser-Yang/blink-cmp-dictionary",
        dependencies = { "nvim-lua/plenary.nvim" },
      },

      -- compatibility layer for nvim-cmp sources (including cmp-emoji)
      {
        "saghen/blink.compat",
        version = "*",
        lazy = true,
        opts = {}, -- no special opts needed
      },
      -- this is the actual cmp-emoji plugin
      { "allaman/emoji.nvim", dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/cmp-emoji" } },

      "hrsh7th/cmp-calc",
      "f3fora/cmp-spell",
      -- Add these:
      "giuxtaposition/blink-cmp-copilot",
      "onsails/lspkind-nvim",
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
     { "echasnovski/mini.icons", opts = {} },
      -- any other sources you need, e.g. cmp-tabnine, cmp-path, etc.
    },
    config = function() require("plugins.configs.gi_blink_cmp").setup() end,
  },


  --[[
  🔌 Plugin: mason.nvim for language server
  📦 Repo: https://github.com/williamboman/mason.nvim

  📋 Description:
  A UI-based package manager for managing external language servers, DAP servers,
  linters, and formatters. It simplifies installing and updating LSP servers for Neovim.

  📌 Why Use It:
  Replaces manual system installs of LSPs with a clean, declarative interface.
  Integrates seamlessly with `mason-lspconfig` and `nvim-lspconfig`.

  🧠 Note:
  Commands like `:MasonInstall` and `:MasonUninstall` make it easy to manage tooling without leaving Neovim.
]]
  {
    "williamboman/mason.nvim",
    lazy = true,
    event = { "VeryLazy" },
    -- event = {"VimEnter"},
    cmd = {
      "Mason",
      "MasonInstall",
      "MasonInstallAll",
      "MasonUninstall",
      "MasonUninstallAll",
      "MasonLog",
    },
    -- registries = {
    --   "github:mason-org/mason-registry",
    -- },

    init = function() require("mason").setup() end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "VeryLazy" },
    dependencies = {
      -- { "williamboman/nvim-lsp-installer" }, -- deprecated
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { "simrat39/rust-tools.nvim", event = "LspAttach" },
      { "saghen/blink.cmp" },
      -- { "dnlhc/glance.nvim" }, -- better jump to definition similar to vscode.
      { "folke/snacks.nvim" },
    },
    -- This will be initailized at first
    init = function() require("core.utils").lazy_load "nvim-lspconfig" end,
    -- Then the configuration will be loaded
    config = function()
      require("plugins.configs.gi_mason_lspconfig_nvim").setup()
      -- Adding the requiremetns - this will support for java requiremetns.
      -- require("lspsaga").setup(require "plugins.configs.p09_mySaga")
    end,
  },

  -- I will using conform
  {
    "stevearc/conform.nvim",
    --event = { "BufReadPre", "BufNewFile" },
    event = { "InsertEnter" },
    lazy = true,
    config = function() require("plugins.configs.gi-conform").config() end,
  },


  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-lspconfig" },
    config = function() require("lsp_signature").setup(
      -- {hint_prefix     = " ",} -- default is : "🐼"
      require "plugins.configs.gi_lsp_signature" -- custom configuration
    ) end,
  }, -- Adding symbols outline (similar to vista)






  ---------------- EXPERIMENTING WITH MODERN NEOVIMM PLUGINS -------------------------

  -- Most advanced setup for copilot
  -- (modern lua support similar to tpop plugin which is not used anymore)
  -- Activate: <Ctr+a> in Insert mode
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    keys = require("core.keymappings").copilot_keys,
    config = function()
      -- 1) Your normal setup
      require("copilot").setup {
        suggestion = {
          enabled = true,
          auto_trigger = false,
          keymap = {
            accept = "<C-CR>",
            -- accept_word = "<C-j>",
            -- accept_line = "<C-k>",
            -- next = "<C-n>",
            -- prev = "<C-p>",
            dismiss = "<C-e>",
          },
        },
      }
    end,
  },

  -- Copilot nvim open chat prompt
  {

    "CopilotC-Nvim/CopilotChat.nvim",
    event = "InsertEnter",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or zbirenbaum/copilot.lua, "github/copilot.vim"
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
    -- 0/64000 tokens used
    --You refer to the opened buffer using ->  #buffers:visible
    --| Insert|	Normal |
    --+-------+--------+
    --| <C-s>	| <CR>   |
  },


  ---------------- END OF PLUGINS SETTING -------------------------

}
