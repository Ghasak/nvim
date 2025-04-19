local M = {}

---@diagnostic disable-next-line: unused-local
M.custom_attach = function(client, bufnr)
---@diagnostic disable-next-line: unused-function, unused-local
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    vim.api.nvim_create_autocmd("CursorHold", {
        buffer = bufnr,
        callback = function()
            local opts = {
                focusable = false,
                close_events = {
                    "BufLeave", "CursorMoved", "InsertEnter", "FocusLost"
                },
                border = 'rounded',
                source = 'always',
                prefix = ' ',
                scope = 'cursor'
            }
            vim.diagnostic.open_float(nil, opts)
        end
    })
end
return M
