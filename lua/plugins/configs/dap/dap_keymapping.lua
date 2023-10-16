---@diagnostic disable: unused-local, unused-function, missing-fields
local M = {}

--[[
    `START_OPEN_DEBUGAD7_SERVER()`
    Purpose:
    --------
    Starts the OpenDebugAD7 server for debugging purposes using specified command-line arguments.
    Description:
    ------------
    This function initializes and starts the OpenDebugAD7 server in the background using Neovim's built-in `jobstart` function.
    The server listens on port `9999` and has response tracing and engine logging enabled.
    If the server exits with an error (non-zero return value), a message is printed to the Neovim command line to notify the user.

    Parameters:
    -----------
    None

    Returns:
    --------
    None

    Notes:
    ------
    - The OpenDebugAD7 binary is expected to be located in the
    - `~/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/` directory.
    - If the server exits with a return value other than `0`, it indicates an error occurred.
]]
_G.START_OPEN_DEBUGAD7_SERVER = function()
  local my_job_id = nil
  local install_root_dir = vim.fn.stdpath "data" .. "/mason/packages/cpptools/extension/debugAdapters/bin/"
  local cmd_OpenDebugAD7 = install_root_dir .. "OpenDebugAD7"
  local args = { "--server=9999", "--trace=response", "--engineLogging" }

  my_job_id = vim.fn.jobstart({ cmd_OpenDebugAD7, unpack(args) }, {
    on_exit = function(j, return_val, event)
      vim.notify(event)
      vim.notify(j)
      if return_val ~= 0 then
        print "OpenDebugAD7 server exited with error!"
      end
    end,
  })
end

-- This will stop the server, but we will not
-- use it as the job ended once we exited the Nvim
local function stop_open_debug_ad7_server()
  if my_job_id and my_job_id > 0 then
    vim.fn.jobstop(my_job_id)
    my_job_id = nil
  end
end

-- Function to cut a string from the first occurrence of a substring to the end
-- If the substring is not found, the entire string is returned.
local function cutStringToEnd(fullString, substring)
    local startPos, endPos = fullString:find(substring)

    if startPos then
        return fullString:sub(startPos)
    else
        return fullString
    end
end
-- Function to cut a string from the beginning to a specified substring
-- If the substring is not found, the entire string is returned.
-- Function to cut a string from the beginning to the end or up to a specified substring
local function cutStringToSubstring(fullString, substring)
  local startPos, endPos

  if substring == "" then
    -- If the substring is an empty string, return an empty string
    return ""
  else
    -- Otherwise, find the position of the specified substring
    startPos, endPos = fullString:find(substring)
  end

  if startPos then
    return fullString:sub(1, startPos - 1)
  else
    return fullString
  end
end

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
      if debugger_name == "codelldb" then
        local fullString = tostring(require("dap").adapters[debugger_name]["executable"]["command"])
        local searchString = "mason"
        local cutString = cutStringToEnd(fullString, searchString)
        messege = string.format(
          "Using deubgging Adapter %s loaded from:\n%s at:\n%s ... ",
          debugger_name,
          cutString, -- Here is the adapter type, codelldb, lldb-vscode,
          os.date "%H:%M:%S"
        )
      elseif debugger_name == "cppdbg" then
        local fullString = tostring(require("dap").adapters[debugger_name]["executable"]["command"])
        local searchString = "mason"
        local cutString = cutStringToEnd(fullString, searchString)
        messege = string.format(
          "Using deubgging Adapter %s loaded from:\n%s at:\n%s ... ",
          debugger_name,
          cutString, -- Here is the adapter type, codelldb, lldb-vscode,
          os.date "%H:%M:%S"
        )
        local run_server_message = string.format(
          "Now, The OpenDebug7A server runs using:\n"
            .. "./OpenDebugAD7 --server=9999 --trace=response --engineLogging\n"
            .. "At Adapter Location in background"
        )
        -- This will start the server automatically ..
        START_OPEN_DEBUGAD7_SERVER()
        notify(run_server_message, vim.log.levels.INFO, { title = " DEBUGING ", duration = 50000 })
      -- Run the server in backgroun Automatically
      else
        messege = string.format(
          "Using deubgging Adapter %s loaded from: %s at\n%s ... ",
          debugger_name,
          ---@diagnostic disable-next-line: undefined-field
          tostring(require("dap").adapters[debugger_name].command), -- Here is the adapter type, codelldb, lldb-vscode,
          os.date "%H:%M:%S"
        )
      end
      notify(messege, vim.log.levels.INFO, { title = " DEBUGING ", duration = 50000 })
    end, function() end)
  end

  -- Display a banner message indicating the Python debug environment being used.
  -- This function creates an asynchronous notification banner that displays the Python
  -- debug environment currently in use, based on the value of `vim.g.python_custom_command_path`.
  -- @return None
  _G.PYTHON_DIR_BANNER_MESSAGE = function()
    require("plugins.configs.dap.dap_custom_languages_settings.dap_python_settings").checking_adpater_type()
    require("dap").toggle_breakpoint()
    local async = require "plenary.async"
    local notify = require("notify").async
    async.run(function()
      -- Create the banner message
      local message = string.format("Using python debugger at:\n%s", vim.g.python_custom_command_path)
      notify(message, vim.log.levels.INFO, { title = " DEBUGGING ", duration = 5000 })
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
  elseif vim.bo.filetype == "python" then
    map("n", "<leader>b", ":lua PYTHON_DIR_BANNER_MESSAGE()<CR>")
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
