local M = {}

function M.setup(dap)
  -- local dap_install = require "dap-install"
  -- dap_install.config("codelldb", {})

  -- local dap = require "dap"
  local install_root_dir = vim.fn.stdpath "data" .. "/mason"
  local extension_path = install_root_dir .. "/packages/codelldb/extension/"
  local codelldb_path = extension_path .. "adapter/codelldb"

  dap.adapters.lldb = {
    type = "executable",
    -- command = '/Users/gmbp/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/adapter/codelldb',
    -- command = '/Users/gmbp/.vscode/extensions/ms-vscode.cpptools-1.12.4-darwin-arm64/debugAdapters/bin/OpenDebugAD7'
    -- command = "/Users/gmbp/.vscode/extensions/ms-vscode.cpptools-1.12.4-darwin-arm64/debugAdapters/bin/OpenDebugAD7",
    -- command = "/Users/gmbp/.vscode/extensions/ms-vscode.cpptools-1.12.4-darwin-arm64/debugAdapters/lldb-mi/bin/lldb-mi",
    -- Using brew intstall llvm
    command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
    name = "lldb",
  }

  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "lldb",
      request = "launch",
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
            return build_dir .. vim.fn.input("Name of the binary in /build/debug/: ", "[default:main]", "file")
          end
        else
          -- Ask user to input the full relative path to the binary
          return vim.fn.input("Full path to executable (relative to root directory): ", vim.fn.getcwd() .. "/", "file")
        end
      end,
      -- program = function()
      --   return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      -- end,
      cwd = "${workspaceFolder}",
      stopAtEntry = true,
      args = {},
      env = function()
        local variables = {}
        for k, v in pairs(vim.fn.environ()) do
          table.insert(variables, string.format("%s=%s", k, v))
        end
        return variables
      end,
    },
  }
end

return M
