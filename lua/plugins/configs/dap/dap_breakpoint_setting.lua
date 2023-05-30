M = {}

M.configs = function()

    -- ---------------------------------------------------------------------------------
    --        █▀ █ █▀▀ █▄░█ █▀   █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀ █░█ █▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
    --        ▄█ █ █▄█ █░▀█ ▄█   █▄▄ █▄█ █░▀█ █▀░ █ █▄█ █▄█ █▀▄ █▀█ ░█░ █ █▄█ █░▀█
    -- ---------------------------------------------------------------------------------
    local dap_breakpoint = {

        active = true,
        on_config_done = nil,

        breakpoint = {
            text = " ",
            -- texthl = "LspDiagnosticsSignError",
            texthl = "DiagnosticSignError",
            linehl = "red",
            numhl = ""
        },
        rejected = {
            text = "",
            -- texthl = "LspDiagnosticsSignHint",
            texthl = "DiagnosticSignHint",
            linehl = "",
            numhl = ""
        },
        stopped = {
            text = "",
            -- texthl = "LspDiagnosticsSignInformation",
            -- linehl = "DiagnosticUnderlineInfo",
            -- numhl = "LspDiagnosticsSignInformation",
            texthl = "DiagnosticSignInfo",
            linehl = "DiagnosticUnderlineInfo",
            numhl = "DiagnosticSignInfo"
        },
        logpoint = {
            text = "",
            texthl = "DiagnosticUnderlineInfo",
            linehl = "",
            numhl = ""

        },
        ui = {auto_open = true}
    }

    vim.fn.sign_define("DapBreakpoint", dap_breakpoint.breakpoint)
    vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
    vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
    vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)

end

return M
