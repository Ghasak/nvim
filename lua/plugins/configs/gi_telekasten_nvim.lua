
local M = {}

M.config = function()
  local status_ok, telekasten = pcall(require, "telekasten")
  if not status_ok then
    return
  end

  telekasten.setup {
    home = vim.fn.expand "~/Documents/myObsidianDoc", -- Put the name of your notes directory here
  }
  vim.cmd [[
          " Example
          hi tkLink ctermfg=lightmagenta cterm=bold,underline guifg=#75ABBC gui=bold,underline
          hi tkTag ctermfg=lightblue cterm=bold,underline  guifg=#E2C2FF gui=bold,underline
          hi tkBrackets ctermfg=gray guifg=gray
      ]]
end

return M
