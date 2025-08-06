-- ╭────────────────────────────────────────────────────────────────────────────╮
-- │ 🔄  Auto‑patch every LSP client with a *method‑style* helper               │
-- │     so you can call `client:supports_method_compat(...)`.                  │
-- ╰────────────────────────────────────────────────────────────────────────────╯
local aug = vim.api.nvim_create_augroup("patch_supports_method", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = aug,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client or client.supports_method_compat then
      return -- already patched (or something went wrong)
    end

    --- Adds `supports_method_compat` **as a real method** on the client
    ---@param self   vim.lsp.Client
    ---@param method vim.lsp.protocol.Method
    ---@param bufnr? integer
    ---@return boolean
    ---@diagnostic disable-next-line: inject-field
    function client:supports_method_compat(method, bufnr)
      if vim.fn.has "nvim-0.11" == 1 then
        -- Nvim 0.11+ new signature
        return self:supports_method(method, bufnr)
      else
        -- Nvim 0.10 and earlier
        ---@diagnostic disable-next-line: param-type-mismatch
        return self.supports_method(self, method, { bufnr = bufnr })
      end
    end
  end,
})

