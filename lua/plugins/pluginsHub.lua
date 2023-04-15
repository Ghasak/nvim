return {
    -- do not remove the colorscheme!
    -- "folke/tokyonight.nvim",
    -- 'navarasu/onedark.nvim'
    -- Onedark theme
    {
        "navarasu/onedark.nvim",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- Lua
            require("plugins.configs.onedark_config").setup()
            -- do not remove the colorscheme!
            vim.opt.termguicolors = true
        end,

        init = function() vim.cmd([[colorscheme onedark]]) end
    },
    -- ==========================================================================
    -- 	                      Utilities for NVIM IDE Env
    -- ==========================================================================
    {"nvim-lua/popup.nvim", lazy = true}, -- An implementation of the Popup API from vim in Neovim
    {"nvim-lua/plenary.nvim", lazy = true},
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
        config = function() require("plugins.configs.treesitter").setup() end,
        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                event = "InsertEnter"
            }, {"windwp/nvim-ts-autotag", event = "InsertEnter"},
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                event = "InsertEnter"
            }, {"p00f/nvim-ts-rainbow", event = "BufReadPre"},
            {"RRethy/nvim-treesitter-textsubjects", event = "InsertEnter"},
            {"nvim-treesitter/nvim-treesitter-context", event = "InsertEnter"}
        }
    }, {"nvim-treesitter/playground", event = "InsertEnter"}, -- Better icons
    {
        "kyazdani42/nvim-web-devicons",
        event = "VimEnter",
        config = function()
            require("nvim-web-devicons").setup({default = true})
        end
    },

    -- ==========================================================================
    -- 	                     Navigation and Explorer
    -- ==========================================================================
    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
        event = "VimEnter",
        cmd = "Telescope",
        init = function() require("core.utils").load_mappings "telescope" end,
        config = function()
            require("plugins.configs.myTelescope").config()
        end

    }, -- nvim-tree
    {
        "kyazdani42/nvim-tree.lua",
        lazy = true,
        dependencies = {"kyazdani42/nvim-web-devicons"},
        cmd = {"NvimTreeToggle", "NvimTreeToggle", "NvimTreeClose"},
        -- module = { "nvim-tree", "nvim-tree.actions.root.change-dir" },
        config = function() require("plugins.configs.myNvimTree") end
    }, -- undotree
    {
        "mbbill/undotree",
        config = function() require("plugins.configs.myUndoTreeConfig") end,
        cmd = {"UndotreeToggle", "UndotreeHide"}
    }, -- FZF Lua
    {
        "ibhagwan/fzf-lua",
        lazy = true,
        dependencies = {"kyazdani42/nvim-web-devicons"},
        -- event = "BufEnter",
        event = "VimEnter",
        config = function() require("plugins.configs.myFzf") end
    }, -- Terminal
    {
        "akinsho/toggleterm.nvim",
        keys = {[[<C-\>]]},
        cmd = {"ToggleTerm", "TermExec"},
        config = function() require("plugins.configs.myTerminal").setup() end
    }, -- Using floating terminal
    {"voldikss/vim-floaterm", lazy = true, cmd = {"FloatermToggle"}},
    -- Using Rnvim  <Ranger>
    {
        "kevinhwang91/rnvimr",
        lazy = true,
        cmd = {"RnvimrToggle"},
        config = function() require("plugins.configs.myRanger").Style() end
    }, -- will allow to copy and paste in Nvim
    {"christoomey/vim-system-copy", lazy = true, event = "InsertEnter"},
    -- ==========================================================================
    -- 	                      Programming Language Servers
    -- =========================================================================
    -- Rust lsp Enhancer
    {"simrat39/rust-tools.nvim", lazy = true, ft = "rust"},
    {"folke/neodev.nvim", ft = "lua", event = "InsertEnter"},
    -- lsp_signature.nvim
    {
        "glepnir/lspsaga.nvim",
        -- event = "BufReadPre",
        branch = "main",
        event = "InsertEnter",
        config = function()
            require("lspsaga").setup(require("plugins.configs.mySaga"))
        end,
        dependencies = {"kyazdani42/nvim-web-devicons"}
    }, -- lsp stuff
    {
        lazy = true,
        event = {"VeryLazy"},
        -- event = {"VimEnter"},
        "williamboman/mason.nvim",
        cmd = {
            "Mason", "MasonInstall", "MasonInstallAll", "MasonUninstall",
            "MasonUninstallAll", "MasonLog"
        },
        init = function() require("mason").setup() end
    }, {
        "neovim/nvim-lspconfig",
        lazy = true,
        event = {"VeryLazy"},
        -- event = {"VimEnter"},
        dependencies = {
            -- { "williamboman/nvim-lsp-installer" }, -- deperated
            {"williamboman/mason.nvim"}, {"williamboman/mason-lspconfig.nvim"},
            {"WhoIsSethDaniel/mason-tool-installer.nvim"}
        },

        -- This will be initailized at first
        init = function()
            require("core.utils").lazy_load "nvim-lspconfig"
        end,
        -- Then the configuration will be loaded
        config = function()
            require("plugins.configs.mason_lspconfig_nvim").setup()
        end

    }, -- Adding lsp signature for nvim
    {
        "ray-x/lsp_signature.nvim",
        dependencies = {"nvim-lspconfig"},
        config = function() require("lsp_signature").setup() end
    }, -- Adding symbols outline (similar to vista)
    {
        "simrat39/symbols-outline.nvim",
        lazy = true,
        event = {"CmdwinEnter"},
        cmd = {"SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose"},
        config = function()
            require("plugins.configs.mySymbolsOutline").init()
        end
    }, -- Auto pairs
    {
        "windwp/nvim-autopairs",
        lazy = true,
        event = "InsertEnter",
        dependencies = {"nvim-treesitter"},
        config = function() require("plugins.configs.autopairs").setup() end
    }, -- Code documentation
    {
        "danymat/neogen",
        lazy = true,
        event = "InsertEnter",
        config = function() require("plugins.configs.neogen").setup() end,
        cmd = {"Neogen"}
    }, -- Completion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        lazy = true,
        config = function() require("plugins.configs.cmp").setup() end,
        dependencies = {
            "hrsh7th/cmp-buffer", "hrsh7th/cmp-path", "hrsh7th/cmp-nvim-lua",
            "ray-x/cmp-treesitter", "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip", "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help", "lukas-reineke/cmp-rg",
            "davidsierradz/cmp-conventionalcommits", "onsails/lspkind-nvim",
            "hrsh7th/cmp-calc", "f3fora/cmp-spell", "hrsh7th/cmp-emoji", {
                "L3MON4D3/LuaSnip",
                dependencies = {"friendly-snippets", "vim-snippets"}
                --    config = function()
                --      require("config.snip").setup()
                --    end,
            }, "rafamadriz/friendly-snippets", "honza/vim-snippets"
            -- { "tzachar/cmp-tabnine", run = "./install.sh", disable = true },
        }
    }, -- use({"onsails/lspkind.nvim", })
    -- TabNine auto-compleletions
    {
        "tzachar/cmp-tabnine",
        lazy = true,
        event = "InsertEnter",
        build = "./install.sh",
        requires = {"hrsh7th/nvim-cmp", "cmp-buffer"}
    }, -- Indent
    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = true,
        event = "InsertEnter",
        config = function()
            require("plugins.configs.indent_line").setup()
        end
    }, -- Show documentation window and tracking the Cursor movement
    {
        "amrbashir/nvim-docs-view",
        -- opt = true,
        event = "InsertEnter",
        cmd = {"DocsViewToggle"},
        config = function()
            require("docs-view").setup({
                position = "right",
                width = vim.o.columns * 0.35
            })
        end
    }, -- Using formatter (instaed of null-lsp)
    {"sbdchd/neoformat", event = "VeryLazy", lazy = true, cmd = "Neoformat"},
    -- Context.vim: A vim plugin that shows the context of the currently visible buffer context.
    -- It's supposed to work on a wide range of file types, but is probably most suseful when looking at source code files.
    -- https://github.com/wellle/context.vim
    -- ==========================================================================
    -- 	                    Aesthetic and UI Design
    -- ==========================================================================

    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {{"nvim-treesitter"}, {"nvim-web-devicons"}},
        event = "VimEnter",
        config = function() require("plugins.configs.myLuaLine").setup() end
    }, -- Buffer line
    {
        "akinsho/nvim-bufferline.lua",
        lazy = true,
        -- event = "BufWritePre",  -- Only will be trigger when you save your buffer.
        event = "CursorMoved",
        dependencies = "nvim-web-devicons",
        config = function()
            require("plugins.configs.myBufferConfig").config()
        end
    }, -- This will  highlight the colors as #558817
    {
        "norcalli/nvim-colorizer.lua",
        lazy = true,
        cmd = {"ColorizerToggle"},
        config = function() require("plugins.configs.others").colorizer() end
    }, -- smooth scroll
    {
        "karb94/neoscroll.nvim",
        event = "VimEnter",
        lazy = true,
        config = function() require("plugins.configs.others").neoscroll() end
    }, -- Markdown, Markup-language better view (two plugins)
    {
        -- "npxbr/glow.nvim",
        "ellisonleao/glow.nvim",
        ft = {"markdown"},
        config = function() require("plugins.configs.myGlowMark").setup() end
    }, -- vim-eftt (highlight the f/t/F/T mappings)
    -- Source, https://github.com/hrsh7th/vim-eft
    {
        "hrsh7th/vim-eft",
        event = "CursorMoved",
        config = function() require("plugins.configs.myVim_eft").setup() end
    }, -- lsp loader status display
    -- use({ 'j-hui/fidget.nvim' ,
    -- config = function()
    --     require("fidget").setup({
    --       text = {spinner = "dots_negative", done = "歷"}
    --     })
    --   end})
    {"ggandor/lightspeed.nvim", lazy = true, event = "CursorMoved"},
    -- ===========================================================================
    --           Productivities and performance
    -- ===========================================================================

    -- Clear highlight when you search for a word automatically
    {
        "romainl/vim-cool",
        lazy = true,
        event = "CmdwinEnter", -- Only will be loaded when we enter the CMD in vim
        config = function() vim.g.CoolTotalMatches = 1 end
    }, -- Adding acceleration to the mouse for faster/smooth motion
    {"rhysd/accelerated-jk", lazy = true, event = "VimEnter"},
    -- Deleting a given buffer without affecting
    {"famiu/bufdelete.nvim", lazy = true, cmd = {"Bdelete"}},

    {"vim-scripts/ReplaceWithRegister", lazy = true, event = "InsertEnter"},
    -- Better repeat (.) with nvim (from tpope)
    --  use({ "tpope/vim-repeat" })

    -- Better surrounding
    {"tpope/vim-surround", lazy = true, event = "InsertEnter"},

    --  -- Development
    --  use({ "tpope/vim-dispatch" })
    --  use({ "tpope/vim-commentary" })
    --  use({ "tpope/vim-rhubarb", event = "VimEnter" })
    {"tpope/vim-unimpaired", event = "InsertEnter"},
    --  use({ "tpope/vim-vinegar" })
    --  use({ "tpope/vim-sleuth" })
    -- Replace word with register
    {"gennaro-tedesco/nvim-peekup", event = "InsertEnter"},

    -- ===========================================================================
    --                        Debugger Tools
    -- ===========================================================================
    -- Debugging
    -- use({ "puremourning/vimspector", event = "BufWinEnter" })

    -- Debugging
    {
        "mfussenegger/nvim-dap",
        lazy = true,
        event = "InsertEnter",
        -- keys = { [[<leader>d]] },
        module = {"dap"},
        dependencies = {
            {"nvim-dap-virtual-text", "nvim-dap-ui", "nvim-dap-python"},
            {"theHamsta/nvim-dap-virtual-text", event = "InsertEnter"},
            {"rcarriga/nvim-dap-ui", event = "InsertEnter"},
            {"mfussenegger/nvim-dap-python", event = "InsertEnter"},
            {"nvim-telescope/telescope-dap.nvim", event = "InsertEnter"},
            {"leoluz/nvim-dap-go", event = "InsertEnter"},
            {"jbyuki/one-small-step-for-vimkind", event = "InsertEnter"}
        },
        config = function() require("plugins.configs.dap") end
    },

    -- ===========================================================================
    --                         For Editor
    -- ===========================================================================
    -- Allow making tables in Markup-language (*.md) files.
    {"dhruvasagar/vim-table-mode", lazy = true, event = "InsertEnter"},
    -- For latex to preview lively the pdf while editing
    -- use("xuhdev/vim-latex-live-preview")
    {
        "frabjous/knap",
        lazy = true,
        ft = {"tex"},
        config = function() require("plugins.configs.myknap") end
    },
    -- Auto-save for nvim, which will save your work triggered on events: "InsertLeave", "TextChanged"
    -- We don't need the auto-saver anymore it seem, that is correct maybe, that is correct, try this
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
    -- ===========================================================================
    --                          Other Plugins
    -- ===========================================================================
    {
        "terrortylor/nvim-comment",
        event = "CursorMoved",
        config = function() require("nvim_comment").setup() end
    }
}
