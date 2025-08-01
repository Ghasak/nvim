local M = {}

M.lua_lsp_on_init = function(client)
  if client.workspace_folders then
    local path = client.workspace_folders[1].name
    if path ~= vim.fn.stdpath "config" and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc")) then
      return
    end
  end
end

return M
