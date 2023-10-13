local M = {}

M.debugging_key_mapping = function()
  --
  --
  --########################################################################
  --
  --   █▄▄ █▀█ █▀▀ ▄▀█ █▄▀ █▀█ █▀█ █ █▄░█ ▀█▀   █▄▄ ▄▀█ █▄░█ █▄░█ █▀▀ █▀█
  --   █▄█ █▀▄ ██▄ █▀█ █░█ █▀▀ █▄█ █ █░▀█ ░█░   █▄█ █▀█ █░▀█ █░▀█ ██▄ █▀▄
  --
  --    Global function will show a banner once a breakpoint is setted.
  --########################################################################

  _G.set_breakpoint_and_update_global = function(debugger_name)
    -- debugger name can be: debuggy, lldbcode, lldb-vscode, lldb, lldb-mi ..etc.
    -- The debugger here will fetch the name of the field name from the  dap (e.g., dap.adapters["lldb-vscode"].name)
    require("dap").toggle_breakpoint()
    local async = require "plenary.async"
    local notify = require("notify").async
    local messege = nil
    -- vim.notify(file)
    async.run(function()
      if debugger_name == "codelldb" or debugger_name == "cppdbg" then
        messege = string.format(
          "Using deubgging Adapter %s loaded from: %s at\n%s ... ",
          debugger_name,
          tostring(require("dap").adapters[debugger_name]["executable"]["command"]), -- Here is the adapter type, codelldb, lldb-vscode,
          os.date "%H:%M:%S"
        )
      else
        messege = string.format(
          "Using deubgging Adapter %s loaded from: %s at\n%s ... ",
          debugger_name,
          tostring(require("dap").adapters[debugger_name].command), -- Here is the adapter type, codelldb, lldb-vscode,
          os.date "%H:%M:%S"
        )
      end
      notify(messege, vim.log.levels.INFO, { title = " DEBUGING ", duration = 50000 })
    end, function() end)
  end

  --########################################################################
  --                     KEY MAPPING FOR DEBUGGING
  --########################################################################

  local map = require("core.utils").keymapping
  if vim.bo.filetype == "cpp" then
    --map("n", "<leader>b", ":lua set_breakpoint_and_update_global('lldb-vscode')<CR>")
    map("n", "<leader>b", ":lua set_breakpoint_and_update_global('cppdbg')<CR>")
  elseif vim.bo.filetype == "rust" then
    map("n", "<leader>b", ":lua set_breakpoint_and_update_global('codelldb')<CR>")
  else
    map("n", "<leader>b", ':lua require"dap".set_breakpoint()<CR>')
  end
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
  map("n", "<leader><leader>d", ":Telescope dap commands<CR>")
  map("n", "<leader>dt", ":Telescope dap list_breakpoints<CR>")
end

return M
