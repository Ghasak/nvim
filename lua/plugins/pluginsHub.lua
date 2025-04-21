return {
  -- {
  --   "projekt0n/github-nvim-theme",
  --   name = "github-theme",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require("github-theme").setup {
  --       -- ...
  --     }
  --
  --     vim.cmd "colorscheme github_dark" -- github_light
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
      "tzachar/cmp-tabnine",
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "friendly-snippets",
          "vim-snippets",
          "hrsh7th/vim-vsnip",
          "hrsh7th/vim-vsnip-integ",
          "dcampos/nvim-snippy",
        },
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
    -- lazy = true,
    event = "InsertEnter",
    build = "./install.sh",
    dependencies = { "hrsh7th/nvim-cmp", "cmp-buffer" },
  },
  -- -- Indent
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   lazy = true,
  --   event = "InsertEnter",
  --   config = function()
  --     require("plugins.configs.p13_indent_line").setup()
  --   end,
  -- },
  -- -- better navigations with lsp
  -- {
  --   event = "VeryLazy",
  --   "dnlhc/glance.nvim",
  --   config = function()
  --     require("plugins.configs.myGlance").settings()
  --   end,
  -- }, -- Use gD, gR , gY, gM - Nvim v. 0.11.0 gD is not working

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
      -- { "dnlhc/glance.nvim" }, -- better jump to definition similar to vscode.
      { "folke/snacks.nvim" },
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
  1. Automatically hooks into the LSP client — no extra setup required per server.
  2. To stop for a given lsp buffer use: :Fidget suppress
]]

  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    config = function()
      require("fidget").setup {
        progress = {
          ignore = {
            -- suppress only the proc‑macro path you circled
            function(msg)
              return msg.lsp_client.name == "rust_analyzer"
                and msg.title:match "^/" -- absolute file path
                and msg.message:match "Loading proc‑macros…" -- “Loading proc‑macros…”
            end,
          },
        },
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

  -- Context.vim: A vim plugin that shows the context of the currently visible buffer context.
  -- It's supposed to work on a wide range of file types, but is probably most suseful when looking at source code files.
  -- https://github.com/wellle/context.vim  {nvim already implemented this plugin in the lsp directly}
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      require "plugins.configs.myNotify"
    end,
  },
  -- Navic for winbar, not needed anymore

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

  {
    "linrongbin16/lsp-progress.nvim",
    event = "LspAttach",
    config = function()
      require("lsp-progress").setup {
        client_format = function(client_name, spinner, series_messages)
          for _, series in ipairs(series_messages) do
            if not series.done then
              return spinner
            end
          end
          return "✓" -- Optional: return checkmark when all tasks are done
        end,
        series_format = function(title, message, percentage, done)
          return { msg = "", done = done } -- Suppress message text
        end,
      }

      -- 👇 Add this *here*, after setup()
      vim.api.nvim_create_autocmd("User", {
        pattern = "LspProgressStatusUpdated",
        callback = require("lualine").refresh,
      })
    end,
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      -- { "nvim-treesitter" },
      { "nvim-web-devicons" },
      "linrongbin16/lsp-progress.nvim", -- LSP loading progress
    },
    --event = "VimEnter",
    event = "VeryLazy",
    config = function()
      require("plugins.configs.p15_myLuaLine").setup()
    end,
  },

  -- Buffer line
  {
    "akinsho/nvim-bufferline.lua",
    lazy = true,
    -- event = "BufWritePre",  -- Only will be trigger when you save your buffer.
    --event = "CursorMoved",
    event = "VeryLazy",
    dependencies = "nvim-web-devicons",
    config = function()
      require("plugins.configs.p16_myBufferConfig").config()
    end,
  },

  -- This will  highlight the colors as #558817
  {
    "norcalli/nvim-colorizer.lua",
    event = "InsertEnter",
    lazy = true,
    cmd = { "ColorizerToggle" },
    config = function()
      require("plugins.configs.others").colorizer()
    end,
  },
  -- smooth scroll
  -- {
  --   "karb94/neoscroll.nvim",
  --   event = "InsertEnter",
  --   lazy = true,
  --   config = function()
  --     require("plugins.configs.others").neoscroll()
  --   end,
  -- },
  -- Markdown, Markup-language better view (two plugins)

  -- Markdown, Markup-language better view (two plugins)
  -- {
  --   -- "npxbr/glow.nvim",
  --   "ellisonleao/glow.nvim",
  --   event = "InsertEnter",
  --   ft = { "markdown" },
  --   config = function()
  --     require("plugins.configs.myGlowMark").setup()
  --   end,
  -- },

  {
    "MeanderingProgrammer/markdown.nvim",
    event = "InsertEnter",
    ft = { "markdown" },
    cmd = { "RenderMarkdown" },
    main = "render-markdown",
    opts = {},
    name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
    --dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },

    config = function()
      require("plugins.configs.myMarkdown").config()
    end,
  },

  -- vim-eftt (highlight the f/t/F/T mappings)
  -- Source, https://github.com/hrsh7th/vim-eft
  {
    "hrsh7th/vim-eft",
    -- event = "CursorMoved",
    event = "InsertEnter",
    config = function()
      require("plugins.configs.myVim_eft").setup()
    end,
  }, -- lsp loader status display
  { "ggandor/lightspeed.nvim", lazy = true, event = "InsertEnter" },

  {
    "VonHeikemen/fine-cmdline.nvim",
    event = "CmdwinEnter",
    cmd = "FineTerm",
    config = function()
      require("plugins.configs.myFineCmdLineFloating").config()
    end,
    dependencies = {
      { "MunifTanjim/nui.nvim" },
    },
  },

  -- ===========================================================================
  --           PRODUCTIVITIES AND PERFORMANCE
  -- ===========================================================================

  -- Clear highlight when you search for a word automatically
  {
    "romainl/vim-cool",
    lazy = true,
    event = "CmdwinEnter", -- Only will be loaded when we enter the CMD in vim
    config = function()
      vim.g.CoolTotalMatches = 1
    end,
  }, -- Adding acceleration to the mouse for faster/smooth motion
  -- { "rhysd/accelerated-jk", lazy = true, event = "VeryLazy" },
  -- Deleting a given buffer without affecting

  --{ "famiu/bufdelete.nvim", lazy = true, cmd = { "Bdelete" } },
  { "ojroques/nvim-bufdel", lazy = true, cmd = { "BufDel", "BufDelAll", "BufDelOthers" } },

  { "vim-scripts/ReplaceWithRegister", lazy = true, event = "InsertEnter" },
  -- Better repeat (.) with nvim (from tpope)
  --  use({ "tpope/vim-repeat" })

  -- Better surrounding
  { "tpope/vim-surround", lazy = true, event = "InsertEnter" },
  --  -- Development
  --  use({ "tpope/vim-dispatch" })
  --  use({ "tpope/vim-commentary" })
  --  use({ "tpope/vim-rhubarb", event = "VimEnter" })
  { "tpope/vim-unimpaired", event = "InsertEnter" },
  --  use({ "tpope/vim-vinegar" })
  --  use({ "tpope/vim-sleuth" })
  -- Replace word with register
  { "gennaro-tedesco/nvim-peekup", event = "InsertEnter" },

  {
    "rainbowhxch/beacon.nvim",
    lazy = true,
    event = "InsertEnter",
    -- :Beacon: highlight current position (even if plugin is disabled)
    -- :BeaconToggle: toggle beacon enable/disable

    config = function()
      -- To highlight your becacon indicator
      -- vim.cmd([[highlight Beacon guibg=#007CBE ctermbg=15]])
      require("beacon").setup {}
    end,
  },

  -- ===========================================================================
  --                        DEBUGGER TOOLS
  -- ===========================================================================
  -- Debugging
  -- use({ "puremourning/vimspector", event = "BufWinEnter" })
  -- Debugging
  -- This plugin adds virtual text support to nvim-dap. nvim-treesitter is used to find variable definitions.
  -- It will add variable text value in the debugging session.
  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    event = "InsertEnter",
    config = function()
      require("nvim-dap-virtual-text").setup {
        display_callback = function(variable, _, _, _)
          return variable.name .. "  󰞮 󱚟   " .. variable.value
        end,
      }
      vim.g.dap_virtual_text = true
    end,
  },
  {
    "mfussenegger/nvim-dap",
    cond = true,
    lazy = true,
    event = "InsertEnter",
    dependencies = {
      { "nvim-dap-virtual-text", event = "InsertEnter" },
      { "nvim-dap-python", event = "InsertEnter" },
      -- Added dependencies for the dap-ui
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
        event = "InsertEnter",
      },
      { "mfussenegger/nvim-dap-python", event = "InsertEnter" },
      { "nvim-telescope/telescope-dap.nvim", event = "InsertEnter" },
    },
    config = function()
      require "plugins.configs.dap"
    end,
  },

  -----------------------------------------------------------------

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = true,
              replace_netrw = true,
          width = 30, -- 40% of the Neovim screen
          height = 0.8,
          border = "rounded",


      },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      picker = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      styles = {
        notification = {
          -- wo = { wrap = true } -- Wrap notifications
        },
      },
    },
    keys = {
      -- Top Pickers & Explorer
      {
        "<leader><space>",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart Find Files",
      },
      {
        "<leader>,",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader>n",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
      {
        "<leader>ftt",
        function()
          Snacks.explorer(

          )
        end,
        desc = "File Explorer",
      },
      -- find
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>fc",
        function()
          Snacks.picker.files { cwd = vim.fn.stdpath "config" }
        end,
        desc = "Find Config File",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.files()
        end,
        desc = "Find Files",
      },
      {
        "<leader>fg",
        function()
          Snacks.picker.git_files()
        end,
        desc = "Find Git Files",
      },
      {
        "<leader>fp",
        function()
          Snacks.picker.projects()
        end,
        desc = "Projects",
      },
      {
        "<leader>fr",
        function()
          Snacks.picker.recent()
        end,
        desc = "Recent",
      },
      -- git
      {
        "<leader>gb",
        function()
          Snacks.picker.git_branches()
        end,
        desc = "Git Branches",
      },
      {
        "<leader>gl",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git Log",
      },
      {
        "<leader>gL",
        function()
          Snacks.picker.git_log_line()
        end,
        desc = "Git Log Line",
      },
      {
        "<leader>gs",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git Status",
      },
      {
        "<leader>gS",
        function()
          Snacks.picker.git_stash()
        end,
        desc = "Git Stash",
      },
      {
        "<leader>gd",
        function()
          Snacks.picker.git_diff()
        end,
        desc = "Git Diff (Hunks)",
      },
      {
        "<leader>gf",
        function()
          Snacks.picker.git_log_file()
        end,
        desc = "Git Log File",
      },
      -- Grep
      {
        "<leader>sb",
        function()
          Snacks.picker.lines()
        end,
        desc = "Buffer Lines",
      },
      {
        "<leader>sB",
        function()
          Snacks.picker.grep_buffers()
        end,
        desc = "Grep Open Buffers",
      },
      {
        "<leader>sg",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "<leader>sw",
        function()
          Snacks.picker.grep_word()
        end,
        desc = "Visual selection or word",
        mode = { "n", "x" },
      },
      -- search
      {
        '<leader>s"',
        function()
          Snacks.picker.registers()
        end,
        desc = "Registers",
      },
      {
        "<leader>s/",
        function()
          Snacks.picker.search_history()
        end,
        desc = "Search History",
      },
      {
        "<leader>sa",
        function()
          Snacks.picker.autocmds()
        end,
        desc = "Autocmds",
      },
      {
        "<leader>sb",
        function()
          Snacks.picker.lines()
        end,
        desc = "Buffer Lines",
      },
      {
        "<leader>sc",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader>sC",
        function()
          Snacks.picker.commands()
        end,
        desc = "Commands",
      },
      {
        "<leader>sd",
        function()
          Snacks.picker.diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        "<leader>sD",
        function()
          Snacks.picker.diagnostics_buffer()
        end,
        desc = "Buffer Diagnostics",
      },
      {
        "<leader>sh",
        function()
          Snacks.picker.help()
        end,
        desc = "Help Pages",
      },
      {
        "<leader>sH",
        function()
          Snacks.picker.highlights()
        end,
        desc = "Highlights",
      },
      {
        "<leader>si",
        function()
          Snacks.picker.icons()
        end,
        desc = "Icons",
      },
      {
        "<leader>sj",
        function()
          Snacks.picker.jumps()
        end,
        desc = "Jumps",
      },
      {
        "<leader>sk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>sl",
        function()
          Snacks.picker.loclist()
        end,
        desc = "Location List",
      },
      {
        "<leader>sm",
        function()
          Snacks.picker.marks()
        end,
        desc = "Marks",
      },
      {
        "<leader>sM",
        function()
          Snacks.picker.man()
        end,
        desc = "Man Pages",
      },
      {
        "<leader>sp",
        function()
          Snacks.picker.lazy()
        end,
        desc = "Search for Plugin Spec",
      },
      {
        "<leader>sq",
        function()
          Snacks.picker.qflist()
        end,
        desc = "Quickfix List",
      },
      {
        "<leader>sR",
        function()
          Snacks.picker.resume()
        end,
        desc = "Resume",
      },
      {
        "<leader>su",
        function()
          Snacks.picker.undo()
        end,
        desc = "Undo History",
      },
      {
        "<leader>uC",
        function()
          Snacks.picker.colorschemes()
        end,
        desc = "Colorschemes",
      },
      -- LSP
      {
        "gd",
        function()
          Snacks.picker.lsp_definitions()
        end,
        desc = "Goto Definition",
      },
      {
        "gD",
        function()
          Snacks.picker.lsp_declarations()
        end,
        desc = "Goto Declaration",
      },
      {
        "gr",
        function()
          Snacks.picker.lsp_references()
        end,
        nowait = true,
        desc = "References",
      },
      {
        "gI",
        function()
          Snacks.picker.lsp_implementations()
        end,
        desc = "Goto Implementation",
      },
      {
        "gy",
        function()
          Snacks.picker.lsp_type_definitions()
        end,
        desc = "Goto T[y]pe Definition",
      },
      {
        "<leader>ss",
        function()
          Snacks.picker.lsp_symbols()
        end,
        desc = "LSP Symbols",
      },
      {
        "<leader>sS",
        function()
          Snacks.picker.lsp_workspace_symbols()
        end,
        desc = "LSP Workspace Symbols",
      },
      -- Other
      {
        "<leader>z",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>Z",
        function()
          Snacks.zen.zoom()
        end,
        desc = "Toggle Zoom",
      },
      {
        "<leader>.",
        function()
          Snacks.scratch()
        end,
        desc = "Toggle Scratch Buffer",
      },
      {
        "<leader>S",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
      {
        "<leader>n",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
      {
        "<leader>bd",
        function()
          Snacks.bufdelete()
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>cR",
        function()
          Snacks.rename.rename_file()
        end,
        desc = "Rename File",
      },
      {
        "<leader>gB",
        function()
          Snacks.gitbrowse()
        end,
        desc = "Git Browse",
        mode = { "n", "v" },
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
      {
        "<c-/>",
        function()
          Snacks.terminal()
        end,
        desc = "Toggle Terminal",
      },
      {
        "<c-_>",
        function()
          Snacks.terminal()
        end,
        desc = "which_key_ignore",
      },
      {
        "]]",
        function()
          Snacks.words.jump(vim.v.count1)
        end,
        desc = "Next Reference",
        mode = { "n", "t" },
      },
      {
        "[[",
        function()
          Snacks.words.jump(-vim.v.count1)
        end,
        desc = "Prev Reference",
        mode = { "n", "t" },
      },
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win {
            file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
            width = 0.6,
            height = 0.6,
            border = "double",
            wo = {
              spell = false,
              wrap = false,
              signcolumn = "yes",
              statuscolumn = " ",
              conceallevel = 3,
            },
          }
        end,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
          Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
          Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"
          Snacks.toggle.diagnostics():map "<leader>ud"
          Snacks.toggle.line_number():map "<leader>ul"
          Snacks.toggle
            .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
            :map "<leader>uc"
          Snacks.toggle.treesitter():map "<leader>uT"
          Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map "<leader>ub"
          Snacks.toggle.inlay_hints():map "<leader>uh"
          Snacks.toggle.indent():map "<leader>ug"
          Snacks.toggle.dim():map "<leader>uD"
        end,
      })
    end,
  },



  -- ==========================================================================
  -- 	                    Aesthetic and UI Design
  -- ==========================================================================

  -- Provide a TODO, PERF, HACK, NOTE, NOTE, FIX, WARNING Highlighting
  {
    "folke/todo-comments.nvim",
    event = "BufEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
    },
  },




  ---------------- END OF PLUGINS SETTING -------------------------
}
