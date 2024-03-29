local init_modules = { "plugins.lazyPluginsManager" }

for _, module in ipairs(init_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    error("Error in loading modules ... < " .. module .. " > " .. "\n\nn" .. err)
  end
end
