return {
  {
    "ghasak/githubG.nvim",
    cond = true, -- load this plugin
    priority = 1000, -- make sure to load this before all the other start plugins
    init = function()
      require("onedark").setup { style = "gdark" }
      vim.cmd [[colorscheme onedark]]
    end,
    config = function()
      -- do not remove the colorscheme!
      vim.opt.termguicolors = true
      -- require("plugins.configs.onedark_config").setup()
    end,
  },
  -- ==========================================================================
  -- 	                      Utilities for NVIM IDE Env
  -- ==========================================================================
  { "nvim-lua/popup.nvim", lazy = true }, -- An implementation of the Popup API from vim in Neovim
  { "nvim-lua/plenary.nvim", lazy = true },
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
      require("plugins.configs.treesitter").setup()
    end,
    dependencies = {
      { "p00f/nvim-ts-rainbow", event = "InsertEnter" },
    },
  },
  ----------------------------------------------------------------
  --                  treesitter tools
  --  {all were in the dependencies of nvim-treesitter}
  ----------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    event = "InsertEnter",
  },
  { "windwp/nvim-ts-autotag", event = "InsertEnter" },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "InsertEnter",
  },
  { "RRethy/nvim-treesitter-textsubjects", event = "InsertEnter" },
  {
    -- This plugin is alternative to nvim.context
    "nvim-treesitter/nvim-treesitter-context",
    cond = false, -- Loading the dap, if false it will not be loaded,
    cmd = { "TSContextDisable", "TSContextEnable", "TSContextToggle" },
    event = "InsertEnter",
  },
  ----------------------------------------------------------------

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
    tag = "0.1.4",
    lazy = true,
    event = "VimEnter",
    cmd = "Telescope",
    init = function()
      require("core.utils").load_mappings "telescope"
    end,
    config = function()
      require("plugins.configs.myTelescope").config()
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
      -- Enhance extension that offers intelligent prioritization
      -- when selecting files from your editing history
      -- https://github.com/nvim-telescope/telescope-frecency.nvim
      {
        "nvim-telescope/telescope-frecency.nvim",
        event = "VimEnter",
        config = function()
          require("telescope").load_extension "frecency"
        end,
        dependencies = { "kkharji/sqlite.lua" },
      },
      {
        "gbprod/yanky.nvim",
        event = "VimEnter",
        config = function()
          require("yanky").setup {
            ring = {
              history_length = 100,
              storage = "shada",
              sync_with_numbered_registers = true,
              cancel_event = "update",
              ignore_registers = { "_" },
              update_register_on_cycle = false,
            },
            system_clipboard = {
              sync_with_ring = true,
            },
            picker = {
              select = {
                action = nil, -- nil to use default put action
              },
              telescope = {
                mappings = nil, -- nil to use default mappings
              },
            },
          }
        end,
      },
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
      require "plugins.configs.myNvimTree"
    end,
    cmd = { "NvimTreeToggle", "NvimTreeToggle", "NvimTreeClose" },
  }, -- undotree
  {
    "mbbill/undotree",
    config = function()
      require "plugins.configs.myUndoTreeConfig"
    end,
    cmd = { "UndotreeToggle", "UndotreeHide" },
  }, -- FZF Lua
  {
    "ibhagwan/fzf-lua",
    lazy = true,
    dependencies = { "kyazdani42/nvim-web-devicons" },
    -- event = "BufEnter",
    event = "VimEnter",
    config = function()
      require "plugins.configs.myFzf"
    end,
  }, -- Terminal
  {
    "akinsho/toggleterm.nvim",
    keys = { [[<C-\>]] },
    cmd = { "ToggleTerm", "TermExec" },
    config = function()
      require("plugins.configs.myTerminal").setup()
    end,
  }, -- Using floating terminal
  --{ "voldikss/vim-floaterm", lazy = true, cmd = { "FloatermToggle" } },
  -- Dired.nvim is simialr to Emacs dired for file managment
  {
    "X3eRo0/dired.nvim",
    event = "InsertEnter",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      require("plugins.configs.myDired").config()
    end,
  },

  -- Using Rnvim  <Ranger>
  {
    "kevinhwang91/rnvimr",
    lazy = true,
    cmd = { "RnvimrToggle" },
    config = function()
      require("plugins.configs.myRanger").Style()
    end,
  }, -- will allow to copy and paste in Nvim
  { "christoomey/vim-system-copy", lazy = true, event = "InsertEnter" },
  -- ==========================================================================
  -- 	                      Programming Language Servers
  -- =========================================================================
  -- C/CPP CMake lsp Enhancer
  { "Civitasv/cmake-tools.nvim", ft = { "cpp", "c" }, lazy = true },

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
  }, -- markdown-preview using :markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    --build = "cd app && npm install",
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
    -- config = function()
    --   vim.g.mkdp_filetypes = { "markdown" }
    -- end,
  },
  {
    "mzlogin/vim-markdown-toc",
    ft = { "markdown" },
    lazy = true,
    event = "InsertEnter",

    cmd = { "GenTocGitLab", "GenTocMarked" },
  }, -- Adding notification for nvim
  {
    "folke/neodev.nvim",
    ft = "lua",

    event = "InsertEnter",
  },
  -- lsp_signature.nvim
  {
    "glepnir/lspsaga.nvim",
    -- event = "BufReadPre",
    branch = "main",
    event = "InsertEnter",
    -- ft = {'c', 'cpp', 'lua', 'rust', 'go', 'python', 'bash'},
    -- event = 'LspAttach',
    config = function()
      require("lspsaga").setup(require "plugins.configs.mySaga")
    end,
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" }, -- optional
      { "kyazdani42/nvim-web-devicons" }, -- optional
    },
  }, -- lsp stuff
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
    },
    -- This will be initailized at first
    init = function()
      require("core.utils").lazy_load "nvim-lspconfig"
    end,
    -- Then the configuration will be loaded
    config = function()
      require("plugins.configs.mason_lspconfig_nvim").setup()
    end,
  }, -- Adding lsp signature for nvim
  {
    "ray-x/lsp_signature.nvim",
    event = "InsertEnter",
    dependencies = { "nvim-lspconfig" },
    config = function()
      require("lsp_signature").setup()
    end,
  }, -- Adding symbols outline (similar to vista)
  {
    "simrat39/symbols-outline.nvim",
    lazy = true,
    event = { "CmdwinEnter" },
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    config = function()
      require("plugins.configs.mySymbolsOutline").init()
    end,
  }, -- Auto pairs
  {
    "windwp/nvim-autopairs",
    lazy = true,
    event = "InsertEnter",
    dependencies = { "nvim-treesitter" },
    config = function()
      require("plugins.configs.autopairs").setup()
    end,
  }, -- Code documentation
  {
    "danymat/neogen",
    lazy = true,
    event = "InsertEnter",
    config = function()
      require("plugins.configs.neogen").setup()
    end,
    cmd = { "Neogen" },
  }, -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    lazy = true,
    config = function()
      require("plugins.configs.cmp").setup()
    end,
    dependencies = {
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
      require("plugins.configs.indent_line").setup()
    end,
  }, -- Show documentation window and tracking the Cursor movement
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
  -- Using formatter (instead of null-lsp)
  --{"sbdchd/neoformat", event = "VeryLazy", lazy = true, cmd = "Neoformat"},
  -- none-ls is also not working good, instead
  -- I will using conform
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    config = function()
      require("plugins.configs.myConform").config()
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
  }, -- Navic for winbar, not needed anymore
  -- {
  --     "SmiteshP/nvim-navic", -- We have already this in lsp-saga
  --     event = "VeryLazy",
  --     dependencies = "neovim/nvim-lspconfig"
  -- },
  { "RishabhRD/popfix", event = "InsertEnter" },
  { "RishabhRD/nvim-cheat.sh", event = "InsertEnter" },
  -- ==========================================================================
  -- 	                    Aesthetic and UI Design
  -- ==========================================================================
  -- {
  --     'goolord/alpha-nvim',
  --     --event = "VeryLazy",
  --     config = function()
  --         require'alpha'.setup(require'alpha.themes.dashboard'.config)
  --     end
  -- },

  -- This plugin will show a small window for rename
  -- parameter for examle, and many other parameters.

  {
    "stevearc/dressing.nvim",
    event = { "VeryLazy" },
    config = function()
      require("dressing").setup {
        border = "rounded",
      }
    end,
  },
  {
    "glepnir/dashboard-nvim",
    event = "VimEnter",
    cond = false, -- Don't load this plugin as I will use the default [netrwPlugin]
    config = function()
      require("dashboard").setup(require "plugins.configs.myDashboard")
    end,
    requires = { "nvim-tree/nvim-web-devicons" },
  }, -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { { "nvim-treesitter" }, { "nvim-web-devicons" } },
    --event = "VimEnter",
    event = "VeryLazy",
    config = function()
      require("plugins.configs.myLuaLine").setup()
    end,
  }, -- Buffer line
  {
    "akinsho/nvim-bufferline.lua",
    lazy = true,
    -- event = "BufWritePre",  -- Only will be trigger when you save your buffer.
    --event = "CursorMoved",
    event = "VeryLazy",
    dependencies = "nvim-web-devicons",
    config = function()
      require("plugins.configs.myBufferConfig").config()
    end,
  }, -- This will  highlight the colors as #558817
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    lazy = true,
    cmd = { "ColorizerToggle" },
    config = function()
      require("plugins.configs.others").colorizer()
    end,
  }, -- smooth scroll
  {
    "karb94/neoscroll.nvim",
    event = "VimEnter",
    lazy = true,
    config = function()
      require("plugins.configs.others").neoscroll()
    end,
  }, -- Markdown, Markup-language better view (two plugins)
  {
    -- "npxbr/glow.nvim",
    "ellisonleao/glow.nvim",
    event = "VeryLazy",
    ft = { "markdown" },
    config = function()
      require("plugins.configs.myGlowMark").setup()
    end,
  }, -- vim-eftt (highlight the f/t/F/T mappings)
  -- Source, https://github.com/hrsh7th/vim-eft
  {
    "hrsh7th/vim-eft",
    -- event = "CursorMoved",
    event = "InsertEnter",
    config = function()
      require("plugins.configs.myVim_eft").setup()
    end,
  }, -- lsp loader status display
  -- use({ 'j-hui/fidget.nvim' ,
  -- config = function()
  --     require("fidget").setup({
  --       text = {spinner = "dots_negative", done = "歷"}
  --     })
  --   end})
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
  --           Productivities and performance
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
  { "rhysd/accelerated-jk", lazy = true, event = "VimEnter" },
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
  --                        Debugger Tools
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
        -- display_callback = function(variable, _buf, _stackframe, _node)
        display_callback = function(variable, _, _, _)
          return variable.name .. "  󰞮 󱚟   " .. variable.value
        end,
      }
      vim.g.dap_virtual_text = true
    end,
  },
  {
    "mfussenegger/nvim-dap",
    cond = true, -- Loading the dap, if false it will not be loaded,
    lazy = true,
    event = "InsertEnter",
    -- keys = { [[<leader>d]] },
    dependencies = {
      { "nvim-dap-virtual-text", event = "InsertEnter" },
      { "nvim-dap-ui", event = "InsertEnter" },
      { "nvim-dap-python", event = "InsertEnter" },
      -- {"DAPIkstall.nvim"},
      { "theHamsta/nvim-dap-virtual-text", event = "InsertEnter" },
      { "rcarriga/nvim-dap-ui", event = "InsertEnter" },
      { "mfussenegger/nvim-dap-python", event = "InsertEnter" },
      { "nvim-telescope/telescope-dap.nvim", event = "InsertEnter" },
      --{ "leoluz/nvim-dap-go", event = "InsertEnter" },
      --{ "jbyuki/one-small-step-for-vimkind", event = "InsertEnter" },
    },
    config = function()
      require "plugins.configs.dap"
    end,
  },

  -- ===========================================================================
  --                         For Editor
  -- ===========================================================================
  -- Allow making tables in Markup-language (*.md) files.
  { "dhruvasagar/vim-table-mode", lazy = true, event = "InsertEnter" },
  -- For latex to preview lively the pdf while editing
  -- use("xuhdev/vim-latex-live-preview")
  {
    "frabjous/knap",
    lazy = true,
    ft = { "tex" },
    config = function()
      require "plugins.configs.myknap"
    end,
  },
  -- Align easily in nvim
  {
    "Vonr/align.nvim",
    branch = "v2",
    lazy = true,
    event = { "VeryLazy" },
    init = function()
      require("plugins.configs.myAlign").config()
    end,
  },
  -- Auto-save for nvim, which will save your work triggered on events: "InsertLeave", "TextChanged"
  -- We don't need the auto-saver anymore it seem, that is correct maybe,try this
  -- use({
  --   "Pocco81/auto-save.nvim",
  --   --opt = true,
  --   event = "InsertEnter",
  --   config = function()
  --     require("auto-save").setup {
  --       enabled = false, -- Start auto-save when the plugin is loaded.(default is true)
  --       trigger_events = {"BufLeave"},
  --     }
  --   end,
  -- })
  { "mg979/vim-visual-multi", lazy = true, event = "InsertEnter", branch = "master" },
  -- ===========================================================================
  --                          Other Plugins
  -- ===========================================================================
  {
    "terrortylor/nvim-comment",
    event = "CursorMoved",
    config = function()
      require("nvim_comment").setup()
    end,
  },

  -- ===========================================================================
  --                        Nvim Keymapping Manager
  -- ===========================================================================
  {
    "folke/which-key.nvim",
    event = "InsertEnter",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 2000 -- This will control the which-key popup window interval, default 300,
      require("which-key").setup {
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = " ➜ ", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        },
        popup_mappings = {
          scroll_down = "<c-d>", -- binding to scroll down inside the popup
          scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        window = {
          border = "double", -- none/single/double/shadow
        },
        layout = {
          spacing = 6, -- spacing between columns
        },
        hidden = {
          "<silent>",
          "<cmd>",
          "<Cmd>",
          "<CR>",
          "call",
          "lua",
          "^:",
          "^ ",
        },
        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          i = { "j", "k" },
          v = { "j", "k" },
        },
      }
      require("plugins.configs.which_key_config").config()
    end,
  }, --
  -- ===========================================================================
  --                            Git and Diff
  -- ===========================================================================
  {
    "APZelos/blamer.nvim",
    event = "VimEnter",
    config = function()
      require("plugins.configs.myGitBlamer").BlamerSetting()
    end,
  },
  -- adding (+/-) for diff, in the Gutter      -- Not compatable with the nvim-diagnostics  in nvim 0.6
  -- use({"mhinz/vim-signify"})

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = "InsertEnter",
    config = function()
      require "plugins.configs.myGit"
    end,
  }, -- Git Diff
  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require "plugins.configs.myGitDiff"
    end,
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
  },
  {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    cmd = { "LazyGit" },
    -- optional for floating window border decoration
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
    -- config = function()
    --   require("telescope").load_extension "lazygit"
    -- end,
  },

  -- ===========================================================================
  --                           AI Developement
  -- Models: https://ollama.ai/library
  -- Run in terminal: ollama serve
  -- Currently I'am using zephyr model
  -- ===========================================================================
  {
    "David-Kunz/gen.nvim",
    event = { "InsertEnter" },
    lazy = true,
    cmd = { "Gen" },
    config = function()
      require("plugins.configs.myGenAI").config()
    end,
  },
  -- ===========================================================================
  --                          TMUX [not used for now]
  -- ===========================================================================
  {
    "christoomey/vim-tmux-navigator",
    cond = false, -- Loading the dap, if false it will not be loaded,
    -- It will delete the keymapping (C-\), which affect my floating terminal,
    -- I removed it already
    event = "InsertEnter",
  },
}
