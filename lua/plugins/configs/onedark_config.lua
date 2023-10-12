local M = {}

M.setup = function()
  -- Use a protected call so we don't error out on first use
  local status_ok, onedark = pcall(require, "onedark")
  if not status_ok then
    return
  end

  onedark.setup {

    -- Main options --
    style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer'
    -- transparent = false, -- Show/hide background
    transparent = true, -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- toggle theme style ---
    toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
    toggle_style_list = {
      "dark",
      "darker",
      "cool",
      "deep",
      "warm",
      "warmer",
      "light",
    }, -- List of styles to toggle between

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
    code_style = {
      -- comments = 'italic',
      comments = "none",
      keywords = "none",
      functions = "none",
      strings = "none",
      variables = "none",
    },

    -- Lualine options --
    lualine = {
      transparent = false, -- lualine center bar transparency
    },

    -- Custom Highlights --
    -- Global colors can be altered to fit the corresponding needs.
    -- Color names can be found here: ~/.local/share/nvim/site/pack/packer/start/onedark.nvim/lua/onedark/palette.lua
    colors = {
      white = "#adbac7",
      -- black = "#343a43", -- "#343a43",
      black = "#2d333b",
      red = "#f47067",
      cyan = "#f69d50",
      blue = "#6cb6ff",
      purple = "#f47067",
      orange = "#f69d50",
      purple_e = "#dcbdfb",
      cyan_e = "#81cad2",
      -- white               = "#adbac7",
      -- black               = "#22272e", -- "#343a43",
      -- red                 = "#f47067",
      -- cyan                = "#81cad2",
      -- blue                = "#6cb6ff",
      -- purple              = "#dcbdfb",
      -- orange              = "#f69d50",
      Isbelline = "#F2EFEA",
      Platinum = "#E7E5DF",
      bright_orange = "#ff8800", -- define a new color
      light_orange = "#FFC53A",
      -- green               = '#C6EBC5',
      -- green               = "#9DC0BC",
      -- green               = "#B2EDC5",
      -- green               = "#81B29A",
      -- green               = "#87BBA2",
      -- green               = "#A29F15",
      -- green               = "#009B72",
      green = "#B2C9AB", -- Laurel Green
      -- green               = "#6A8D73",
      -- cyan                = "#2E86AB",
      -- cyan                = "#56b6c2",
      -- orange              = "#e5c07b",
      -- blue                = "#2E86AB",
      -- yellow              = "#e5c07b",
      -- yellow              = "#EEEDBF",
      -- green               = '#00ffaa', -- redefine an existing color
      -- purple              = "#DEC0F1",
      beautiful_black = "#343a43",
      test = "#00ffaa",
      light_green = "#C6EBC5",
      light_Fiery_Rose = "#F56476",
      -- Cerise              = '#E43F6F',
      Blush = "#DC6486",
      Charm_Pink = "#E18CA4",
      Sliver_Pink = "#CEB4B9",
      Cambridge_blue = "#92B4A7",
      Granny_Smith_Apple = "#B2EF9B",
      Another_Light_Green = "#94C9A9",
      Mindaro = "#DAFF7D",
      Light_Orange = "#FFC49B",
      Cadet_Blue_Crayola = "#ADB6C4",
      Davys_Grey = "#494949",
      Fiery_Rose = "#FF5D73",
      Old_Rose = "#C6828B",
      Deep_Dark = "#24272e",
      Light_Yellow = "#EEEDBF",
      Crayola = "#C0DF85",
      TeaGreen = "#CAE7B9",
      Buff = "#F3DE8A",
      vivid_Tangerine = "#EB9486",
      Rhythm = "#7E7F9A",
      cadet_Grey = "#97A7B3",
      birght_navy_blue = "#3E78B2",
      mavue = "#896279",
      Grey_X11_Grey = "#C0BABC",
      light_coral = "#F49390",
      rose_dust = "#A2666F",
      apricot = "#FFD8BE",
      -- GitHub Theme Colors
      GORANGE = "#F69D50",
      GRED = "#F47267",
      GPURPPLE = "#DCBDFB",
      GBLUE = "#65A8EC",
      GBLUE_STRING = "#93CCFA",
    }, -- Override the components of the nvim modules
    highlights = {
      -- Common
      Normal = { fg = "$white", bg = "$black" }, -- backgorund default color
      Normalrc = { fg = "$white", bg = "$black" }, -- backgorund default color                                                <-
      Visual = { fg = "$Davys_Grey", bg = "$Charm_Pink", fmt = "bold" },
      CursorLine = { bg = "$black" },
      ColorColumn = { bg = "$black" }, --  color of the ruler on the right of the text.

      IncSearch = {
        fg = "$black",
        bg = "$Charm_Pink",
        fmt = "bold",
        -- fmt = "reverse",
      },
      Search = { fg = "$Davys_Grey", bg = "$TeaGreen", fmt = "bold" },
      CursorLineNr = { fg = "#65A8EC", fmt = "bold" },
      -- For highlighting the yanked selected letters, words, lines
      TextYankPost_style = {
        fg = "$black",
        bg = "$light_orange",
        fmt = "bold",
      },
      -- Terminal Highlighting
      Terminal = { fg = "$black", bg = "$black" }, -- terminal color for nvim                                                 <-
      Floaterm = { fg = "$black", bg = "$black" }, -- terminal color for nvim
      EndOfBuffer = { fg = "$black", bg = "$black" }, -- End of buffer color
      StatusLineTermNC = { fg = "$black", bg = "$black" },
      StatusLineTerm = { fg = "$black", bg = "$black" },
      VertSplit = { fg = "$blue", bg = "$black" }, -- when using vertical split                                               <-
      SignColumn = { fg = "$black", bg = "$black" }, -- SignColumn control the edge of nvim buffer

      DiffAdded = { fg = "$red", bg = "$black" },
      DiffviewStatusAdded = { fg = "$light_green", bf = "$black" },
      DiffviewFilePanelInsertions = { fg = "$light_green", bf = "$black" },
      DiffviewVertSplit = { fg = "$light_green", bf = "$black" },
      -- Syntax
      String = { fg = "$GBLUE_STRING" }, -- For only string in nvim (will be alter by the tree-sitter
      -- Tab color
      TabLine = { fg = "$white", bg = "$black" },
      BufferLineTab = { fg = "$white", bg = "$black" },
      TabLineFill = { fg = "$white", bg = "$black" },
      TabLineSel = { fg = "$white", bg = "$black" },

      Constant = { fg = "$Light_Yellow" },
      Comment = { fg = "#97A7B3" }, -- any comment
      -- StatusLineNC = { fg = '$black', bg = '$black' },
      -- nvim-tree
      NvimTreeVertSplit = { fg = "#adbac7", bg = "$black" }, -- When you split inside nvim-tree the fg will be activited
      NvimTreeImageFile = { fg = "$light_Fiery_Rose", bg = "$black" }, -- When you split inside nvim-tree the fg will be activited
      NvimTreeNormal = { fg = "#adbac7", bg = "$black" }, -- fg means files names, folder names ..etc.
      NvimTreeNormalNC = { fg = "#adbac7", bg = "$black" }, -- fg means files names, folder names ..etc.
      NvimTreeEndOfBuffer = { fg = "#adbac7", bg = "$black" },
      NvimTreeGitNew = { fg = "#adbac7", bg = "$black" }, -- This will change only the the edge of the nvim-tree
      -- Icons
      DevIconGitIgnore = { fg = "$light_orange", bg = "$black" }, --<-
      -- plugins: gitsigns
      GitSignsAdd = { fg = "$blue" },
      GitSignsAddLn = { fg = "$blue" },
      GitSignsAddNr = { fg = "$blue" },

      -- plugins: barbar for bufferline configurations:
      -- BufferCurrent = { fmt = "bold" },
      BufferCurrentMod = { fg = "$black", bg = "$black" },
      BufferCurrentSign = { fg = "$black", bg = "$black" },
      BufferInactiveMod = { fg = "$black", bg = "$black" },
      BufferVisible = { fg = "$black", bg = "$black" },
      BufferVisibleMod = { fg = "$black", bg = "$black" },
      BufferVisibleIndex = { fg = "$black", bg = "$black" },
      BufferVisibleSign = { fg = "$black", bg = "$black" },
      BufferVisibleTarget = { fg = "$black", bg = "$black" },

      -- LSP configruations
      --  For the virtual text which is shown next to each code line
      DiagnosticVirtualTextError = {
        bg = "$black",
        fg = "$light_Fiery_Rose",
      },
      DiagnosticVirtualTextWarn = { bg = "$black", fg = "$apricot" },
      DiagnosticVirtualTextInfo = {
        bg = "$black",
        fg = "$birght_navy_blue",
      },
      DiagnosticVirtualTextHint = { bg = "$black", fg = "$cadet_Grey" },

      -- LSP for virutalText
      DiagnosticError = { bg = "$black", fg = "#F56476" },
      DiagnosticWarn = { bg = "$black", fg = "#FFD8BE" },
      DiagnosticInfo = { bg = "$black", fg = "#3E78B2" },
      DiagnosticHint = { bg = "$black", fg = "#97A7B3" },
      -- Color of the line number while there is an error, Info or Hint
      -- DiagnosticLineNrError      = { fg = "$light_Fiery_Rose" },
      -- DiagnosticLineNrWarn       = { fg = "$Light_Yellow" },
      -- DiagnosticLineNrInfo       = { fg = '$blue' },
      -- DiagnosticLineNrHint       = { fg = '$purple' },
      -- LspDiagnosticsSignError    = { bg = '$light_Fiery_Rose', fg = '$light_green' },
      -- Third-party plugin (fidget: show lsp message at startup of the buffer)
      FidgetTitle = { fg = "$Charm_Pink", bg = "$Blush" },

      -- GGX = {fg = '#EEEDBF'}
      -- StatusLine
      -- StatusLine = { fg = '#DADFF7' ,bg = '#008DD5' },
      -- StatusLineTerm = {},
      -- StatusLineTermNC = { fg = '$black' ,bg = '$black' },
      -- Nvim-treesitter
      -- TSString = { fg = '$GBLUE_STRING' }, -- For only string in nvim (Old format)
      ["@String"] = { fg = "#96d0ff" },
      -- TSConstant = { fg = '$Light_Yellow' },
      -- got appended since the newest update for the tree-sitter
      ["@comment"] = { fg = "#768390" },
      -- ["@text"]     = { fg = "#adbac7", },
      ["@method"] = { fg = "$purple_e" },
      ["@function"] = { fg = "$purple_e" },
      ["@function.builtin"] = { fg = "$purple_e" },
      ["@keyword"] = { fg = "$Charm_Pink" },
      ["@boolean"] = { fg = "$blue" },
      ["@property"] = { fg = "$cyan" },
      ["@attribute"] = { fg = "$cyan" },
      ["@symbol"] = { fg = "$purple_e" },
      ["@variable"] = { fg = "$white" },
      ["@field"] = { fg = "$white" },
      ["@variable.builtin"] = { fg = "$white" },
      ["@parameter"] = { fg = "$white" },
      ["@keyword.function"] = { fg = "$white" },
      ["@keyword.return"] = { fg = "$white" },
      ["@function.call"] = { fg = "$purple_e" },
      ["@constant.builtin"] = { fg = "$purple_e" },
      ["@constructor"] = { fg = "$orange" },
      ["@operator"] = { fg = "$blue" },
      ["@number"] = { fg = "$blue" },
      ["@type"] = { fg = "$orange" },
      ["@constant"] = { fg = "$Light_Yellow" },
      -- Pmenu components
      Pmenu = { bg = "$black" }, -- Popup menu: normal item.
      -- PmenuSel       = { fg = c.pmenu.bg, bg = util.darken(c.bright_blue, 0.75) }, -- Popup menu: selected item.
      -- PmenuSbar      = { bg = "#DCBDFB" }, -- Popup menu: scrollbar.
      PmenuThumb = { bg = "#65A8EC" }, -- Popup menu: Thumb of the scrollbar.
      FloatBorder = { fg = "#adbac7", bg = "$black" },

      TelescopeBorder = { fg = "#adbac7" },
      TelescopePromptBorder = { fg = "#adbac7" },
      TelescopeResultsBorder = { fg = "#adbac7" },
      TelescopePreviewBorder = { fg = "#adbac7" },
      TelescopeTitle = { fg = "$red", fmt = "bold" },
      TelescopeMatching = { fg = "$red", fmt = "bold" },
      TelescopePromptPrefix = { fg = "$blue" },
      TelescopeSelection = { fg = "$blue", fmt = "bold" },
      -- TelescopeSelectionCaret = colors.Yellow
      -- Colors for the brackets based on the ts-rainbow plugin
      -- This is the first bracket, parentheses color
      rainbowcol1 = { fg = "$white" },

      IndentBlanklineIndent1 = { fg = "#adbac7", bg = "$black" },
      IndentBlanklineIndent2 = { fg = "#adbac7", bg = "$black" },
      IndentBlanklineIndent3 = { fg = "#adbac7", bg = "$black" },
      IndentBlanklineIndent4 = { fg = "#adbac7", bg = "$black" },
      IndentBlanklineIndent5 = { fg = "#adbac7", bg = "$black" },
      IndentBlanklineIndent6 = { fg = "#adbac7", bg = "$black" },
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
