-- ~/.config/nvim/lua/services/hide_copilot_on_suggestion.lua
-- Safely hide Copilot suggestions while the Blink completion menu is open.

-- Try to load the module; do nothing if Copilot is not installed or disabled.
local ok, copilot_suggestion = pcall(require, "copilot.suggestion")
if not ok or not copilot_suggestion then
  -- Copilot not available: simply return so no autocommands are created.
  return
end

-- When Blink's completion menu opens, dismiss Copilot's ghost text
vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuOpen",
  callback = function()
    -- Protect against any runtime errors in Copilot
    pcall(function()
      copilot_suggestion.dismiss()
      vim.b.copilot_suggestion_hidden = true
    end)
  end,
})

-- When Blink's completion menu closes, allow Copilot suggestions again
vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuClose",
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})

