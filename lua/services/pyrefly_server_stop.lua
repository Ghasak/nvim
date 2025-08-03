-- this will ensure that there is no more istances of
-- the server will be initilzed
vim.api.nvim_create_autocmd({ "BufDelete", "BufUnload" }, {
  pattern = "*.py",
  callback = function()
    for _, c in ipairs(vim.lsp.get_clients { name = "pyrefly" }) do
      c.stop()
    end
  end,
})
