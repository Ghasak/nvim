local M = {}

M.setup = function()
    local signs = {

        -- { name = "DiagnosticSignError", text = "" ,texthl=DiagnosticSignError,linehl = {}, numhl=DiagnosticLineNrError},
        -- { name = "DiagnosticSignWarn",  text = "כֿ" ,texthl=DiagnosticSignWarn ,linehl = {}, numhl=DiagnosticLineNrWarn },
        -- { name = "DiagnosticSignHint",  text = "" ,texthl=DiagnosticSignInfo ,linehl = {}, numhl=DiagnosticLineNrInfo },
        -- { name = "DiagnosticSignInfo",  text = "" ,texthl=DiagnosticSignHint ,linehl = {}, numhl=DiagnosticLineNrHint },
        {
            name = "DiagnosticSignError",
            text = "",
            texthl = DiagnosticError,
            linehl = {},
            numhl = DiagnosticLineNrError
        }, {
            name = "DiagnosticSignWarn",
            text = "",
            texthl = DiagnosticWarn,
            linehl = {},
            numhl = DiagnosticLineNrWarn
        }, {
            name = "DiagnosticSignHint",
            text = "󰌵",
            texthl = DiagnosticInfo,
            linehl = {},
            numhl = DiagnosticLineNrInfo
        }, {
            name = "DiagnosticSignInfo",
            text = "",
            texthl = DiagnosticHint,
            linehl = {},
            numhl = DiagnosticLineNrHint
        }
    }
    for _, sign in ipairs(signs) do
        vim.fn.sign_define(sign.name,
                           {texthl = sign.name, text = sign.text, numhl = ""})
    end

    -- =================  Customizing how diagnostics are displayed ==============

    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = false
    })

    -- =================  Show source in diagnostics ==============

    vim.diagnostic.config({
        virtual_text = {
            source = "always" -- Or "if_many"
        },
        float = {
            source = "always" -- Or "if_many"
        }
    })

    -- ================== Change prefix/character preceding the diagnostics' virtual text ==================

    vim.diagnostic.config({
        virtual_text = {
            prefix = "■" -- "■" -- Could be '●', '▎', 'x'
        }
    })

end
return M

