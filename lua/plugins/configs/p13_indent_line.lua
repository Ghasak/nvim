local M = {}
function M.setup()
  -- extra options
  vim.opt.termguicolors = true
  vim.opt.list = true -- This added a (-) at each word you type in nvim
  -- Define a gray color for the indent line of the current scope
  local gray_highlight = "IblIndentGray"

  local highlight_scope = {
    -- Mixed scoe colored - my preference
    -- "IblIndent", "RainbowYellow", "RainbowBlue", "RainbowOrange",
    -- "RainbowGreen", "RainbowViolet", "RainbowCyan"
    -- If you want only gray scope
    "IblIndent",
    "IblIndent",
    "IblIndent",
    "IblIndent",
    "IblIndent",
    "IblIndent",
    "IblIndent",

    -- If you want a colored scope
    -- "RainbowRed", "RainbowYellow", "RainbowBlue", "RainbowOrange",
    -- "RainbowGreen", "RainbowViolet", "RainbowCyan"
  }
  -- TabLine is so black that will not be shown,
  -- You can select any color, check :Telescope highlights
  local highlight_indent = {
    "TabLine",
    "TabLine",
    "TabLine",
    "TabLine",
    "TabLine",
    "TabLine",
    "TabLine",
  }
  local hooks = require "ibl.hooks"
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  end)

  vim.g.rainbow_delimiters = { highlight = highlight_scope }

  require("ibl").setup {
    indent = { highlight = highlight_indent }, -- , char = "󰇝"
    scope = { enabled = true, highlight = highlight_scope },
    whitespace = { remove_blankline_trail = false },
  }
  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

return M
