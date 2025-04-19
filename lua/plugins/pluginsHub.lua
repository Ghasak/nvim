return {
  --   {
  --   'projekt0n/github-nvim-theme',
  --   name = 'github-theme',
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require('github-theme').setup({
  --       -- ...
  --     })
  --
  --     vim.cmd('colorscheme github_dark')    -- github_light
  --   end,
  -- },
  --

  ---@diagnostic disable, 2: 2
  {
    "ghasak/githubG.nvim",
    cond = true, -- load this plugin
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
      require("onedark").setup { style = "gdark" }
      vim.cmd [[colorscheme onedark]]
    end,
    config = function()
      vim.opt.termguicolors = true
    end,
  },

  -- ==========================================================================
  -- 	                      Utilities for NVIM IDE Env
  -- ==========================================================================
  { "nvim-lua/popup.nvim", lazy = true }, -- An implementation of the Popup API from vim in Neovim
  { "nvim-lua/plenary.nvim", lazy = true },
  -- ==========================================================================

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
    config = function()
      require("plugins.configs.p01_treesitter").setup()
    end,
    dependencies = {
      { "p00f/nvim-ts-rainbow", event = "InsertEnter" },
    },
  },
  --
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
    init = function()
      require("core.utils").load_mappings "telescope"
    end,
    config = function()
      require("plugins.configs.p02_myTelescope").config()
    end,
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

  -- nvim-tree
  {
    "kyazdani42/nvim-tree.lua",
    lazy = true,
    version = "*",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    -- module = { "nvim-tree", "nvim-tree.actions.root.change-dir" },
    config = function()
      require "plugins.configs.p03_myNvimTree"
    end,
    cmd = { "NvimTreeToggle", "NvimTreeToggle", "NvimTreeClose" },
  },

  -- FZF Lua
  {
    "ibhagwan/fzf-lua",
    lazy = true,
    dependencies = { "kyazdani42/nvim-web-devicons" },
    -- event = "BufEnter",
    event = "VimEnter",
    config = function()
      require "plugins.configs.p04_myFzf"
    end,
  },

  -- undotree
  {
    "mbbill/undotree",
    event = "VimEnter",
    config = function()
      require "plugins.configs.p05_myUndoTreeConfig"
    end,
    cmd = { "UndotreeToggle", "UndotreeHide" },
  },
  -- Floating Terminal
  {
    "akinsho/toggleterm.nvim",
    keys = { [[<C-\>]] },
    cmd = { "ToggleTerm", "TermExec" },
    config = function()
      require("plugins.configs.p06_myTerminal").setup()
    end,
  }, -- Using floating terminal
  --{ "voldikss/vim-floaterm", lazy = true, cmd = { "FloatermToggle" } },
  -- Dired.nvim is simialr to Emacs dired for file managment
  {
    "X3eRo0/dired.nvim",
    event = "InsertEnter",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("plugins.configs.p07_myDired").config()
    end,
  },

  -- Using Rnvim  <Ranger>
  {
    "kevinhwang91/rnvimr",
    lazy = true,
    cmd = { "RnvimrToggle" },
    config = function()
      require("plugins.configs.p08_myRanger").Style()
    end,
  }, -- will allow to copy and paste in Nvim
  { "christoomey/vim-system-copy", lazy = true, event = "InsertEnter" },

  -- =========================================================================
  -- 	                  Programming Language Servers
  -- =========================================================================
  --[[
  🔌 Plugin: nvim-cmp for autocompletion
  📦 Repo: https://github.com/hrsh7th/nvim-cmp

  📋 Description:
  A powerful, extensible autocompletion plugin for Neovim written in Lua.
  Supports multiple sources: LSP, buffer, path, snippets, and more.

  📌 Why Use It:
  Acts as the core engine for completion, with rich support for fuzzy matching,
  multiple sources, and custom formatting. Essential for modern Neovim LSP UX.
  ]]

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    lazy = true,
    dependencies = {
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lua",
      "ray-x/cmp-treesitter",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "lukas-reineke/cmp-rg",
      "davidsierradz/cmp-conventionalcommits",
      "onsails/lspkind-nvim",
      "hrsh7th/cmp-calc",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-emoji",
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "friendly-snippets", "vim-snippets" },
        --    config = function()
        --      require("config.snip").setup()
        --    end,
      },
      "rafamadriz/friendly-snippets",
      "honza/vim-snippets",
    },

    config = function()
      require("plugins.configs.p12_cmp").setup()
    end,
  }, -- TabNine auto-compleletions
  {
    "tzachar/cmp-tabnine",
    lazy = true,
    event = "InsertEnter",
    build = "./install.sh",
    dependencies = { "hrsh7th/nvim-cmp", "cmp-buffer" },
  }, -- Indent
  {
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    event = "InsertEnter",
    config = function()
      require("plugins.configs.p13_indent_line").setup()
    end,
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
    init = function()
      require("mason").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "VeryLazy" },
    dependencies = {
      -- { "williamboman/nvim-lsp-installer" }, -- deperated
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { "saghen/blink.cmp" },
      -- { "dnlhc/glance.nvim" },
    },
    -- This will be initailized at first
    init = function()
      require("core.utils").lazy_load "nvim-lspconfig"
    end,
    -- Then the configuration will be loaded
    config = function()
      require("plugins.configs.p10_mason_lspconfig_nvim").setup()
      -- Adding the requiremetns - this will support for java requiremetns.
      require("lspsaga").setup(require "plugins.configs.p09_mySaga")
    end,
  },

  --[[
  🔌 Plugin: lsp_signature.nvim (LSP)
  📦 Repo: https://github.com/ray-x/lsp_signature.nvim

  📋 Description:
  Adds inline function signature popups as you type (like VSCode), leveraging LSP data.

  📌 Why Use It:
  Greatly improves developer experience when writing code, especially in typed languages.
  Displays parameters, overloads, and types during Insert mode.

  🔁 Auto-loads only when needed (on InsertEnter).
]]

  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-lspconfig" },
    config = function()
      require("lsp_signature").setup()
    end,
  }, -- Adding symbols outline (similar to vista)

  -- Navigation for all the coding problems
  {
    "folke/trouble.nvim",
    lazy = true,
    event = "InsertEnter",
    cmd = "Trouble",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {}
    end,
  },

  {
    "glepnir/lspsaga.nvim",
    --event = "BufReadPre",
    branch = "main",
    event = "InsertEnter",
    -- event = "BufEnter",
    -- ft = {'c', 'cpp', 'lua', 'rust', 'go', 'python', 'bash'},
    -- event = 'LspAttach',
    config = function()
      require("lspsaga").setup(require "plugins.configs.p09_mySaga")
    end,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" }, -- optional
      { "kyazdani42/nvim-web-devicons" }, -- optional
    },
  },
  --------------------------------- Languages Specific Plugins ------------------------------

  -- C/CPP CMake lsp Enhancer
  --{ "Civitasv/cmake-tools.nvim", ft = { "cpp", "c" }, lazy = true , event = "InsertEnter"},

  -- Rust lsp Enhancer
  { "simrat39/rust-tools.nvim", lazy = true, ft = "rust" },
  {
    "saecki/crates.nvim",
    lazy = true,
    ft = { "rust", "toml" },
    tag = "v0.3.0",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("crates").setup { popup = { border = "rounded" } }
    end,
  },

  -- Java Enhancements (Highly Recommended)
  {
    "mfussenegger/nvim-jdtls",
    ft = "java", -- Lazy-load on opening Java files
    dependencies = { "neovim/nvim-lspconfig", "mfussenegger/nvim-dap" },
    -- config = function()
    --   -- This configuration relies on nvim-jdtls to configure lspconfig for jdtls
    --   -- require("plugins.configs.lsp.custom_servers.javaConfig").config()
    -- end,
  },

  ---------------- End of  Languages Plugins  -------------------------

  --[[
  🔌 Plugin: fidget.nvim
  📦 Repo: https://github.com/j-hui/fidget.nvim

  📋 Description:
  Displays LSP progress and loading notifications in a small, elegant floating window.
  Shows messages like "LSP attached", "indexing...", and other language server tasks.

  📌 Why Use It:
  Great for visibility into what your LSP is doing (especially during startup or indexing).
  Helps troubleshoot slow responses or inactivity from LSP servers.
  Also confirms when a language server successfully attaches to a buffer.

  🧠 Note:
  Automatically hooks into the LSP client — no extra setup required per server.
]]

  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    config = function()
      require("fidget").setup {
        text = {
          spinner = "dots",
          done = "✔",
        },
        align = {
          bottom = true,
          right = true,
        },
        window = {
          relative = "editor",
          blend = 10,
        },
      }
    end,
  },

  -- Using formatter (instead of null-lsp)
  --{"sbdchd/neoformat", event = "VeryLazy", lazy = true, cmd = "Neoformat"},
  -- none-ls is also not working good, instead
  -- I will using conform
  {
    "stevearc/conform.nvim",
    --event = { "BufReadPre", "BufNewFile" },
    event = { "InsertEnter" },
    lazy = true,
    config = function()
      require("plugins.configs.p14_myConform").config()
    end,
  },

  -- Adding notification for nvim
  {
    "folke/neodev.nvim",
    ft = "lua",
    event = "InsertEnter",
  },

  -- markdown-preview using :markdown Preview
  -- install with yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && ./install.sh",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "mzlogin/vim-markdown-toc",
    ft = { "markdown" },
    lazy = true,
    event = "InsertEnter",
    cmd = { "GenTocGitLab", "GenTocMarked" },
  },

  --[[
  🔌 Plugin: nvim-docs-view
  📦 Repo: https://github.com/amrbashir/nvim-docs-view

  📋 Description:
  Opens a sidebar showing the documentation (e.g., function signatures)
  for the symbol under the cursor, powered by LSP.

  📌 Why Use It:
  Provides a live, floating docs pane for function reference or code exploration
  without leaving the buffer — useful for learning APIs and libraries in context.
]]

  {
    "amrbashir/nvim-docs-view",
    -- opt = true,
    event = "InsertEnter",
    cmd = { "DocsViewToggle" },
    config = function()
      require("docs-view").setup {
        position = "right",
        width = vim.o.columns * 0.35,
      }
    end,
  },


