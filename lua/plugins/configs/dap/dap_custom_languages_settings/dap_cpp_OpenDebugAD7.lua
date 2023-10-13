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
      program = "${workspaceFolder}/build/debug/main",
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

  dap.configurations.c = dap.configurations.cpp
  -- dap.configurations.rust = dap.configurations.cpp
end

return M
