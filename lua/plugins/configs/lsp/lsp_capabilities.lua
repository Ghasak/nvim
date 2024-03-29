local M = {}
-- ===========================================================================
--     4.                Capabilities for the language server
-- ===========================================================================
--
--
-- You must specifiy first the defualt server capabilities
M.capabilities = vim.lsp.protocol.make_client_capabilities()
local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
  return M
end

-- Add folding capabilities required by ufo.nvim
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
-- Otherwise, add more capabilities to the language server
M.capabilities.textDocument.completion.completionItem.documentationFormat = {
  "markdown",
  "plaintext",
}
M.capabilities.textDocument.completion.completionItem.snippetSupport = true
M.capabilities.textDocument.completion.completionItem.preselectSupport = true
M.capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
M.capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
M.capabilities.textDocument.completion.completionItem.deprecatedSupport = true
M.capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
M.capabilities.textDocument.completion.completionItem.tagSupport = {
  valueSet = { 1 },
}
M.capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { "documentatin", "detail", "additionalTextEdits" },
}
-- capabilities.offsetEncoding = {'utf-8', 'utf-16'}
M.capabilities.offsetEncoding = "utf-8"
M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)

return M
