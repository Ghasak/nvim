local M = {}
local which_key_status, which_key = pcall(require, "which-key")

M.config = function()
    -- if  which_key_status then which_key.setup({}) end
    if which_key_status then
        -- method 2
        which_key.register({
            ["<leader>"] = {
                f = {
                    name = "+file",
                    f = {"<cmd>Telescope find_files<cr>", "Find File"},
                    -- r = {"<cmd>Telescope oldfiles<cr>", "Open Recent File"},
                    n = {"<cmd>enew<cr>", "New File"}
                }
            }
        })

    end
end
return M
