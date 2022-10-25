-- Load all the sub modules under the core module
-- local core_modules = {
--   "dev.repl_runner"
-- }
--
-- for _, module in ipairs(core_modules) do
--   local status_not_ok, err = pcall(require, module)
--   if status_not_ok == false then
--     error("Error loading " .. module .. "\n\n" .. err)
--   else
--     return
--   end
-- end



--require('plenary.reload').reload_module("dev.repl_runner", true)
require("core.myInspectorFucntions")
---vim.pretty_print(require("dev.repl_runner").setup())
--require("dev.repl_runner").setup()
