local M = {}

M.setup = function()

  -- Use a protected call so we don't error out on first use
  local status_ok, github_theme = pcall(require, "github-theme")
  if not status_ok then
    return
  end
  -- Lua
  github_theme.setup(
    {
      --theme_style = "dimmed", --"dark_default", "dimmed"
      theme_style = "dimmed", --"dark_default", "dimmed"
      -- theme_style = "dark_default", --"dark_default", "dimmed"
      --   comment_style = "NONE",
      keyword_style = "NONE",
      function_style = "bold",
      variable_style = "NONE",
      transparent = true,
      hide_inactive_statusline = true,
      --function_style = "italic",
      --sidebars = { "qf", "vista_kind", "terminal", "packer" },

      -- Change the "hint" color to the "orange" color, and make the "error" color bright red
      -- colors = {
      --   hint   = "orange",
      --   error  = "#ff0000",
      --   magenta= "#DCBDFB",
      --   --black = "#343a43"
      -- },

      -- Overwrite the highlight groups
      overrides = function(c)
        return {
          htmlTag                 = { fg = c.red, bg = "#282c34", sp = c.hint, style = "underline" },
          Visual                  = { fg = "#494949", bg = "#E18CA4", fmt = 'bold' },
          IncSearch               = { bg = '#FFC53A', fg = '#494949', fmt = 'reverse' },
          Search                  = { fg = '#494949', bg = '#DAFF7D', fmt = 'bold' },
          Normal                  = { fg = "#E1E1E5", bg = "#343a43" }, -- backgorund default color
          NormalNC                = { fg = "#E1E1E5", bg = "#343a43" }, -- normal text in non-current windows
          NormalSB                = { fg = "#E1E1E5", bg = "#343a43" }, -- normal text in non-current windows
          TermCursorNC            = { fg = "#E1E1E5", bg = "#343a43" },
          NormalFloat             = { fg = "#E1E1E5", bg = "#343a43" }, -- Normal text in floating windows.
          CursorLine              = { bg = "#343a43" },
          ColorColumn             = { bg = "#3C434B" }, --  color of the ruler on the right of the text.
          FloatBorder             = { fg = "#E1E1E5" },
          -- Telescope
          TelescopeBorder         = { fg = "#E1E1E5" },
          TelescopePromptPrefix   = { fg = "#65A8EC" },
          TelescopeMatching       = { fg = c.syntax.constant, style = 'bold' },
          TelescopeMultiSelection = { fg = c.syntax.comment },
          TelescopeSelection      = { bg = c.bg_visual_selection },
          -- Pmenu components
          Pmenu                   = { fg = c.fg, bg = "#343a43" }, -- Popup menu: normal item.
          --PmenuSel       = { fg = c.pmenu.bg, bg = util.darken(c.bright_blue, 0.75) }, -- Popup menu: selected item.
          --PmenuSbar      = { bg = "#DCBDFB" }, -- Popup menu: scrollbar.
          PmenuThumb              = { bg = "#65A8EC" }, -- Popup menu: Thumb of the scrollbar.

          --iCursor        = { fg = "#E1E1E5", bg = "#343a43" },

          StatusLineTerm              = { fg = "#343a43", bg = "#343a43" },
          StatusLineTermNC            = { fg = "#343a43", bg = "#343a43" },
          SignColumn                  = { fg = '#343a43', bg = '#343a43' }, -- SignColumn control the edge of nvim buffer
          CursorLineNr                = { fg = '#65A8EC', fmt = 'bold' },
          -- Diff configurations
          DiffAdded                   = { fg = '#65A8EC', bg = '#343a43' },
          DiffviewStatusAdded         = { fg = '#65A8EC', bf = '#343a43' },
          DiffviewFilePanelInsertions = { fg = '#65A8EC', bf = '#343a43' },
          DiffviewVertSplit           = { fg = '#65A8EC', bf = '#343a43' },

          Terminal                 = { fg = '#343a43', bg = '#343a43' }, -- terminal color for nvim
          EndOfBuffer              = { fg = '#343a43', bg = '#343a43' }, -- End of buffer color
          VertSplit                = { fg = '#343a43' }, -- terminal color for nvim
          Comment                  = { fg = "#97A7B3" }, -- any comment
          --Comment             = { fg = "#3C434B" }, -- any comment
          -- Tab color
          TabLine                  = { fg = '#343a43', bg = '#343a43' },
          TabLineFill              = { fg = '#343a43', bg = '#343a43' },
          TabLineSel               = { fg = '#343a43', bg = '#343a43' },
          -- nvim-tree
          NvimTreeVertSplit        = { bg = '#343a43' }, -- When you split inside nvim-tree the fg will be activited
          NvimTreeNormal           = { bg = '#343a43', bf = '#343a43' }, -- fg means files names, folder names ..etc.
          NvimTreeEndOfBuffer      = { fg = '#343a43', bg = '#343a43' },
          NvimTreeGitNew           = { fg = '#343a43', bg = '#343a43' }, -- This will change only the the edge of the nvim-tree
          NvimTreeStatusLine       = { fg = '#343a43', bg = '#343a43' },
          NvimTreeStatusLineNC     = { fg = '#343a43', bg = '#343a43' },
          MiniStatuslineDevinfo    = { fg = '#343a43', bg = '#343a43' },
          MiniStatuslineFileinfo   = { fg = '#343a43', bg = '#343a43' },
          MiniStatuslineInactive   = { fg = '#343a43', bg = '#343a43' },
          MiniStatuslineFilename   = { fg = '#343a43', bg = '#343a43' },
          MiniStatuslineModeNormal = { fg = '#343a43', bg = '#343a43' },
          -- Constant
          Number                   = { fg = "#FFC53A" },
          Constant                 = { fg = '#EEEDBF' },
          --Constant            = { fg = '#FFC53A' },
          -- TSnumber            = { fg = "#FFC53A" },
          -- plugins: gitsigns
          GitSignsAdd              = { fg = '#65A8EC' },
          GitSignsAddLn            = { fg = '#65A8EC' },
          GitSignsAddNr            = { fg = '#65A8EC' },

          BufferCurrentMod    = { fg = '#343a43', bg = '#343a43' },
          BufferCurrentSign   = { fg = '#343a43', bg = '#343a43' },
          BufferInactiveMod   = { fg = '#343a43', bg = '#343a43' },
          BufferVisible       = { fg = '#343a43', bg = '#343a43' },
          BufferVisibleMod    = { fg = '#343a43', bg = '#343a43' },
          BufferVisibleIndex  = { fg = '#343a43', bg = '#343a43' },
          BufferVisibleSign   = { fg = '#343a43', bg = '#343a43' },
          BufferVisibleTarget = { fg = '#343a43', bg = '#343a43' },
          -- this will remove the highlight groups
          -- LSP configruations
          --  For the virtual text which is shown next to each code line
          DiagnosticError     = { bg = '#343a43', fg = '#F56476' },
          DiagnosticWarn      = { bg = '#343a43', fg = '#FFD8BE' },
          DiagnosticInfo      = { bg = '#343a43', fg = '#3E78B2' },
          DiagnosticHint      = { bg = '#343a43', fg = '#97A7B3' },
          -- Third-party plugin (fidget: show lsp message at startup of the buffer)
          FidgetTitle         = { fg = '#E18CA4', bg = '#DC6486' },
          TSField             = {

          },

        }
      end
    }
  )


end
return M
