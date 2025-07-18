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
        local binary_selected = nil

        -- Check if target/debug/ directory exists
        if vim.fn.isdirectory(build_dir) == 1 then
          -- If "main" binary exists, use it as default
          if vim.fn.filereadable(default_binary) == 1 then
            vim.notify("Loaded binary: main", vim.log.INFO)
            return "${workspaceFolder}/target/debug/main"
          end

          -- List files in build_dir, excluding certain names
          local files = vim.fn.split(vim.fn.globpath(build_dir, "*"), "\n")
          local exclude_names = { "build", "deps", "examples", "incremental" }
          local valid_binaries = {}

          for _, item in ipairs(files) do
            local basename = vim.fn.fnamemodify(item, ":t")
            local should_exclude = false

            -- Exclude specific directories and .d files
            for _, name in ipairs(exclude_names) do
              if basename == name then
                should_exclude = true
                break
              end
            end
            if not should_exclude and basename:match "%.d$" then should_exclude = true end

            -- If not excluded and executable, add to valid binaries
            if not should_exclude and vim.fn.filereadable(item) == 1 and vim.fn.executable(item) == 1 then
              table.insert(valid_binaries, basename)
            end
          end

          -- If valid binaries are found, select one
          if #valid_binaries > 0 then
            -- Optionally, use vim.ui.select for user selection
            binary_selected = valid_binaries[1] -- Default to first valid binary
            vim.notify("Selected binary: " .. binary_selected, vim.log.INFO)
            return build_dir .. binary_selected
          else
            -- No valid binaries found, prompt user
            vim.notify("No valid binaries found in " .. build_dir, vim.log.WARN)
            return vim.fn.input("Selected binary [default:main]: ", build_dir, "file")
          end
        else
          -- Directory does not exist, prompt user
          vim.notify("Debug directory not found: " .. build_dir, vim.log.ERROR)
          return vim.fn.input("Selected binary [default:main]: ", build_dir, "file")
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
