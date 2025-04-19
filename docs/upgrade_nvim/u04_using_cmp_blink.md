# nvim.blink

- You must add to the `dependencies` of `lspconfig` the `nvim_blink` as show here

```lua

  {
    "neovim/nvim-lspconfig",
    lazy = true,
    event = { "VeryLazy" },
    dependencies = {
      -- { "williamboman/nvim-lsp-installer" }, -- deperated
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { 'saghen/blink.cmp' },
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
  }, -- Adding lsp signature for nvim
```

## nvim.blink & nvim.cmp  config

```lua

local M = {}
-- ===========================================================================
--     4.                Capabilities for the language server
-- ===========================================================================
--
--
-- You must specifiy first the defualt server capabilities

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "blink.cmp")
if not status_cmp_ok then
  return M
end



M.capabilities = require('blink.cmp').get_lsp_capabilities()



vim.lsp.protocol.make_client_capabilities()

-- Add folding capabilities required by ufo.nvim
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
-- Otherwise, add more capabilities to the language server
M.capabilities.textDocument.completion.completionItem.documentationFormat = {
  "markdown",
  "plaintext",
}
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.completion.completionItem.preselectSupport = true
M.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
M.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
M.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
M.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
M.capabilities.textDocument.completion.completionItem.tagSupport = {
  valueSet = { 1 },
}
M.capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentatin", "detail", "additionalTextEdits" },
}
-- capabilities.offsetEncoding = {'utf-8', 'utf-16'}
M.capabilities.offsetEncoding = "utf-8"

M.capabilities = cmp_nvim_lsp.get_lsp_capabilities(M.capabilities)

return M


```

## lazy nvim package installer




```lua

--[[
  🔌 Plugin: blink.nvim
  📦 Repo: https://github.com/saghen/blink.nvim

  📋 Description:
  A modular plugin providing several UI/UX enhancements for Neovim:
  - `chartoggle`: Easily toggle delimiters like `;` or `,` at the end of a line.
  - `indent`: Handles consistent and dynamic indentation display.
  - `tree`: A built-in file tree navigation UI with custom mappings.

  📌 Why Use It:
  Replaces multiple single-purpose plugins (e.g., file tree, end-of-line toggler) with a modern, minimal Lua-native solution.
  Useful for rapid development and project navigation with ergonomic keybindings.
]]

{
  'saghen/blink.nvim',
  build = 'cargo build --release', -- for delimiters
  keys = {
	-- chartoggle
	{
	  '<C-;>',
	  function()
	  	require('blink.chartoggle').toggle_char_eol(';')
	  end,
	  mode = { 'n', 'v' },
	  desc = 'Toggle ; at eol',
	},
	{
	  ',',
	  function()
	  	require('blink.chartoggle').toggle_char_eol(',')
	  end,
	  mode = { 'n', 'v' },
	  desc = 'Toggle , at eol',
	},

	-- tree
	{ '<C-e>', '<cmd>BlinkTree reveal<cr>', desc = 'Reveal current file in tree' },
	{ '<leader>E', '<cmd>BlinkTree toggle<cr>', desc = 'Reveal current file in tree' },
	{ '<leader>e', '<cmd>BlinkTree toggle-focus<cr>', desc = 'Toggle file tree focus' },
  },
  -- all modules handle lazy loading internally
  lazy = false,
  opts = {
    chartoggle = { enabled = true },
    indent = { enabled = true },
    tree = { enabled = true }
  }
},



--[[
  🔌 Plugin: blink.cmp
  📦 Repo: https://github.com/saghen/blink.cmp

  📋 Description:
  A modern UI layer and fuzzy matching engine for `nvim-cmp` completion. It integrates:
  - A Rust-powered fuzzy matcher for fast and typo-tolerant completion.
  - A consistent, VSCode-like popup menu interface with icon alignment.
  - Advanced keymaps and behaviors that replicate modern editors.

  📌 Why Use It:
  Replaces the default fuzzy matcher with a faster and more accurate Rust implementation.
  Provides a cleaner, more ergonomic auto-completion UI with built-in support for snippets, LSP, and common sources.

  ⚙️ Note:
  Requires Rust for native builds. Can fall back to Lua if native binaries are unavailable.
]]


{
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = { 'rafamadriz/friendly-snippets' },

  -- use a release tag to download pre-built binaries
  -- version = '1.*',
  version = "v1.1.1", -- Specify the desired tag
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    --
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    --
    -- See :h blink-cmp-config-keymap for defining your own keymap
    keymap = { preset = 'default' },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
      fuzzy = { implementation = "prefer_rust_with_warning" }
  },
  opts_extend = { "sources.default" }
}

```

