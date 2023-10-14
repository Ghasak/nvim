local M = {}

function M.setup(dap)
  -- local dap_install = require "dap-install"
  -- dap_install.config("codelldb", {})
  -- local dap = require "dap"
  local install_root_dir = vim.fn.stdpath "data" .. "/mason/packages/cpptools/extension/debugAdapters/bin/"
  local miDebuggerPath = vim.fn.stdpath "data" .. "/mason/packages/cpptools/extension/debugAdapters/lldb-mi/bin/lldb-mi"
  local OpenDebugAD7 = install_root_dir .. "OpenDebugAD7"

  dap.adapters["cppdbg"] = {
    id = "cppdbg",
    type = "server",
    port = "9999",
    executable = {
      command = OpenDebugAD7,
      args = { "--server", "9999", "--trace", "response", "engineLogging" },
    },
    name = "cppdbg", -- Name can be useful for reference
  }
  dap.configurations.cpp = {
    {
      name = "Launch OpenDebugAD7",
      type = "cppdbg",
      MIMode = "gdb",
      --miDebuggerServerAddress = 'localhost:9999', -- Not working and should be included
      miDebuggerPath = miDebuggerPath,
      request = "launch",
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
            return build_dir .. vim.fn.input "Name of the binary in /build/debug/: "
          end
        else
          -- Ask user to input the full relative path to the binary
          return vim.fn.input("Full path to executable (relative to root directory): ", vim.fn.getcwd() .. "/")
        end
      end,
      -- -----------------------------------------------------------------
      cwd = "${workspaceFolder}",
      setupCommands = {
        {
          text = "-enable-pretty-printing",
          description = "enable pretty printing",
          ignoreFailures = false,
        },
      },
    },
  }

  -- This will allow to write the debugger status into ~/.cache/nvim/dap.log
  dap.set_log_level "DEBUG"
  -- This line will demonstrate that the configuration for C-language is similar to that of C++ for the debugger.
  dap.configurations.c = dap.configurations.cpp
  -- dap.configurations.rust = dap.configurations.cpp
end

return M
