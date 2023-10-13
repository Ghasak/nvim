-- You have to be aware of the rust debugger binary which is called lldb, this also for c, c++, swift and rust
-- The mason will install the original debugger at the following directory
-- ~/.local/share/nvim/mason/packages/codelldb/extension/lldb/bin
-- which will give us:
-- ╰─ ./lldb --version
-- lldb version 15.0.0-custom
--  rust-enabled
-- Becareful of existence of the lldb in the PATH which is belong to Swift language, check here:
-- lldb is /usr/bin/lldb
-- lldb-1316.0.9.46
-- Apple Swift version 5.6.1 (swiftlang-5.6.0.323.66 clang-1316.0.20.12)
local M = {}

function M.setup(dap)
  -- local dap_install = require "dap-install"
  -- dap_install.config("codelldb", {})

  -- local dap = require "dap"
  local install_root_dir = vim.fn.stdpath "data" .. "/mason"
  local extension_path = install_root_dir .. "/packages/codelldb/extension/"
  local codelldb_path = extension_path .. "adapter/codelldb"

  dap.adapters['codelldb']= {
    type = "server",
    port = "${port}",
    executable = {
      command = codelldb_path,
      args = { "--port", "${port}" },

      -- On windows you may have to uncomment this:
      -- detached = false,
    },
  }
  dap.configurations.rust = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        local build_dir = vim.fn.getcwd() .. "/target/debug/"
        local default_binary = build_dir .. "main"
        -- Check if /build/debug/ directory exists
        if vim.fn.isdirectory(build_dir) == 1 then
          -- If "main" binary exists in /build/debug/, use it as default
          if vim.fn.filereadable(default_binary) == 1 then
            vim.notify("Loaded binary: main", vim.log.INFO)
            return "${workspaceFolder}/target/debug/main"
          else
            -- Ask user to input the binary name within /build/debug/
            local files = vim.fn.split(vim.fn.globpath(build_dir, "*"), "\n")
            for idx, item in ipairs(files) do
              vim.notify(string.format("[%s] -> %s", idx, item))
            end
            return vim.fn.input("Selected binary: [default_binary:main]: ", build_dir)
            ------------------------------------------------------------
          end
        else
          -- Ask user to input the full relative path to the binary
          return vim.fn.input("Full path to executable (relative to root directory): ", vim.fn.getcwd() .. "/", "file")
        end
      end,
      cwd = "${workspaceFolder}",
      -- stopOnEntry = true,
      stopOnEntry = false, -- <- If this is true, the nvim-dap ui will be stop at first lunch.
    },
  }

  dap.configurations.c = dap.configurations.cpp
  -- dap.configurations.rust = dap.configurations.cpp
end

return M
