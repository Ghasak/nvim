local M = {}

--- Configure the Python command path for Neovim based on environment variables.
--
-- This function attempts to determine the Python command path to be used by Neovim.
-- It first checks the output of the `which python` command to find the first available
-- Python option. If a valid Python path is found, it sets `vim.g.python_custom_command_path`
-- to that path. If `which python` does not provide a valid option, it falls back to
-- checking if the `VIRTUAL_ENV` environment variable is set and uses it as a backup option.
-- If neither option is available, it defaults to the Anaconda Python path.
--
-- @return None
M.checking_adpater_type = function()
  -- Execute `which python` to obtain Python options
  local handle = io.popen "which python"
  ---@diagnostic disable-next-line: need-check-nil
  local result = handle:read "*a"
  -- Remove trailing newline and whitespace characters from the directory path
  local python_path = string.gsub(result, "%s+", "") -- Removes all whitespace characters
  ---@diagnostic disable-next-line: need-check-nil
  handle:close()
  -- Set Neovim's Python command path to the one obtained from `which python`
  if os.getenv "VIRTUAL_ENV" ~= nil then
    -- Fall back to using VIRTUAL_ENV if set
    vim.g.python_custom_command_path = string.format("%s/bin/python", os.getenv "VIRTUAL_ENV")
  else
    vim.g.python_custom_command_path = python_path
  end
end

M.dap_adapters_python_fn = function()
  require("plugins.configs.dap.dap_custom_languages_settings.dap_python_settings").checking_adpater_type()

  return {
    type = "executable",
    command = vim.g.python_custom_command_path,
    args = { "-m", "debugpy.adapter" },
  }
end

M.dap_configurations_python_fn = function()
  return {

    {
      -- The first three options are required by nvim-dap
      type = "python",
      request = "launch",
      name = "Launch file",
      program = "${file}", -- You can launch with arg as -m src.main (for entire project)
      pythonPath = function()
        -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
        local env_path = string.format("%s/bin/python3", os.getenv "VIRTUAL_ENV")
        if vim.fn.executable(env_path) == 1 then
          vim.print "We have selected virtualenv python ... "
        else
          vim.print "We have selected system default python ... "
        end
        return vim.g.python_custom_command_path
      end,
    },
  }
end

-- dap ui
M.python_dap_fn = function()
  -- require("dap-python").setup("/Users/gmbp/opt/anaconda3/bin/python3")
  require("dap-python").setup(vim.g.python_custom_command_path)
  -- require("dap-python").setup()
end

return M
