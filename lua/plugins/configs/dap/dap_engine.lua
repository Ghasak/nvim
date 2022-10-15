local M = {}

M.configs = function()

  -- ---------------------------------------------------------------------------------
  --        █▀ █ █▀▀ █▄░█ █▀   █▀▀ █▀█ █▄░█ █▀▀ █ █▀▀ █░█ █▀█ ▄▀█ ▀█▀ █ █▀█ █▄░█
  --        ▄█ █ █▄█ █░▀█ ▄█   █▄▄ █▄█ █░▀█ █▀░ █ █▄█ █▄█ █▀▄ █▀█ ░█░ █ █▄█ █░▀█
  -- ---------------------------------------------------------------------------------
  local dap_breakpoint = {

    active = true,
    on_config_done = nil,

    breakpoint = {
      text = "",
      --texthl = "LspDiagnosticsSignError",
      texthl = "DiagnosticSignError",
      linehl = "red",
      numhl = "",
    },
    rejected = {
      text = "",
      --texthl = "LspDiagnosticsSignHint",
      texthl = "DiagnosticSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "",
      -- texthl = "LspDiagnosticsSignInformation",
      -- linehl = "DiagnosticUnderlineInfo",
      -- numhl = "LspDiagnosticsSignInformation",
      texthl = "DiagnosticSignInfo",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "DiagnosticSignInfo",
    },
    logpoint = {
      text = "",
      texthl = "DiagnosticUnderlineInfo",
      linehl = "",
      numhl = "",

    },
    ui = {
      auto_open = true,
    },
  }



  vim.fn.sign_define("DapBreakpoint", dap_breakpoint.breakpoint)
  vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
  vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
  vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)

end

-- ---------------------------------------------------------------------------------
--                          Adapter request settings
-- ---------------------------------------------------------------------------------
M.python_debuger_setup = function()

  -- For development to resource your current buffer: require('plenary.reload').reload_module('plugins.configs.dap.dap_engine', true)
  local python_adapters_setting_tbl   = require("plugins.configs.dap.dap_custom_languages_settings.dap_python_settings")
      .dap_adapters_python_fn()
  local dap_configurations_python_tbl = require("plugins.configs.dap.dap_custom_languages_settings.dap_python_settings")
      .dap_configurations_python_fn()
  local python_dap_ui_fn              = require("plugins.configs.dap.dap_custom_languages_settings.dap_python_settings")
      .python_dap_ui_fn

  local dap_status_ok, dap = pcall(require, "dap")
  if not dap_status_ok then
    vim.notify("dap is not loaded yet ... " .. dap, vim.log.levels.INFO)
    return
  end

  require("dap").set_log_level("INFO")
  dap.defaults.fallback.terminal_win_cmd = "80vsplit new"
  dap.adapters.python = python_adapters_setting_tbl
  dap.configurations.python = dap_configurations_python_tbl
  python_dap_ui_fn(dap)

end








return M
