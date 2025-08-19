--- Configure the Python command path for Neovim based on environment variables.
--
-- This function attempts to determine the Python command path to be used by Neovim.
-- It first checks the output of the `which python` command to find the first available
-- Python option. If a valid Python path is found, it sets `vim.g.python_custom_command_path`
-- to that path. If `which python` does not provide a valid option, it falls back to
-- checking if the `VIRTUAL_ENV` environment variable is set and uses it as a backup option.
-- If neither option is available, it defaults to the Anaconda Python path.
--
-- lua/plugins/configs/dap/dap_custom_languages_settings/dap_python_settings.lua
local M = {}

--------------------------------------------------------------------------------
-- Discover a usable Python interpreter
--------------------------------------------------------------------------------
-- CHANGED: keep original function name for compatibility, but also provide a
-- correctly-spelled alias below.
M.checking_adpater_type = function()
  -- Try `which python` first
  local handle = io.popen "which python"
  local result = handle and handle:read "*a" or ""
  if handle then handle:close() end
  local python_path = result and result:gsub("%s+", "") or ""

  -- Prefer VIRTUAL_ENV if present
  if os.getenv "VIRTUAL_ENV" ~= nil then
    vim.g.python_custom_command_path = string.format("%s/bin/python", os.getenv "VIRTUAL_ENV")
  elseif vim.fn.executable ".venv/bin/python" == 1 then
    -- CHANGED: also prefer project-local .venv if it exists
    vim.g.python_custom_command_path = ".venv/bin/python"
  elseif python_path ~= "" then
    vim.g.python_custom_command_path = python_path
  else
    -- Fallback (customize if you use conda or pyenv paths)
    vim.g.python_custom_command_path = "python"
  end
end

-- CHANGED: correctly spelled alias; both names work
M.checking_adapter_type = M.checking_adpater_type

--------------------------------------------------------------------------------
-- DAP adapter (debugpy)
--------------------------------------------------------------------------------
M.dap_adapters_python_fn = function()
  -- CHANGED: call the corrected alias to ensure python_custom_command_path is set
  M.checking_adapter_type()

  return {
    type = "executable",
    command = vim.g.python_custom_command_path,
    args = { "-m", "debugpy.adapter" },
  }
end

--------------------------------------------------------------------------------
-- DAP configurations
--------------------------------------------------------------------------------
-- CHANGED: Provide TWO explicit, robust configurations so that either "program"
-- or "module" is ALWAYS set (fixes: “Invalid message: either 'program', 'module',
-- or 'code' must be specified”).
M.dap_configurations_python_fn = function()
  local function resolve_python()
    local ve = os.getenv "VIRTUAL_ENV"
    if ve and vim.fn.executable(ve .. "/bin/python") == 1 then return ve .. "/bin/python" end
    if vim.fn.executable ".venv/bin/python" == 1 then return ".venv/bin/python" end
    return vim.g.python_custom_command_path or "python"
  end

  return {
    -- 1) Run the CURRENT FILE
    {
      type = "python",
      request = "launch",
      name = "Python: Current file",
      program = "${file}", -- ✅ always present
      cwd = "${workspaceFolder}", -- CHANGED: ensure project root
      env = { PYTHONPATH = "${workspaceFolder}" }, -- CHANGED: make `src` importable
      pythonPath = resolve_python, -- CHANGED: more robust resolver
      console = "integratedTerminal",
      justMyCode = true,
    },

    -- 2) Run as MODULE: python -m src.main
    {
      type = "python",
      request = "launch",
      name = "Python: Module src.main",
      module = "src.main", -- ✅ always present
      cwd = "${workspaceFolder}", -- CHANGED
      env = { PYTHONPATH = "${workspaceFolder}" }, -- CHANGED
      pythonPath = resolve_python, -- CHANGED
      console = "integratedTerminal",
      justMyCode = true,
    },
  }
end

--------------------------------------------------------------------------------
-- dap-python helper (optional)
--------------------------------------------------------------------------------
M.python_dap_fn = function()
  -- CHANGED: ensure interpreter is resolved first
  M.checking_adapter_type()
  require("dap-python").setup(vim.g.python_custom_command_path)
end

return M
