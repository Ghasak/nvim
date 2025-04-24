
-- On-Save trigger the notification using snacks
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function(args)
    local filepath = vim.api.nvim_buf_get_name(args.buf)
    local filename = vim.fn.fnamemodify(filepath, ":t") -- extract filename only
    require("snacks").notify.info("Saved: " .. filename)
  end,
})

