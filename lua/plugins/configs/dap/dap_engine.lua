local M = {}

-- ---------------------------------------------------------------------------------
--                          Adapter request settings - python
-- ---------------------------------------------------------------------------------
M.python_debuger_setup = function(dap)
  -- For development to resource your current buffer: require('plenary.reload').reload_module('plugins.configs.dap.dap_engine', true)
  local python_adapters_setting_tbl =
    require("plugins.configs.dap.dap_custom_languages_settings.dap_python_settings").dap_adapters_python_fn()
  local dap_configurations_python_tbl =
    require("plugins.configs.dap.dap_custom_languages_settings.dap_python_settings").dap_configurations_python_fn()
  local python_dap_fn = require("plugins.configs.dap.dap_custom_languages_settings.dap_python_settings").python_dap_fn

  local dap_status_ok, _ = pcall(require, "dap")
  if not dap_status_ok then
    vim.notify("dap is not loaded yet ... " .. dap, vim.log.levels.INFO)
    return
  end

  dap.adapters.python = python_adapters_setting_tbl
  dap.configurations.python = dap_configurations_python_tbl
  python_dap_fn()
end

-- ---------------------------------------------------------------------------------
--                          Adapter request settings - Rust
-- ---------------------------------------------------------------------------------

M.rust_debuger_setup = function(dap)
  -- For rust we will use the configurations for alpha2phi
  require("plugins.configs.dap.dap_custom_languages_settings.dap_rust_settings").setup(dap)
end

-- ---------------------------------------------------------------------------------
--                          Adapter request settings -- C/CPP
-- ---------------------------------------------------------------------------------

M.cpp_debuger_setup = function(dap)
  require("plugins.configs.dap.dap_custom_languages_settings.dap_cpp_settings").setup(dap)
  -- Another configurations - desont work
  -- require("plugins.configs.dap.dap_custom_languages_settings.dap_dap_cpp_codelldb").setup(dap)
end

return M