--[[
  🛠️ Category: Developer Tools / Learning Aids

  🔌 Plugin: popfix
  📦 Repo: https://github.com/RishabhRD/popfix

  📋 Description:
  A minimal floating popup UI library built for Neovim in Lua.
  Designed as a lightweight replacement for `popup.nvim` and used internally by other tools.

  📌 Why Use It:
  Acts as a UI dependency for other developer plugins like `nvim-cheat.sh`.
  You usually don’t interact with it directly.
]]
{ "RishabhRD/popfix", event = "InsertEnter" },

--[[
  🛠️ Category: Developer Tools / Learning Aids

  🔌 Plugin: nvim-cheat.sh
  📦 Repo: https://github.com/RishabhRD/nvim-cheat.sh

  📋 Description:
  Neovim wrapper around [cheat.sh](https://cheat.sh), a fast and simple way to get CLI-style language or tool help.

  📌 Why Use It:
  Allows you to query language-specific help and command-line cheat sheets from inside Neovim.
  Great for learning new tools, refreshing syntax, or boosting productivity without leaving the editor.

  💡 Tip:
  Run `:CheatSH` followed by a language and query, e.g. `:CheatSH lua table`
]]
{ "RishabhRD/nvim-cheat.sh", event = "InsertEnter" },



  ---------------- END OF PLUGINS SETTING -------------------------
}
