local init_modules = { "plugins.configs.lsp.lsp_config_settings" }

for _, module in ipairs(init_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    error("Error in loading modules ...< " .. module .. " > " .. "\n\n" .. err)
  end
end
