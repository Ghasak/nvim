local M = {}

------------------------------------------------------------
-- Function to convert table to string
local function table_to_string(tbl)
  local result = {}
  for k, v in pairs(tbl) do
    table.insert(result, tostring(k) .. ": " .. tostring(v))
  end
  return table.concat(result, "\n")
end


function M.setup(dap)
  dap.adapters["lldb-vscode"] = {
    type = "executable",
    command = vim.loop.os_homedir() .. "/.cpp_debug_adpater/llvm-build/bin/lldb-vscode",
    name = "lldb-vscode",
  }

  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb-vscode",
      --MIDebuggerPath = "/Users/gmbp/.cpp_debug_adpater/lldb-mi/build/src/lldb-mi",
      request = "launch",
      --program = "${workspaceFolder}/build/debug/main", -- Pointing to the binary
      -- -----------------------------------------------------------------
      program = function()
        local build_dir = vim.fn.getcwd() .. "/build/debug/"
        local default_binary = build_dir .. "main"

        -- Check if /build/debug/ directory exists
        if vim.fn.isdirectory(build_dir) == 1 then
          -- If "main" binary exists in /build/debug/, use it as default
          if vim.fn.filereadable(default_binary) == 1 then
            vim.notify("Loaded binary: main", vim.log.INFO)
            return "${workspaceFolder}/build/debug/main"
          else
            -- Ask user to input the binary name within /build/debug/
            local files = vim.fn.split(vim.fn.globpath(build_dir, "*"), "\n")
            for idx, item in ipairs(files) do
              vim.notify(string.format("[%s] -> %s", idx, item))
            end
            ------------------------------------------------------------
            return build_dir .. vim.fn.input "Name of the binary in /build/debug/: "
          end
        else
          -- Ask user to input the full relative path to the binary
          return vim.fn.input("Full path to executable (relative to root directory): ", vim.fn.getcwd() .. "/")
        end
      end,
      -- -----------------------------------------------------------------

      cwd = vim.fn.getcwd(),
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
      env = function()
        local variables = {}
        for k, v in pairs(vim.fn.environ()) do
          table.insert(variables, string.format("%s=%s", k, v))
        end
        return variables
      end,
    },
  }

  dap.set_log_level "DEBUG"
end

return M
