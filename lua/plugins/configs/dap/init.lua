local init_modules = {
  "plugins.configs.dap.dap_engine",

}

for _, module in ipairs(init_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    error("Error in loading modules ... < " .. module .. " > " .. "\n\nn" .. err)
  end
end

local dap_status_ok, _ = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, _ = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end


require("plugins.configs.dap.dap_engine").configs()
require("plugins.configs.dap.dap_engine").python_debuger_setup()
require("plugins.configs.dap.dap_engine").rust_debuger_setup()
require("plugins.configs.dap.dap_keymapping").debugging_key_mapping()

