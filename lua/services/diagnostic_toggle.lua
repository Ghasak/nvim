
local function set_virtual_lines(on, bufnr)
  bufnr = bufnr or 0        -- 0 = current buffer

  -- Try the new scoped form first (works on 0.11+)
  local ok = pcall(vim.diagnostic.config, { virtual_lines = on }, { buffer = bufnr })
  if not ok then
    -- Old Neovim (≤0.10): only global config is possible
    vim.diagnostic.config({ virtual_lines = on })
  end
end

vim.api.nvim_create_user_command("DiagLinesOff", function()
  set_virtual_lines(false, 0)
end, {})

vim.api.nvim_create_user_command("DiagLinesOn", function()
  set_virtual_lines(true, 0)
end, {})
---
