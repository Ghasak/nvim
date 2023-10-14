local M = {}

-- ---------------------------------------------------------------------------------
--                          Adapter request settings - python
--                          you will need debugpy adapter to be installed
--                                   pip install debugpy
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
  -- ############################################################################################
  --   ▄█░     TYPE: Command, Adapter: lldb-vscode, Adapter: from binary installed with homebrew.
  --   ░█░     command = "/opt/homebrew/opt/llvm/bin/lldb-vscode",
  --   ▄█▄     Status: Working, selecting binary: automated
  -- ############################################################################################
  --require("plugins.configs.dap.dap_custom_languages_settings.dap_cpp_settings").setup(dap)

  -- ############################################################################################
  --   █▀█      TYPE: Command, Adapter: lldb-vscode, Adapter: built from LLVM-Project
  --   ░▄▀      command = "$HOME/.cpp_debug_adpater/llvm-build/bin/lldb-vscode",
  --   █▄▄      Status: Working, binary selection: automated, bannar = working
  -- ############################################################################################
  --require("plugins.configs.dap.dap_custom_languages_settings.dap_cpp_lldb_vscode").setup(dap)

  -- ############################################################################################
  --   █▀▀█      TYPE: Command, Adapter: lldb-vscode, Adapter: built from LLVM-Project
  --   ░░▀▄      command = "$HOME/.cpp_debug_adpater/llvm-build/bin/lldb-vscode",
  --   █▄▄█      Status: Working, binary selection: automated
  -- ############################################################################################
  -- ############################################################################################
  --  ░█▀█░      TYPE: Server, Adapter: OpenDebugAD7, Adapter: Downloaded Mason cpptools
  --  █▄▄█▄      server = "local OpenDebugAD7 = install_root_dir .. "OpenDebugAD7"
  --  ░░░█░         Status: Working, binary selection: automated
  -- ############################################################################################
  require("plugins.configs.dap.dap_custom_languages_settings.dap_cpp_OpenDebugAD7").setup(dap)

  -- Another configurations - desont work
  -- require("plugins.configs.dap.dap_custom_languages_settings.dap_dap_cpp_codelldb").setup(dap)
end

return M
