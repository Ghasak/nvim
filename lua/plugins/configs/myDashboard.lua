return {
    -- config
    theme = "Doom",
    config = {
        header = {
            '',
            ' ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗  █████╗ ██████╗ ██████╗  ',
            ' ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██╔══██╗ ',
            ' ██║  ██║███████║███████╗███████║██████╔╝██║   ██║███████║██████╔╝██║  ██║ ',
            ' ██║  ██║██╔══██║╚════██║██╔══██║██╔══██╗██║   ██║██╔══██║██╔══██╗██║  ██║ ',
            ' ██████╔╝██║  ██║███████║██║  ██║██████╔╝╚██████╔╝██║  ██║██║  ██║██████╔╝ ',
            ' ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝  ',
            '', "Welcome to Nvim - 0.9"
        }, -- your header
        center = {
            {
                icon = ' ',
                icon_hl = 'Title',
                desc = 'Find File           ',
                desc_hl = 'String',
                key = 'b',
                keymap = '<leader>ff',
                key_hl = 'Number',
                action = 'Telescope find_files'
            }, {

                icon = ' ',
                icon_hl = 'Title',
                desc = 'Regular Expression           ',
                desc_hl = 'String',
                key = 'f',
                keymap = '<leader>fg',
                key_hl = 'Number',
                action = 'Telescope live_grep'

            }, {

                icon = ' ',
                icon_hl = 'Title',
                desc = 'Ranger Explorer           ',
                desc_hl = 'String',
                key = 'r',
                keymap = '<leader>r',
                key_hl = 'Number',
                action = 'RnvimrToggle'
            }, {

                icon = ' ',
                icon_hl = 'Title',
                desc = 'Terminal Explorer           ',
                desc_hl = 'String',
                key = 't',
                -- keymap = '<C-\>',
                key_hl = 'Number',
                action = 'ToggleTerm'
            }
        },
        footer = {"(C) Theme Usage"} -- your footer
    }
}
