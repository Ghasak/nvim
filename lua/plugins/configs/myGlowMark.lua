local M = {}

M.setup = function()
    require('glow').setup({
        vim.api.nvim_set_keymap('n', '<leader>m', ':Glow<CR>',
                                {noremap = true, silent = true}),
        -- border = 'rounded',
        border = {"╔", "═", "╗", "║", "╝", "═", "╚", "║"},
        pager = false,
        shadow = false,
        style = "dark",
        width = 140
    })
end

return M
