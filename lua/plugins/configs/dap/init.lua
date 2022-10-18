local init_modules = {
  "plugins.configs.dap.dap_engine",

}

for _, module in ipairs(init_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    error("Error in loading modules ... < " .. module .. " > " .. "\n\nn" .. err)
  end
end

local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end


-- 1. dap_breakpoint [[ setting of the signs of the dap ]]
-- 2. dap_ui_setting [[ setting of the signs of the dap ]]
-- 3. dap_programming setting [[ setting of the signs of the dap ]]
-- 4. dap_keymapping settting [[ setting of the signs of the dap ]]

require("plugins.configs.dap.dap_breakpoint_setting").configs()
require("plugins.configs.dap.dap_ui_setting").dap_ui_setttings_fn(dap, dapui)
require("plugins.configs.dap.dap_engine").python_debuger_setup(dap)
require("plugins.configs.dap.dap_engine").rust_debuger_setup(dap)
require("plugins.configs.dap.dap_engine").cpp_debuger_setup(dap)
require("plugins.configs.dap.dap_keymapping").debugging_key_mapping()
