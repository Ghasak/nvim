-- ----------------------------------------------------------------------------------------------------------
--
--        █ █▄░█ █▀ █▀█ █▀▀ █▀▀ ▀█▀ █▀█ █▀█   █░█ █▀▀ █░░ █▀█ █▀▀ █▀█   █▀▀ █░█ █▄░█ █▀▀ ▀█▀ █ █▀█ █▄░█ █▀
--        █ █░▀█ ▄█ █▀▀ ██▄ █▄▄ ░█░ █▄█ █▀▄   █▀█ ██▄ █▄▄ █▀▀ ██▄ █▀▄   █▀░ █▄█ █░▀█ █▄▄ ░█░ █ █▄█ █░▀█ ▄█
--
--                  Hint: to make it work use: require("core.myInspectorFucntions")
-- ----------------------------------------------------------------------------------------------------------
-- local ok, plenary_reload = pcall(require, "plenary.reload")
-- if not ok then
--   reloader = require
-- else
--   reloader = plenary_reload.reload_module
-- end

-- This function will be used to inspect the given object in lua
P = function(v)
  --print(vim.inspect(v))
  vim.pretty_print(vim.inspect(v))
  return v
end

-- RELOAD = function(...)
--   return reloader(...)
-- end
--
-- R = function(name)
--   RELOAD(name)
--   return require(name)
-- end


-- This command is created (namely RELOAD) to source current file without any args
vim.api.nvim_create_user_command('RELOAD',
  function()
    vim.pretty_print("Source current file, similar effect if you hit Ctrl + Enter from the mapping above")
    vim.cmd([[source %]])
  end,
  { nargs = 0 }

)

vim.api.nvim_create_user_command('RELOADER',
  function(opts)
    vim.notify("Will load the file you change: " .. "[" .. opts.args .. "]", vim.log.levels.INFO)
    vim.notify(" use :RELOADER file_name <- file_name is your lua file without quotes", vim.log.levels.INFO)
    require('plenary.reload').reload_module(opts.args, true)
  end,
  { nargs = 1 }
)


-- This is a command (namely RELAODED) will be requested in the keybinding down, which is designed to
-- reload the file that being changed, and accept args, of the file name that being changed.
vim.api.nvim_create_user_command('RUNNER',
  function(opts)
    local commandx = string.format(opts.args)
    require('plenary.reload').reload_module(opts.args, true)
    vim.pretty_print(commandx)
    vim.cmd([[:source %]])
  end,
  { nargs = 1 }
)
-- This is the keybinding that will request for you the changed file (file name) which will be passed to the command above.
-- To do: How to make the file persistent
vim.api.nvim_set_keymap('n', '<C-CR>', '', {
  noremap = true,
  callback = function()
    local file_path = vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    -- Getting file name from file-path then remove the extension
    local  file_name = file_path:match("^.+/(.+)$"):match("(.+)%..+$")
    vim.api.nvim_exec(string.format(":RUNNER  %s",file_name), false)
  end,
  desc = 'Prints my current test ... '
})
