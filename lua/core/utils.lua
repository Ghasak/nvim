local M = {}


-- Keymapping function
M.keymapping = function(mode, lhs, rhs, opts)
   local options = {noremap = true}
   if opts then
      options = vim.tbl_extend("force", options, opts)
   end
   vim.api.nvim_set_keymap(mode, lhs, rhs, options)

end


M.load_module =  function(mod_name)
    local ok, err = pcall(require, mod_name)
    if not ok then
        local msg = "failed loading: " .. mod_name .. "\n " .. err
        vim.notify(msg, "error")
    end
end





return M

