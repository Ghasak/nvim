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

  dap.adapters["codelldb"] = {
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
        local basename = nil
        local binary_selected = nil
        -- Check if /build/debug/ directory exists
        if vim.fn.isdirectory(build_dir) == 1 then
          -- If "main" binary exists in /build/debug/, use it as default
          if vim.fn.filereadable(default_binary) == 1 then
            vim.notify("Loaded binary: main", vim.log.INFO)
            return "${workspaceFolder}/target/debug/main"
          else
            ------------------------------------------------------------
            -- Ask user to input the binary name within /build/debug/
            -- Fancy coloring in the cmdline
            ------------------------------------------------------------

            local files = vim.fn.split(vim.fn.globpath(build_dir, "*"), "\n")
            local exclude_names = { "build", "deps", "examples", "incremental" }
            for idx, item in ipairs(files) do
              basename = vim.fn.fnamemodify(item, ":t") -- Extract the base name from the path

              -- Check if basename is in exclude_names
              local should_exclude = false
              for _, name in ipairs(exclude_names) do
                if basename == name then
                  should_exclude = true
                  break
                end
              end

              if not should_exclude and basename:match "%.d$" then
                should_exclude = true
              end
              if not should_exclude then
                binary_selected = basename
                local message = string.format(
                  "echohl WarningMsg | echon '[%s]'| echohl CursorLineNr | echon ' Running Binary: ' | echohl ErrorMsg | echon ' -> '| echohl Debug '%s' | echohl  CursorLineNr | echon '%s' | echohl None",
                  idx,
                  "Running binary",
                  basename
                )
                vim.cmd(message)
                vim.cmd "echo ''" -- Adds a newline after each message
              end
            end
            return build_dir .. binary_selected
          end
          return vim.fn.input("Selected binary: [default_binary:main]: ", build_dir)
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
