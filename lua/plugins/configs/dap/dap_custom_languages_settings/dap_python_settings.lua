local M = {}

M.dap_adapters_python_fn = function()
    -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    _G.checking_adpater_type = function()
        if (os.getenv("VIRTUAL_ENV") == 1) then
            vim.g.python_custom_command_path =
                string.format("%s/bin/python", os.getenv("VIRTUAL_ENV"))
        else
            vim.g.python_custom_command_path = string.format(
                                                   "%s/opt/anaconda3/bin/python3",
                                                   os.getenv("HOME"))
        end
    end
    checking_adpater_type()
    return {
        type = "executable",
        command = vim.g.python_custom_command_path,
        args = {"-m", "debugpy.adapter"}
    }
end

M.dap_configurations_python_fn = function()
    return {

        {
            -- The first three options are required by nvim-dap
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            pythonPath = function()
                -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                local env_path = string.format("%s/bin/python3",
                                               os.getenv("VIRTUAL_ENV"))
                if vim.fn.executable(env_path) == 1 then
                    vim.pretty_print("We have selected virtualenv python ... ")
                else
                    vim.pretty_print(
                        "We have selected system default python ... ")
                end
                return vim.g.python_custom_command_path
            end
        }
    }
end

-- dap ui
M.python_dap_fn = function()

    -- require("dap-python").setup("/Users/gmbp/opt/anaconda3/bin/python3")
    require("dap-python").setup(vim.g.python_custom_command_path)
    -- require("dap-python").setup()
end

return M
