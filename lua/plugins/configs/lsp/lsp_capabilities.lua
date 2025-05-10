-- ===========================================================================
--     4.                Capabilities for the language server
-- ===========================================================================
--
local M = {}

-- 1) start from the default client caps
M.capabilities = vim.lsp.protocol.make_client_capabilities()

-- 2) add whatever extra bits you always want (e.g. ufo, folding, snippets…)
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = { properties = { "documentation", "detail", "additionalTextEdits" } },
}

M.capabilities.offsetEncoding = { "utf-8" }

-- 3) now pick either blink.cmp or cmp_nvim_lsp, whichever loaded
local blink_ok, blink_cmp = pcall(require, "blink.cmp")
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if blink_ok then
  -- blink.nvim’s own wrapper
  M.capabilities = blink_cmp.get_lsp_capabilities(M.capabilities)
elseif cmp_ok then
  -- the vanilla cmp_nvim_lsp helper
  M.capabilities = cmp_nvim_lsp.default_capabilities(M.capabilities)
  -- else: leave the barecapabilities alone
end

return M
--
