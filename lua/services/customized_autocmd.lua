-- On-Save trigger the notification using snacks
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function(args)
    -- Defer to avoid fast event context issues
    vim.schedule(function()
      local filepath = vim.api.nvim_buf_get_name(args.buf)
      local filename = vim.fn.fnamemodify(filepath, ":t") -- extract filename only

      -- Check if Snacks is available
      local ok = pcall(function()
        Snacks.notify.info("Saved: " .. filename)
      end)

      -- Fallback to vim.notify if Snacks fails
      if not ok then
        vim.notify("Saved: " .. filename, vim.log.levels.INFO)
      end
    end)
  end,
})
