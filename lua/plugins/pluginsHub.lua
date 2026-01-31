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
  {
    cond = false,
    "tribela/transparent.nvim",
    event = "VimEnter",
    config = true,
  },

  -- ==========================================================================
  -- 	                      Utilities for NVIM IDE Env
  -- ==========================================================================
  { "nvim-lua/popup.nvim", lazy = true }, -- An implementation of the Popup API from vim in Neovim
  { "nvim-lua/plenary.nvim", branch = "master", lazy = true },
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },

  {
    "folke/snacks.nvim",
    version = "v2.23.0",
    priority = 1000,
    lazy = false,
    opts = function() return require("plugins.configs.gi_snacks_nvim").opts end,

    -- ✅ CORRECT: Call setup in config, not in keys
    config = function(_, opts)
      require("snacks").setup(opts)

      -- NOW setup the keymaps AFTER snacks is initialized
      require("core.keymappings").setup_snacks_keymaps()
    end,

    init = function() return require("services.snacks_mini_services").snacks_services() end,
  },
  -- ==========================================================================
  -- 	                      Core Dependencies and Utilities
  -- ===========================================================================
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
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
    -- tag = "0.1.8", -- working with nvim v.0.11.0
    branch = "master",
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
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release -DCMAKE_POLICY_VERSION_MINIMUM=3.5 && cmake --build build --config Release && cmake --install build --prefix build",
        event = "InsertEnter",
      }, -- This is ui for showing menu for io.popen
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

  -- Custom configuration (defaults shown)

  {
    "stevearc/oil.nvim",
    cond = true,
    event = "InsertEnter",
    config = function() require("plugins.configs.gi_oil_nvim").config() end,
    -- Optional dependencies
    dependencies = { { "echasnovski/mini.icons", opts = {} } },
  },

  -- =========================================================================
  -- 	                  Programming Language Servers
  -- =========================================================================
  {
    "saghen/blink.cmp", -- the blink completion plugin
    version = "*", -- track latest release
    -- build = "cargo build --release", -- for optional Rust speedups
    build = function()
      if
        vim.fn.empty(vim.fn.glob(vim.fn.stdpath "data" .. "/lazy/blink.cmp/target/release/libblink_cmp.dylib")) == 1
      then
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

  -- better navigations with lsp
  {
    event = "VeryLazy",
    cond = false,
    branch = "master",
    "dnlhc/glance.nvim",
    config = function() require("plugins.configs.gi_glance").settings() end,
  }, -- Use gD, gR , gY, gM - Nvim v. 0.11.0 gD is not working

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
    -- "williamboman/mason.nvim",
    "mason-org/mason.nvim",
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

    init = function()
      require("mason").setup {

        ui = {
          check_outdated_packages_on_open = true,
          border = { "╔", "═", "╗", "║", "╝", "═", "╚", "║" },
        },
      }
    end,
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
      { "dnlhc/glance.nvim" }, -- better jump to definition similar to vscode.
      { "folke/snacks.nvim" },
    },
    -- This will be initailized at first
    init = function() require("core.utils").lazy_load "nvim-lspconfig" end,
    -- Then the configuration will be loaded
    config = function()
      require("plugins.configs.gi_mason_lspconfig_nvim").setup()
      -- Adding the requiremetns - this will support for java requiremetns.
      require("lspsaga").setup(require "plugins.configs.gi_lspsaga")
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
    config = function()
      require("lsp_signature").setup(
        -- {hint_prefix     = " ",} -- default is : "🐼"
        require "plugins.configs.gi_lsp_signature" -- custom configuration
      )
    end,
  }, -- Adding symbols outline (similar to vista)

  -- Navigation for all the coding problems
  {
    "folke/trouble.nvim",
    lazy = true,
    event = "InsertEnter",
    cmd = "Trouble",
    dependencies = "kyazdani42/nvim-web-devicons",
    config = function() require("trouble").setup {} end,
  },

  {
    "glepnir/lspsaga.nvim",
    --event = "BufReadPre",
    branch = "main",
    event = "InsertEnter",
    -- event = "BufEnter",
    -- ft = {'c', 'cpp', 'lua', 'rust', 'go', 'python', 'bash'},
    -- event = 'LspAttach',
    config = function() require("lspsaga").setup(require "plugins.configs.gi_lspsaga") end,
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
    dependencies = { { "nvim-lua/plenary.nvim" }, { "neovim/nvim-lspconfig" } },
    config = function() require("crates").setup { popup = { border = "double" } } end,
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

  -- lua development suppoart
  {
    "folke/neodev.nvim",
    ft = "lua",
    event = "InsertEnter",
  },

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
    cond = true,
    event = "LspAttach",
    config = function()
      require("fidget").setup {
        progress = {
          suppress_on_insert = false,
          ignore = {
            function(msg)
              return msg.lsp_client.name == "rust_analyzer"
                and msg.title:match "^/"
                and msg.message:match "Loading proc%-macros…"
            end,
          },
          display = {
            progress_icon = { "dots" },
            done_icon = "✔",
            -- Removed invalid align option
            -- Alignment is now controlled by notification.window.align
          },
        },
        notification = {
          window = {
            relative = "editor",
            winblend = 10,
            align = "bottom", -- This controls the alignment (bottom, top)
            x_padding = 1, -- Padding from right edge (for right alignment)
            y_padding = 0, -- Padding from bottom edge
          },
        },
      }
    end,
    keys = {
      {
        "<leader>sf",
        function() vim.cmd "Fidget suppress" end,
        desc = "Start Fidget",
      },
    },
  },

  -- Context.vim: A vim plugin that shows the context of the currently visible buffer context.
  -- It's supposed to work on a wide range of file types, but is probably most suseful when looking at source code files.
  -- https://github.com/wellle/context.vim  {nvim already implemented this plugin in the lsp directly}
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function() require "plugins.configs.gi_nvim_notify" end,
  },

  -- markdown-preview using :markdown Preview
  -- install with yarn or npm
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && ./install.sh",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },

  {
    "mzlogin/vim-markdown-toc",
    ft = { "markdown", "quarto" },
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

    config = function() require("plugins.configs.gi_markdown_nvim").config() end,
  },

  -- vim-eftt (highlight the f/t/F/T mappings)
  -- Source, https://github.com/hrsh7th/vim-eft
  {
    "hrsh7th/vim-eft",
    -- event = "CursorMoved",
    event = "InsertEnter",
    config = function() require("plugins.configs.gi_vim_eft").setup() end,
  }, -- lsp loader status display -- deprecated
  -- { "ggandor/lightspeed.nvim", lazy = true, event = "InsertEnter" },
  {
    -- "ggandor/leap.nvim",
    url = "https://codeberg.org/andyg/leap.nvim",
    cond = true,
    event = "VeryLazy",
    -- lazy = true,
    -- dot-repeat support
    dependencies = { "tpope/vim-repeat" },
    -- as soon as the plugin loads, set up all of Leap’s default keybindings:
    config = function() require("plugins.configs.gi_leap_nvim").setup() end,
  },
  {
    "VonHeikemen/fine-cmdline.nvim",
    event = "CmdwinEnter",
    cmd = "FineTerm",
    config = function() require("plugins.configs.gi_fine_cmdline_nvim").config() end,
    dependencies = {
      { "MunifTanjim/nui.nvim" },
    },
  },

  -- Adding symbols outline (similar to vista)
  {
    "simrat39/symbols-outline.nvim",
    cond = false,
    lazy = true,
    event = { "CmdwinEnter" },
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    config = function() require("plugins.configs.gi_symbols_outline").init() end,
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    lazy = true,
    event = "InsertEnter",
    dependencies = { "nvim-treesitter" },
    config = function() require("plugins.configs.gi_nvim_autopairs").setup() end,
  },
  -- Code documentation
  {
    "danymat/neogen",
    lazy = true,
    event = "InsertEnter",
    config = function() require("plugins.configs.gi_neogen").setup() end,
    cmd = { "Neogen" },
  },

  -- ===========================================================================
  --                        DEBUGGER TOOLS
  -- ===========================================================================
  -- Debugging
  --use({ "puremourning/vimspector", event = "BufWinEnter" })
  --Debugging
  -- This plugin adds virtual text support to nvim-dap. nvim-treesitter is used to find variable definitions.
  --It will add variable text value in the debugging session.

  {
    "theHamsta/nvim-dap-virtual-text",
    lazy = true,
    event = "InsertEnter",
    config = function()
      require("nvim-dap-virtual-text").setup {
        enabled = true, -- Enable the plugin
        enabled_commands = true, -- Enable commands like :DapVirtualTextEnable
        highlight_changed_variables = true, -- Highlight changed variables
        show_stop_reason = true, -- Show reason for stopping
        commented = false, -- Prefix virtual text with comment symbol
        display_callback = function(variable, _, _, _) return variable.name .. "  󰞮 󱚟   " .. variable.value end,
        virt_text_pos = "eol", -- Position of virtual text (end of line)
        all_frames = true, -- Show virtual text for all stack frames
        virt_lines = false, -- Use virtual lines instead of virtual text
        virt_text_win_col = nil, -- Override window column for virtual text
      }
      vim.g.dap_virtual_text = true

      -- Refresh virtual text on various DAP events
      local dap = require "dap"
      local nvim_dap_vt = require "nvim-dap-virtual-text"
      dap.listeners.after.event_stopped["dap-virtual-text-refresh"] = function() nvim_dap_vt.refresh() end
      dap.listeners.after.event_continued["dap-virtual-text-refresh"] = function() nvim_dap_vt.refresh() end
      dap.listeners.after.event_terminated["dap-virtual-text-refresh"] = function() nvim_dap_vt.refresh() end
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "mfussenegger/nvim-dap",
    },
  },

  {
    "mfussenegger/nvim-dap",
    -- cond = false,
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
    config = function() require "plugins.configs.dap" end,
  },

  {
    "echasnovski/mini.nvim",
    event = "InsertEnter",
    version = "*",
    config = function()
      -- sa: Add surroding with sa
      -- sd: Replace surrodunding with sr
      -- Find surrounding with sf or SF (move cursor right or left)
      -- Highlight surroding with sh
      require("mini.surround").setup()
    end,
  },

  -- undotree
  {
    "mbbill/undotree",
    event = "VimEnter",
    config = function() require "plugins.configs.gi_undotree" end,
    cmd = { "UndotreeToggle", "UndotreeHide" },
  },

  -- ==========================================================================
  -- 	                    Aesthetic and UI Design
  -- ==========================================================================

  -- Provide a TODO, PERF, HACK, NOTE, NOTE, FIX, WARNING Highlighting
  {
    "folke/todo-comments.nvim",
    event = "BufEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  {
    "stevearc/dressing.nvim",
    cond = false,
    event = { "InsertEnter" },
    config = function()
      require("dressing").setup {
        border = "rounded",
      }
    end,
  },

  {
    "linrongbin16/lsp-progress.nvim",
    event = "LspAttach",
    config = function()
      require("lsp-progress").setup {
        client_format = function(client_name, spinner, series_messages)
          for _, series in ipairs(series_messages) do
            if not series.done then return spinner end
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
    cond = true,
    dependencies = {
      -- { "nvim-treesitter" },
      { "nvim-web-devicons" },
      "linrongbin16/lsp-progress.nvim", -- LSP loading progress
    },
    --event = "VimEnter",
    event = "VeryLazy",
    config = function() require("plugins.configs.gi_lualine_nvim").setup() end,
  },

  -- Buffer line
  {
    "akinsho/nvim-bufferline.lua",
    lazy = true,
    -- event = "BufWritePre",  -- Only will be trigger when you save your buffer.
    --event = "CursorMoved",
    event = "VeryLazy",
    dependencies = "nvim-web-devicons",
    config = function() require("plugins.configs.gi_nvim_bufferline").config() end,
  },

  -- This will  highlight the colors as #558817
  {
    "norcalli/nvim-colorizer.lua",
    event = "InsertEnter",
    lazy = true,
    cmd = { "ColorizerToggle" },
    config = function() require("plugins.configs.others").colorizer() end,
  },

  -- ===========================================================================
  --           PRODUCTIVITIES AND PERFORMANCE
  -- ===========================================================================

  -- Clear highlight when you search for a word automatically
  {
    "romainl/vim-cool",
    lazy = true,
    event = "CmdwinEnter", -- Only will be loaded when we enter the CMD in vim
    config = function() vim.g.CoolTotalMatches = 1 end,
  }, -- Adding acceleration to the mouse for faster/smooth motion

  -- Adding acceleration to the mouse for faster/smooth motion
  -- { "rhysd/accelerated-jk", lazy = true, event = "VeryLazy" },
  -- Deleting a given buffer without affecting

  --{ "famiu/bufdelete.nvim", lazy = true, cmd = { "Bdelete" } },
  { "ojroques/nvim-bufdel", lazy = true, cmd = { "BufDel", "BufDelAll", "BufDelOthers" } },

  { "vim-scripts/ReplaceWithRegister", lazy = true, event = "InsertEnter" },
  -- Better repeat (.) with nvim (from tpope)
  --  use({ "tpope/vim-repeat" })

  -- Better surrounding
  -- { "tpope/vim-surround", lazy = true, event = "InsertEnter" },
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
  --                         FOR EDITOR
  -- ===========================================================================

  -- Allow making tables in Markup-language (*.md) files.
  { "dhruvasagar/vim-table-mode", lazy = true, event = "InsertEnter" },

  -- For latex to preview lively the pdf while editing
  -- use("xuhdev/vim-latex-live-preview")
  {
    "frabjous/knap",
    cond = false,
    lazy = true,
    ft = { "tex" },
    config = function() require "plugins.configs.legacy.myknap" end,
  },

  -- Align easily in nvim
  {
    "Vonr/align.nvim",
    branch = "v2",
    lazy = true,
    event = { "InsertEnter" },
    init = function() require("plugins.configs.gi_align_nvim").config() end,
  },

  --FOLDING THE CODE
  -- Here, the dependencies, statuscol, will remove the numbers 2, 3, 4 ..etc. for the folding level.
  -- The configuration is customized and can be seen at my_ufo.lua

  {
    "kevinhwang91/nvim-ufo",
    --event = "VimEnter",
    cmd = {
      "Command",
      "UfoEnable",
      "UfoDisable",
      "UfoInspect",
      "UfoAttach", -- This will allow to trigger the folding
      "UfoDetach",
      "UfoEnableFold",
      "UfoDisableFold",
    },

    dependencies = {
      "kevinhwang91/promise-async",
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require "statuscol.builtin"
          require("statuscol").setup {
            -- foldfunc = "builtin",
            -- setopt = true,
            relculright = true,
            segments = {
              { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
              { text = { "%s" }, click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          }
        end,
      },
    },
    config = function() require("plugins.configs.gi_nvim_ufo").config() end,
  },

  -- A Neovim (lua) plugin for working with a text-based,
  -- markdown zettelkasten / wiki and mixing it with a journal, based on telescope.nvim.
  {
    "renerocksai/telekasten.nvim",
    cond = false,
    event = "InsertEnter",
    cmd = { "Telekasten" },
    dependencies = {
      "nvim-telescope/telescope.nvim",
      {
        "renerocksai/calendar-vim",
        cmd = { "Calendar" },
      },
    },
    config = function() require("plugins.configs.gi_telekasten_nvim").config() end,
  },

  -- Obsidian.nvim for navigating obsidian notes - intead of telekasten.nvim

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",

    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    --   -- refer to `:h file-pattern` for more examples
    --   "BufReadPre path/to/my-vault/*.md",
    --   "BufNewFile path/to/my-vault/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = "~/Documents/myObsidianDoc",
        },
      },

      -- see below for full list of options 👇
    },
  },

  {
    "junegunn/vim-peekaboo",
    event = "InsertEnter",
  },

  {
    -- Quarto integration for Neovim
    -- GitHub: https://github.com/quarto-dev/quarto-nvim
    "quarto-dev/quarto-nvim",
    ft = "quarto", -- Only load for .qmd files
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("quarto").setup {
        debug = false,
        closePreviewOnExit = true,
        lspFeatures = {
          enabled = true,
          chunks = "curly", -- recognize code blocks like ```{r}
          languages = { "r", "python", "julia", "bash", "html" },
          diagnostics = {
            enabled = true,
            triggers = { "BufWritePost" },
          },
          completion = {
            enabled = true,
          },
        },
        codeRunner = {
          enabled = true,
          default_method = "slime", -- use slime for code sending
          ft_runners = {}, -- custom runner per language, if needed
          never_run = { "yaml" }, -- don’t send these filetypes to runner
        },
      }
    end,
  },

  -- ===========================================================================
  --                        NVIM KEYMAPPING MANAGER
  -- ===========================================================================
  {
    "folke/which-key.nvim",
    cond = true,
    event = "InsertEnter",
    keys = {
      {
        "<leader>?",
        function() require("which-key").show { global = false } end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    config = function() require("plugins.configs.gi_which_key_nvim").config() end,
  }, --

  -- ===========================================================================
  --                            GIT AND DIFF
  -- ===========================================================================
  {
    "APZelos/blamer.nvim",
    event = "InsertEnter",
    config = function() require("plugins.configs.gi_blamer_nvim").BlamerSetting() end,
  },
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    cond = true,
    event = "InsertEnter",
    config = function() require "plugins.configs.gi_gitsigns_nvim" end,
  },
  -- Git Diff
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function() require "plugins.configs.gi_diffview_nvim" end,
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
  },

  -- ==========================================================================
  -- 	                  DATA BASES AND SQL SERVER CONTORLLER
  -- =========================================================================

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    -- :DBCompletionClearCache This plugin caches the
    -- database tables and columns to leverage maximum performance.
    -- If you want to clear the cache at any point just ru
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },

    init = function()
      -- Your DBUI configuration
      require("plugins.configs.gi_vim_dadbod_ui").config()
    end,
  },

  -- ===========================================================================
  --                          OTHER PLUGINS
  -- ===========================================================================

  -- NVIM
  -- plugin for draw ascii digrams intractively.
  -- Ref: https://github.com/jbyuki/venn.nvim?tab=readme-ov-file
  {
    "jbyuki/venn.nvim",
    --"ghasak/venn.nvim",
    event = "InsertEnter",
    lazy = true,
    cmd = { "VBox" },
    config = function() require("plugins.configs.gi_venn_nvim").config() end,
  },

  -- ===========================================================================
  --                         AI DEVELOPEMENT                                  --
  -- ===========================================================================

  -- Models: https://ollama.ai/library
  -- Run in terminal: ollama serve
  -- Currently I'am using zephyr model
  {
    "David-Kunz/gen.nvim",
    event = { "InsertEnter" },
    lazy = true,
    cmd = { "Gen" },
    config = function() require("plugins.configs.gi_gen_nvim").config() end,
  },

  -- Accepting suggestion `Ctrl +x`
  {

    "Exafunction/windsurf.vim",
    -- event = { "InsertEnter" },
    cmd = {
      "Codeium",
      "CodeiumEnable",
      "CodeiumDisable",
      "CodeiumToggle",
      "CodeiumManual",
      "CodeiumChat",
      "CodeiumAuto",

      dependencies = {
        "nvim-lua/plenary.nvim",
        -- "hrsh7th/nvim-cmp",
        "saghen/blink.nvim",
      },
      config = function() require("codeium").setup {} end,
    },
    keys = require("core.keymappings").codeium_keys, -- Access the keys table
  },

  -- CODECOMPANION Activiated and sending queries `Ctrl+s`
  {
    "olimorris/codecompanion.nvim",
    cond = false,
    event = "InsertEnter",
    versions = "17.33.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- Make Ollama the global default
      default_adapter = "ollama",

      -- Only register the Ollama adapter
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            -- point at your local Ollama HTTP API (adjust port if needed)
            url = "http://localhost:11434/v1/chat/completions",
            -- tune your model & context window here
            schema = {
              model = { default = "gemma3:27b" },
              num_ctx = { default = 20000 },
            },
          })
        end,
      },

      -- Force every built-in strategy to use Ollama
      strategies = {
        chat = { adapter = "ollama" },
        inline = {
          adapter = "ollama",
          stream = true, -- token-by-token ghost-text
          chunk_size = 512, -- bytes per read
        },
        code = { adapter = "ollama" },
        -- add more if you later use "workflow", "cmd", etc.
      },
    },
  },

  {
    "yetone/avante.nvim",
    -- event = "VeryLazy",
    event = "InsertEnter",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      provider = "ollama",
      providers = {
        ollama = {
          endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
          model = "gpt-oss:20b", -- "llama3.3:latest",
          -- mode = "agentic", -- use the tool-based planner
          -- you can tweak timeouts, debounce, sidebar position, etc. here
        },
        -- provider = "openai",
        -- openai = {
        --   endpoint = "https://api.openai.com/v1",
        --   model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
        --   timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        --   temperature = 0,
        --   max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --   --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
        -- },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks

      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },

  ---------------- EXPERIMENTING WITH MODERN NEOVIMM PLUGINS -------------------------

  -- Most advanced setup for copilot
  -- (modern lua support similar to tpop plugin which is not used anymore)
  -- Activate: <Ctr+a> in Insert mode
  {
    "zbirenbaum/copilot.lua",
    cond = false,
    cmd = "Copilot",
    event = "InsertEnter",
    keys = require("core.keymappings").copilot_keys,
    config = function()
      -- 1) Your normal setup
      vim.g.copilot_nes_debounce = 500
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

  -- ===========================================================================
  --                        Graphical Tools
  -- ===========================================================================
  {
    "Zeioth/markmap.nvim",
    build = "npm install -g markmap-cli",
    cmd = { "MarkmapOpen", "MarkmapSave", "MarkmapWatch", "MarkmapWatchStop" },
    opts = {
      html_output = "/tmp/markmap.html",
      hide_toolbar = false,
      grace_period = 3600000,
    },
    config = function(_, opts) require("markmap").setup(opts) end,
  },

  ---------------- END OF PLUGINS SETTING -------------------------
}
