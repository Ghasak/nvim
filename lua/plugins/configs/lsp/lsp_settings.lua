local M = {}

-- Step 1: Define diagnostic signs (still valid globally)
M.setup = function()
  local signs = {
    {
      name = "DiagnosticSignError",
      text = "",
      texthl = "DiagnosticSignError",
      numhl = "DiagnosticLineNrError",
    },
    {
      name = "DiagnosticSignWarn",
      text = "",
      texthl = "DiagnosticSignWarn",
      numhl = "DiagnosticLineNrWarn",
    },
    {
      name = "DiagnosticSignHint",
      text = "󰌵",
      texthl = "DiagnosticSignHint",
      numhl = "DiagnosticLineNrHint",
    },
    {
      name = "DiagnosticSignInfo",
      text = "",
      texthl = "DiagnosticSignInfo",
      numhl = "DiagnosticLineNrInfo",
    },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {
      text = sign.text,
      texthl = sign.texthl,
      numhl = sign.numhl,
    })
  end
end

-- Step 2: Per-client diagnostics configuration (required in v0.11+)
M.on_attach = function(client, bufnr)
  local ns = vim.lsp.diagnostic.get_namespace(client.id)

  vim.diagnostic.config({
    virtual_text = {
      spacing = 20,
      source = "if_many",
      prefix = "■",
      severity = {
        max = vim.diagnostic.severity.WARN,
      },
    },
    virtual_lines = {
      severity = {
        min = vim.diagnostic.severity.ERROR,
      },
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      source = "if_many",
    },
  }, ns)
end

return M
