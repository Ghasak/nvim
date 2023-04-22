local M = {}

function M.setup(dap)
    -- local dap_install = require "dap-install"
    -- dap_install.config("codelldb", {})

    -- local dap = require "dap"
    local install_root_dir = vim.fn.stdpath "data" .. "/mason"
    local extension_path = install_root_dir .. "/packages/codelldb/extension/"
    local codelldb_path = extension_path .. "adapter/codelldb"

    dap.adapters.lldb = {
        type = 'executable',
        -- command = '/Users/gmbp/.vscode/extensions/vadimcn.vscode-lldb-1.8.1/adapter/codelldb',
        -- command = '/Users/gmbp/.vscode/extensions/ms-vscode.cpptools-1.12.4-darwin-arm64/debugAdapters/bin/OpenDebugAD7'
        -- command = "/Users/gmbp/.vscode/extensions/ms-vscode.cpptools-1.12.4-darwin-arm64/debugAdapters/bin/OpenDebugAD7",
        -- command = "/Users/gmbp/.vscode/extensions/ms-vscode.cpptools-1.12.4-darwin-arm64/debugAdapters/lldb-mi/bin/lldb-mi",
        -- Using brew intstall llvm
        command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
        name = 'lldb'
    }

    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "lldb",
            request = "launch",
            program = function()
                return vim.fn.input('Path to executable: ',
                                    vim.fn.getcwd() .. '/', 'file')
            end,
            cwd = '${workspaceFolder}',
            --     stopAtEntry = true,
            stopOnEntry = true,
            args = {},
            env = function()
                local variables = {}
                for k, v in pairs(vim.fn.environ()) do
                    table.insert(variables, string.format("%s=%s", k, v))
                end
                return variables
            end

        }
    }
end

return M
