local M = {}

M.setup = function()
  -- Lua
  -- Use a protected call so we don't error out on first use
  local status_ok, onedark = pcall(require, "onedark")
  if not status_ok then
    return
  end
  onedark.setup {

    -- Main options --
    style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
    transparent = false, -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
      --comments = 'italic',
      comments = 'none',
      keywords = 'none',
      functions = 'none',
      strings = 'none',
      variables = 'none'
    },

    -- Lualine options --
    lualine = {
      transparent = false, -- lualine center bar transparency
    },

    -- Custom Highlights --
    -- Global colors can be altered to fit the corresponding needs.
    -- Color names can be found here: ~/.local/share/nvim/site/pack/packer/start/onedark.nvim/lua/onedark/palette.lua
    colors = {
      Isbelline           = '#F2EFEA',
      Platinum            = '#E7E5DF',
      bright_orange       = "#ff8800", -- define a new color
      light_orange        = "#FFC53A",
      -- green               = '#C6EBC5',
      --green               = "#9DC0BC",
      --green               = "#B2EDC5",
      --green               = "#81B29A",
      -- green               = "#87BBA2",
      -- green               = "#A29F15",
      -- green               = "#009B72",
      green               = "#B2C9AB", -- Laurel Green
      --green               = "#6A8D73",
      --cyan                = "#2E86AB",
      cyan                = "#56b6c2",
      --orange              = "#e5c07b",
      --blue                = "#2E86AB",
      --yellow              = "#e5c07b",
      --yellow              = "#EEEDBF",
      --green               = '#00ffaa', -- redefine an existing color
      purple              = "#DEC0F1",
      beautiful_black     = '#343a43',
      test                = '#00ffaa',
      light_green         = '#C6EBC5',
      light_Fiery_Rose    = '#F56476',
      -- Cerise              = '#E43F6F',
      Blush               = '#DC6486',
      Charm_Pink          = '#E18CA4',
      Sliver_Pink         = '#CEB4B9',
      Cambridge_blue      = '#92B4A7',
      Granny_Smith_Apple  = '#B2EF9B',
      Another_Light_Green = '#94C9A9',
      Mindaro             = '#DAFF7D',
      Light_Orange        = '#FFC49B',
      Cadet_Blue_Crayola  = '#ADB6C4',
      Davys_Grey          = '#494949',
      Fiery_Rose          = '#FF5D73',
      Old_Rose            = '#C6828B',
      Deep_Dark           = '#24272e',
      Light_Yellow        = '#EEEDBF',
      Crayola             = '#C0DF85',
      TeaGreen            = '#CAE7B9',
      Buff                = '#F3DE8A',
      vivid_Tangerine     = '#EB9486',
      Rhythm              = '#7E7F9A',
      cadet_Grey          = '#97A7B3',
      birght_navy_blue    = '#3E78B2',
      mavue               = '#896279',
      Grey_X11_Grey       = "#C0BABC",
      light_coral         = '#F49390',
      rose_dust           = "#A2666F",
      apricot             = "#FFD8BE",


    }, -- Override the components of the nvim modules
    highlights = {
      -- Common
      Visual = { fg = '$Davys_Grey', bg = '$Charm_Pink', fmt = 'bold' },
      --Normal = { fg = '$beautiful_black', bg = '$beautiful_black' }, -- backgorund default color
      --Normal = { fg = '#C3C3C3', bg = '$beautiful_black' }, -- backgorund default color
      Normal = { fg = '$Platinum', bg = '$beautiful_black' }, -- backgorund default color
      IncSearch = { fg = '$light_orange', bg = '$Davys_Grey', fmt = 'reverse' },
      Search = { fg = '$Davys_Grey', bg = '$Mindaro', fmt = 'bold' },
      CursorLineNr = { fg = '$light_green', fmt = 'bold' },

      Terminal = { fg = '$beautiful_black', bg = '$beautiful_black' }, -- terminal color for nvim
      EndOfBuffer = { fg = '$beautiful_black', bg = '$beautiful_black' }, -- End of buffer color
      StatusLineTermNC    = { fg = '$light_green', bg = '$beautiful_black' },
      VertSplit = { fg = '$light_green', bg = '$beautiful_black' }, -- when using vertical split
      SignColumn = { fg = '$beautiful_black', bg = '$beautiful_black' }, -- SignColumn control the edge of nvim buffer

      DiffAdded = { fg = '$light_green', bg = '$beautiful_black' },
      DiffviewStatusAdded = { fg = '$light_green', bf = '$beautiful_black' },
      DiffviewFilePanelInsertions = { fg = '$light_green', bf = '$beautiful_black' },
      DiffviewVertSplit = { fg = '$light_green', bf = '$beautiful_black' },
      -- Syntax
      String = { fg = '$TeaGreen' }, -- For only string in nvim (will be alter by the tree-sitter
      -- Tab color
      TabLine = { fg = '$beautiful_black', bg = '$beautiful_black' },
      TabLineFill = { fg = '$beautiful_black', bg = '$beautiful_black' },
      TabLineSel = { fg = '$beautiful_black', bg = '$beautiful_black' },

      Constant = { fg = '$Light_Yellow' },
      --StatusLineNC = { fg = '$beautiful_black', bg = '$beautiful_black' },
      -- nvim-tree
      NvimTreeVertSplit = { bg = '$beautiful_black' }, -- When you split inside nvim-tree the fg will be activited
      NvimTreeNormal = { bg = '$beautiful_black', bf = '$beautiful_black' }, -- fg means files names, folder names ..etc.
      NvimTreeEndOfBuffer = { fg = '$light_green', bg = '$beautiful_black' },
      NvimTreeGitNew = { fg = '$light_green', bg = '$beautiful_black' }, -- This will change only the the edge of the nvim-tree

      -- plugins: gitsigns
      GitSignsAdd = { fg = '$light_green' },
      GitSignsAddLn = { fg = '$light_green' },
      GitSignsAddNr = { fg = '$light_green' },

      -- plugins: barbar for bufferline configurations
      -- BufferCurrent = { fmt = "bold" },
      BufferCurrentMod = { fg = '$beautiful_black', bg = '$beautiful_black' },
      BufferCurrentSign = { fg = '$beautiful_black', bg = '$beautiful_black' },
      BufferInactiveMod = { fg = '$beautiful_black', bg = '$beautiful_black' },
      BufferVisible = { fg = '$beautiful_black', bg = '$beautiful_black' },
      BufferVisibleMod = { fg = '$beautiful_black', bg = '$beautiful_black' },
      BufferVisibleIndex = { fg = '$beautiful_black', bg = '$beautiful_black' },
      BufferVisibleSign = { fg = '$beautiful_black', bg = '$beautiful_black' },
      BufferVisibleTarget = { fg = '$beautiful_black', bg = '$beautiful_black' },


      -- LSP configruations
      --  For the virtual text which is shown next to each code line
      DiagnosticVirtualTextError = { bg = '$beautiful_black', fg = '$light_Fiery_Rose' },
      DiagnosticVirtualTextWarn  = { bg = '$beautiful_black', fg = '$apricot' },
      DiagnosticVirtualTextInfo  = { bg = '$beautiful_black', fg = '$birght_navy_blue' },
      DiagnosticVirtualTextHint  = { bg = '$beautiful_black', fg = '$cadet_Grey' },
      -- Color of the line number while there is an error, Info or Hint
      -- DiagnosticLineNrError      = { fg = "$light_Fiery_Rose" },
      -- DiagnosticLineNrWarn       = { fg = "$Light_Yellow" },
      -- DiagnosticLineNrInfo       = { fg = '$blue' },
      -- DiagnosticLineNrHint       = { fg = '$purple' },
      -- LspDiagnosticsSignError    = { bg = '$light_Fiery_Rose', fg = '$light_green' },
      -- Third-party plugin (fidget: show lsp message at startup of the buffer)
      FidgetTitle                = { fg = '$Charm_Pink', bg = '$Blush' },

      -- GGX = {fg = '#EEEDBF'}
      -- StatusLine
      -- StatusLine = { fg = '#DADFF7' ,bg = '#008DD5' },
      -- StatusLineTerm = {},
      -- StatusLineTermNC = { fg = '$beautiful_black' ,bg = '$beautiful_black' },
      -- Nvim-treesitter
      TSString = { fg = '$TeaGreen' }, -- For only string in nvim
      TSConstant = { fg = '$Light_Yellow' },
      -- got appended since the newest update for the tree-sitter
     ['@constant']  = { fg = '$Light_Yellow' }
    }, -- Override highlight groups


    -- Plugins Config --
    diagnostics = {
      darker = true, -- darker colors for diagnostic
      undercurl = true, -- use undercurl instead of underline for diagnostics
      background = false, -- use background color for virtual text
    },
  }
  onedark.load()
end

return M
