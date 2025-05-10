local M = {}

M.snacks_services = function()
  -- turn off ALL snacks animations globally (fixes blink.cmp border flicker)
  -- turn Snacks off while the cmp menu is open, turn it back on afterward
  -- This autcmd is used instead of : vim.g.snacks_animate = false
  local group = vim.api.nvim_create_augroup("BlinkCmpSnacksToggle", { clear = true })

  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "BlinkCmpMenuOpen",
    callback = function() vim.g.snacks_animate = false end,
  })

  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "BlinkCmpMenuClose",
    callback = function() vim.g.snacks_animate = true end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
      -- Setup some globals for debugging (lazy-loaded)
      _G.dd = function(...) Snacks.debug.inspect(...) end
      _G.bt = function() Snacks.debug.backtrace() end
      vim.print = _G.dd -- Override print to use snacks for `:=` command
      -- Create some toggle mappings
      Snacks.toggle.option("spell", { name = "Spelling" }):map "<leader>us"
      Snacks.toggle.option("wrap", { name = "Wrap" }):map "<leader>uw"
      Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map "<leader>uL"
      Snacks.toggle.diagnostics():map "<leader>ud"
      Snacks.toggle.line_number():map "<leader>ul"
      Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map "<leader>uc"
      Snacks.toggle.treesitter():map "<leader>uT"
      Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map "<leader>ub"
      Snacks.toggle.inlay_hints():map "<leader>uh"
      Snacks.toggle.indent():map "<leader>ug"
      Snacks.toggle.dim():map "<leader>uD"
    end,
  })
end

return M
