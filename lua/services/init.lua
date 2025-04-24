local init_modules = {
  "services.diagnostic_toggle",
  "services.customized_autocmd"
}

for _, module in ipairs(init_modules) do
  local ok, err = pcall(require, module)
  if not ok then
    vim.notify("Error loading " .. module .. "\n\n" .. err, vim.log.levels.ERROR)
  end
end
