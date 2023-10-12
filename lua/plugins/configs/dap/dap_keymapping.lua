local M = {}

M.debugging_key_mapping = function()
  local map = require("core.utils").keymapping
  map("n", "<leader>b", ':lua require"dap".toggle_breakpoint()<CR>')
  map("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
  -- ------------------------- Navigation ------------------
  map("n", "<leader><F1>", ':lua require"dap".step_out()<CR>')
  map("n", "<leader><F2>", ':lua require"dap".step_into()<CR>')
  map("n", "<leader><F3>", ':lua require"dap".step_over()<CR>')
  map("n", "<leader><F4>", ':lua require"dap".continue()<CR>')

  map("n", "<leader>dn", ':lua require"dap".run_to_cursor()<CR>')
  map("n", "<leader>dk", ':lua require"dap".up()<CR>')
  map("n", "<leader>dj", ':lua require"dap".down()<CR>')
  map("n", "<leader>dc", ':lua require"dap".terminate()<CR>')
  map("n", "<leader>dr", ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
  map("n", "<leader>de", ':lua require"dap".set_exception_breakpoints({"all"})<CR>')
  map("n", "<leader>da", ':lua require"debugHelper".attach()<CR>')
  map("n", "<leader>dA", ':lua require"debugHelper".attachToRemote()<CR>')
  map("n", "<leader>di", ':lua require"dap.ui.widgets".hover()<CR>')
  map("n", "<leader>d?", ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>')

  map("n", "<leader>df", ":Telescope dap frames<CR>")
  -- map('n', '<leader>dc', ':Telescope dap commands<CR>')
  map("n", "<leader>dt", ":Telescope dap list_breakpoints<CR>")
end

return M
