local fn = vim.fn
-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = 1
  print "Installing packer close and reopen Neovim..."
end
--vim.cmd [[packadd packer.nvim]]

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- This will set a limit to the maximum jobs in packer to not freeze the packer.sync.
-- Get it as: :lua vim.pretty_print(vim.inspect(vim.g.custom_max_jobs_limit))
-- or: :lua vim.pretty_print(vim.inspect(vim.api.nvim_get_var('custom_max_jobs_limit')))
local max_job_limit = function()
  if vim.fn.has "mac" == 1 then
    vim.g.custom_max_jobs_limit = 50
  else
    vim.g.custom_max_jobs_limit = 100
  end
  return vim.g.custom_max_jobs_limit
end


-- Adding here a autocmd that will sync your packer once you modify this file., and save
-- This will run in nvim 0.8, using the new API,
-- https://www.reddit.com/r/neovim/comments/vqjz87/autorun_packer_sync_but_only_when_my_plugin_list/
local auto_packer_loader_fn = function()
  local group = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
  vim.api.nvim_create_autocmd("BufWritePost", {
    command = "source <afile> | PackerSync",
    pattern = "packerPluginsManager.lua", -- the name of your plugins file
    group = group,
  })
end

auto_packer_loader_fn()

-- Have packer use a popup window
packer.init {
  max_jobs = max_job_limit(), -- This has fixed the freezing windows in nvim when packer sync.
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
    open_cmd = "65vnew \\[packer\\]", -- An optional command to open a window for packer's display
    working_sym = "  ", -- '⟳', -- The symbol for a plugin being installed/updated
    error_sym = "  ", -- '✗', -- The symbol for a plugin with an error in installation/updating
    done_sym = "  ", -- '✓', -- The symbol for a plugin which has completed installation/updating
    removed_sym = "-", -- The symbol for an unused plugin which was removed
    moved_sym = "→", -- The symbol for a plugin which was moved (e.g. from opt to start)
    header_sym = "━", -- The symbol for the header line in packer's display
    show_all_info = true, -- Should packer show all update details automatically?
    prompt_border = "double", -- Border style of prompt popups.
    keybindings = { -- Keybindings for the display window
      quit = "q",
      toggle_info = "<CR>",
      diff = "d",
      prompt_revert = "r"

    },
    git = {
      cmd = "git", -- The base command for git operations
      subcommands = { -- Format strings for git subcommands
        update = "pull --ff-only --progress --rebase=false",
        install = "clone --depth %i --no-single-branch --progress",
        fetch = "fetch --depth 999999 --progress",
        checkout = "checkout %s --",
        update_branch = "merge --ff-only @{u}",
        current_branch = "branch --show-current",
        diff = "log --color=never --pretty=format:FMT --no-show-signature HEAD@{1}...HEAD",
        diff_fmt = "%%h %%s (%%cr)",
        get_rev = "rev-parse --short HEAD",
        get_msg = "log --color=never --pretty=format:FMT --no-show-signature HEAD -n 1",
        submodules = "submodule update --init --recursive --progress"
      },
      depth = 1, -- Git clone depth
      clone_timeout = 60, -- Timeout, in seconds, for git clones
      default_url_format = 'https://github.com/%s' -- Lua format string used for "aaa/bbb" style plugins
    },



  },
  profile = {
    enable = true,
    threshold = 1 -- the amount in ms that a plugin's load time must be over for it to be included in the profile
  }
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use({ "wbthomason/packer.nvim",
    config = function()
      require("core.lazy_load").packer_lazy_load()
    end

  }) -- Have packer manage itself
  -- ==========================================================================
  -- 	                      Utilities for NVIM IDE Env
  -- ==========================================================================
  use({ "lewis6991/impatient.nvim",
    config = function()
      require("plugins.configs.myImpatient").setup()
    end
  })
  use({ "nvim-lua/popup.nvim", opt = true }) -- An implementation of the Popup API from vim in Neovim
  use({ "nvim-lua/plenary.nvim", start = true, module = "plenary" })
  use({ 'navarasu/onedark.nvim',
    config = function()
      -- Lua
      require("plugins.configs.onedark_config").setup()
    end
  })

  -- ==========================================================================
  -- 	                      Core Dependencies and Utilities
  -- ===========================================================================
  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    --opt = true,
    --event = "BufReadPre",
    --event = "VimEnter",
    --event = { "BufRead", "BufNewFile" },
    --run = ":TSUpdate",
    config = function()
      require("plugins.configs.treesitter").setup()
    end,
    requires = {
      { "nvim-treesitter/nvim-treesitter-textobjects", event = "InsertEnter" },
      { "windwp/nvim-ts-autotag", event = "InsertEnter" },
      { "JoosepAlviste/nvim-ts-context-commentstring", event = "InsertEnter" },
      --{ "p00f/nvim-ts-rainbow", event = "BufReadPre" },
      { "p00f/nvim-ts-rainbow", event = "InsertEnter" },
      { "RRethy/nvim-treesitter-textsubjects", event = "InsertEnter" },
      { "nvim-treesitter/nvim-treesitter-context", event = "InsertEnter", disable = false },
    },
  }


  -- Better icons
  use {
    "kyazdani42/nvim-web-devicons",
    module = "nvim-web-devicons",
    event = "VimEnter",
    config = function()
      require("nvim-web-devicons").setup { default = true }
    end,
  }

  -- ==========================================================================
  -- 	                     Navigation and Explorer
  -- ==========================================================================

  use({ "nvim-telescope/telescope.nvim", tag = '0.1.0',
    keys = "<leader>f",
    cmd = "Telescope",
    package = "telescope",
    requires = {
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make", opt = true },
      { 'nvim-telescope/telescope-symbols.nvim', opt = true },
      { "nvim-telescope/telescope-project.nvim", opt = true }
    },
    config = function()
      require "plugins.configs.myTelescope".config()
    end,
  })
  use({ "nvim-telescope/telescope-ui-select.nvim",
    opt = true,
    setup = function()
      vim.ui.select = function(items, opts, on_choice)
        vim.cmd([[
			PackerLoad telescope.nvim
			PackerLoad telescope-ui-select.nvim
			]]    )
        require("telescope").load_extension("ui-select")
        vim.ui.select(items, opts, on_choice)
      end
    end,
  })

  -- nvim-tree
  use {
    "kyazdani42/nvim-tree.lua",
    opt = true,
    wants = "nvim-web-devicons",
    cmd = { "NvimTreeToggle", "NvimTreeToggle", "NvimTreeClose" },
    -- module = { "nvim-tree", "nvim-tree.actions.root.change-dir" },
    config = function() require("plugins.configs.myNvimTree") end

  }
  -- undotree
  use { "mbbill/undotree",
    config = function()
      require("plugins.configs.myUndoTreeConfig")
    end,
    cmd = { "UndotreeToggle", "UndotreeHide" },
  }


  -- FZF Lua
  use {
    "ibhagwan/fzf-lua",
    opt = true,
    wants = "nvim-web-devicons",
    --event = "BufEnter",
    event = "VimEnter",
    config = function() require("plugins.configs.myFzf") end,
    --cmd = {"lua require('fzf-lua').files()"},
    --cmd = {"FzfLua files"},
  }
  -- Terminal
  use {
    "akinsho/toggleterm.nvim",
    keys = { [[<C-\>]] },
    cmd = { "ToggleTerm", "TermExec" },
    module = { "toggleterm", "toggleterm.terminal" },
    config = function()
      require("plugins.configs.myTerminal").setup()
    end,
  }

  -- Using floating terminal
  use({ "voldikss/vim-floaterm",
    opt = true,
    cmd = { "FloatermToggle" },
  })
  -- Using Rnvim  <Ranger>
  use({
    "kevinhwang91/rnvimr",
    opt = true,
    cmd = { "RnvimrToggle" },
    config = function()
      require("plugins.configs.myRanger").Style()
    end
  })
  -- will allow to copy and paste in Nvim
  use({ "christoomey/vim-system-copy",
    opt = true,
    event = "InsertEnter"
  })
  -- ==========================================================================
  -- 	                    Aesthetic and UI Design
  -- ==========================================================================

  -- alpha for welcome message of nvim
  use({
    "goolord/alpha-nvim",
    disable = true,
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.startify").opts)
    end
  })
  -- Status line
  use {
    "nvim-lualine/lualine.nvim",
    after = "nvim-treesitter",
    event = "VimEnter",
    config = function()
      require("plugins.configs.myLuaLine").setup()
    end,
    wants = "nvim-web-devicons",
  }

  -- Buffer line
  use {
    "akinsho/nvim-bufferline.lua",
    opt = true,
    --event = "BufWritePre",  -- Only will be trigger when you save your buffer.
    event = "CursorMoved",
    wants = "nvim-web-devicons",
    config = function()
      require("plugins.configs.myBufferConfig").setup()
    end,
  }

  -- This will  highlight the colors as #558817
  use({
    "norcalli/nvim-colorizer.lua",
    opt = true,
    cmd = { "ColorizerToggle" },
    config = function()
      require("plugins.configs.others").colorizer()
    end
  })

  -- smooth scroll
  use({
    "karb94/neoscroll.nvim",
    event = "VimEnter",
    opt = true,
    config = function()
      require("plugins.configs.others").neoscroll()
    end
  })

  -- Markdown, Markup-language better view (two plugins)
  use({
    -- "npxbr/glow.nvim",
    "ellisonleao/glow.nvim",
    ft = { 'markdown' },
    config = function() require("plugins.configs.myGlowMark").setup() end
  })
  -- vim-eftt (highlight the f/t/F/T mappings)
  -- Source, https://github.com/hrsh7th/vim-eft
  use({
    "hrsh7th/vim-eft",
    event = "CursorMoved",
    config = function()
      require("plugins.configs.myVim_eft").setup()
    end
  })

  -- lsp loader status display
  -- use({ 'j-hui/fidget.nvim' ,
  -- config = function()
  --     require("fidget").setup({
  --       text = {spinner = "dots_negative", done = "歷"}
  --     })
  --   end})
  use({ 'ggandor/lightspeed.nvim',
    opt = true,
    event = "CursorMoved",

  })
  -- ===========================================================================
  --           Productivities and performance
  -- ===========================================================================

  -- Clear highlight when you search for a word automatically
  use({ "romainl/vim-cool",
    opt = true,
    event = "CmdwinEnter", -- Only will be loaded when we enter the CMD in vim
    config = function() vim.g.CoolTotalMatches = 1 end
  })

  -- Adding acceleration to the mouse for faster/smooth motion
  use({ "rhysd/accelerated-jk",
    opt = true,
    event = "VimEnter",
  })
  -- Deleting a given buffer without affecting
  use({ "famiu/bufdelete.nvim",
    opt = true,
    cmd = { "Bdelete" },
  })

  use({ "vim-scripts/ReplaceWithRegister",
    opt = true,
    event = "InsertEnter"
  })
  -- Better repeat (.) with nvim (from tpope)
  --  use({ "tpope/vim-repeat" })

  -- Better surrounding
  use({ "tpope/vim-surround",
    opt = true,
    event = "InsertEnter"
  })

  --  -- Development
  --  use({ "tpope/vim-dispatch" })
  --  use({ "tpope/vim-commentary" })
  --  use({ "tpope/vim-rhubarb", event = "VimEnter" })
  --  use({ "tpope/vim-unimpaired" })
  --  use({ "tpope/vim-vinegar" })
  --  use({ "tpope/vim-sleuth" })
  -- Replace word with register

  use({ "gennaro-tedesco/nvim-peekup",
    event = "InsertEnter",
  })
  -- ===========================================================================
  --                            Git and Diff
  -- ===========================================================================
  use({
    "APZelos/blamer.nvim",
    event = "VimEnter",
    config = function()
      require("plugins.configs.myGitBlamer").BlamerSetting()
    end
  })
  -- adding (+/-) for diff, in the Gutter      -- Not compatable with the nvim-diagnostics  in nvim 0.6
  -- use({"mhinz/vim-signify"})

  -- Git
  use({
    "lewis6991/gitsigns.nvim",
    event = "InsertEnter",
    config = function() require("plugins.configs.myGit") end
  })

  -- Git Diff
  use({
    "sindrets/diffview.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function() require("plugins.configs.myGitDiff") end,
    cmd = {
      "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles",
      "DiffviewFocusFiles"
    }
  })

  -- ==========================================================================
  -- 	                      Programming Language  Services
  -- ==========================================================================
  -- Auto pairs
  use {
    "windwp/nvim-autopairs",
    opt = true,
    event = "InsertEnter",
    wants = "nvim-treesitter",
    module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
    config = function()
      require("plugins.configs.autopairs").setup()
    end,
  }

  -- Code documentation
  use {
    "danymat/neogen",
    config = function()
      require("plugins.configs.neogen").setup()
    end,
    cmd = { "Neogen" },
    module = "neogen",
    disable = false,
  }
  -- Completion
  use {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opt = true,
    config = function()
      require("plugins.configs.cmp").setup()
    end,
    wants = { "LuaSnip", "lspkind-nvim" },
    requires = {
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
        wants = { "friendly-snippets", "vim-snippets" },
        --    config = function()
        --      require("config.snip").setup()
        --    end,
      },
      "rafamadriz/friendly-snippets",
      "honza/vim-snippets",
      --{ "tzachar/cmp-tabnine", run = "./install.sh", disable = true },
    },
  }

  -- use({"onsails/lspkind.nvim", })

  -- TabNine auto-compleletions
  use({
    "tzachar/cmp-tabnine",
    opt = true,
    event = "InsertEnter",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
    after = "cmp-buffer"
  })
  -- Indent
  use({ "lukas-reineke/indent-blankline.nvim",
    opt = true,
    event = "InsertEnter",
    config = function()
      require("plugins.configs.indent_line").setup()
    end,
  })
  -- Show documentation window and tracking the Cursor movement
  use {
    "amrbashir/nvim-docs-view",
    --opt = true,
    event = "InsertEnter",
    cmd = { "DocsViewToggle" },
    config = function()
      require("docs-view").setup {
        position = "right",
        width = vim.o.columns * 0.35
      }
    end
  }
  -- Context.vim: A vim plugin that shows the context of the currently visible buffer context.
  -- It's supposed to work on a wide range of file types, but is probably most suseful when looking at source code files.
  -- https://github.com/wellle/context.vim
  use { 'wellle/context.vim',
    event = 'InsertEnter',
    cmd = {'ContextEnable'}
  }
  -- ==========================================================================
  -- 	                      Programming Language Servers
  -- ==========================================================================
  use({ "folke/neodev.nvim",
    module = "neodev",
    ft = "lua",
    event = "InsertEnter"
  })
  -- lsp_signature.nvim
  use({
    "glepnir/lspsaga.nvim",
    --event = "BufReadPre",
    event = "InsertEnter",
    branch = "main",
    config = function()
      local saga = require("lspsaga")
      saga.init_lsp_saga(
      -- your configuration
        require("plugins.configs.mySaga")
      )
    end,
  })

  -- Adding lsp signature for nvim
  use({
    "ray-x/lsp_signature.nvim",
    after = "nvim-lspconfig",
    config = function() require("lsp_signature").setup() end,
  })

  -- lsp-config
  use({
    "neovim/nvim-lspconfig",
    -- commit = "148c99bd09b44cf3605151a06869f6b4d4c24455",
    opt = true,
    event = { "VimEnter" },
    setup = function()
      require("core.lazy_load").on_file_open "nvim-lspconfig"
    end,
    wants = {
      -- "nvim-lsp-installer",
      "mason.nvim",
      "mason-lspconfig.nvim",
      "mason-tool-installer.nvim",
    },
    requires = {
      --{ "williamboman/nvim-lsp-installer" }, -- deperated
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    },
    -- Notice, that you need to request the nvim-lsp-installer first to make the config works.
    config = function()
      require("plugins.configs.mason_lspconfig_nvim").setup()
    end,
  })
  -- Adding symbols outline (similar to vista)
  use({
    "simrat39/symbols-outline.nvim",
    opt = true,
    event = { "CmdwinEnter" },
    cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
    config = function()
      require("plugins.configs.mySymbolsOutline").init()
    end

  })

  -- ===========================================================================
  --                        Debugger Tools
  -- ===========================================================================
  -- Debugging
  --use({ "puremourning/vimspector", event = "BufWinEnter" })

  -- Debugging
  use {
    "mfussenegger/nvim-dap",
    opt = true,
    event = "InsertEnter",
    -- keys = { [[<leader>d]] },
    module = { "dap" },
    wants = { "nvim-dap-virtual-text", "nvim-dap-ui", "nvim-dap-python" },
    requires = {
      { "theHamsta/nvim-dap-virtual-text", event = "InsertEnter" },
      { "rcarriga/nvim-dap-ui", event = "InsertEnter" },
      { "mfussenegger/nvim-dap-python", event = "InsertEnter" },
      { "nvim-telescope/telescope-dap.nvim", event = "InsertEnter" },
      { "leoluz/nvim-dap-go", module = "dap-go", event = "InsertEnter" },
      { "jbyuki/one-small-step-for-vimkind", module = "osv", event = "InsertEnter" },
    },
    config = function()
      require("plugins.configs.dap")
    end,
    disable = false,
  }
  -- ==========================================================================
  -- 	                      Programming Language Tools
  -- ==========================================================================
  -- Rust lsp Enhancer
  use({ 'simrat39/rust-tools.nvim',
    opt = true,
    ft = "rust"
  })
  use({
    'saecki/crates.nvim',
    opt = true,
    ft = { "rust", "toml" },
    tag = 'v0.3.0',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup({
        popup = {
          border = "rounded",
        }

      })
    end,
  })
  -- Using formatter (instaed of null-lsp)
  use({ "sbdchd/neoformat",
    cmd = "Neoformat",
  })
  -- Navigation for all the coding problems
  use({
    "folke/trouble.nvim",
    cmd = "Trouble",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({
      })
    end
  })

  -- Copilot AI
  -- Technical review of copilot, an AI solution built on top of openAI
  -- Davincie.
  -- use({"github/copilot.vim"})
  -- markdown-preview using :markdown Preview
  use({
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    cmd = "MarkdownPreview",
    run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
  })

  -- Adding notification for nvim
  use({
    "rcarriga/nvim-notify",
    disable = true,
    config = function() require("plugins.configs.myNotify") end
  })

  use({ "SmiteshP/nvim-navic", -- We have already this in lsp-saga
    wants = "neovim/nvim-lspconfig",
    disable = true,
  })
  use({ 'RishabhRD/popfix',
    event = "InsertEnter",
  })
  use({ "RishabhRD/nvim-cheat.sh",
    event = "InsertEnter",

  })
  -- ===========================================================================
  --                         For Editor
  -- ===========================================================================
  -- Allow making tables in Markup-language (*.md) files.
  use({ "dhruvasagar/vim-table-mode",
    event = "InsertEnter"
  })
  -- For latex to preview lively the pdf while editing
  -- use("xuhdev/vim-latex-live-preview")
  use({
    "frabjous/knap",
    ft = { "tex" },
    config = function() require("plugins.configs.myknap") end
  })
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
  use({ "terrortylor/nvim-comment",
    event = "CursorMoved",
    config = function()
      require('nvim_comment').setup()
    end
  })

  -- ==========================================================================
  -- 	            Custom Plugin Development
  -- ==========================================================================
  use({ "/Users/gmbp/Desktop/devCode/plugins/auto.nvim",
    disable = true })
  -- ==========================================================================
  -- 	            PACKER PLUGIN PACKAGE SYNCING AND LOADING
  -- ==========================================================================
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
