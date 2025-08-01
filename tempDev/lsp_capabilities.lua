-- lua/your_module_name/lsp_capabilities.lua
local M = {}

-- 1) base capabilities
local base_caps = vim.lsp.protocol.make_client_capabilities()

-- 2) static enhancements (folding, rich completion)
local extras = {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
    completion = {
      completionItem = {
        documentationFormat = { "markdown", "plaintext" },
        snippetSupport = true,
        preselectSupport = true,
        insertReplaceSupport = true,
        labelDetailsSupport = true,
        deprecatedSupport = true,
        commitCharactersSupport = true,
        tagSupport = { valueSet = { 1 } },
        resolveSupport = {
          properties = { "documentation", "detail", "additionalTextEdits" },
        },
      },
    },
  },
  -- offsetEncoding is commented out; enable only if a specific server demands it.
  -- offsetEncoding = { "utf-8" },
}

-- merge base + extras
local caps = vim.tbl_deep_extend("force", base_caps, extras)

-- 3) prefer blink.cmp, fallback to cmp_nvim_lsp
local blink_ok, blink_cmp = pcall(require, "blink.cmp")
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

if blink_ok and blink_cmp.get_lsp_capabilities then
  local blink_caps = blink_cmp.get_lsp_capabilities { capabilities = caps }
  M.capabilities = vim.tbl_deep_extend("force", caps, blink_caps)
elseif cmp_ok and cmp_nvim_lsp.default_capabilities then
  local cmp_caps = cmp_nvim_lsp.default_capabilities(caps)
  M.capabilities = vim.tbl_deep_extend("force", caps, cmp_caps)
else
  M.capabilities = caps
end

-- helper to extend further if needed
function M.with_overrides(overrides) return vim.tbl_deep_extend("force", M.capabilities, overrides or {}) end

return M
