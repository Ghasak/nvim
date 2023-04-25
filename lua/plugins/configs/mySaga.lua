return {
    ui = {
        -- Currently, only the round theme exists
        theme = "round",
        -- This option only works in Neovim 0.9
        title = true,
        -- Border type can be single, double, rounded, solid, shadow.
        border = "double",
        winblend = 0,
        expand = "",
        collapse = "",
        preview = " ",
        -- code_action = "",
        code_action = "",
        -- 󰶴
        -- 󱂖  
        diagnostic = "",
        incoming = " ",
        outgoing = " ",
        hover = ' ',
        kind = {}
    },

    beacon = {enable = true, frequency = 7},
    symbol_in_winbar = {
        enable = true,
        separator = " ",
        hide_keyword = true,
        show_file = false, -- will show folder icon in the winbar in the top
        folder_level = 2,
        respect_root = false,
        color_mode = true
    },

    outline = {
        win_position = "right",
        win_with = "",
        win_width = 50,
        show_detail = true,
        auto_preview = true,
        auto_refresh = true,
        auto_close = true,
        custom_sort = nil,
        keys = {jump = "o", expand_collapse = "u", quit = "q"}
    }
}
-- -- Options with default value
-- -- "single" | "double" | "rounded" | "bold" | "plus"
-- border_style = "rounded",
-- --the range of 0 for fully opaque window (disabled) to 100 for fully
-- --transparent background. Values between 0-30 are typically most useful.
-- saga_winblend = 0,
-- -- when cursor in saga window you config these to move
-- move_in_saga = { prev = '<C-p>', next = '<C-n>' },
-- -- Error, Warn, Info, Hint
-- -- use emoji like
-- -- { "🙀", "😿", "😾", "😺" }
-- -- or
-- -- { "😡", "😥", "😤", "😐" }
-- -- and diagnostic_header can be a function type
-- -- must return a string and when diagnostic_header
-- -- is function type it will have a param `entry`
-- -- entry is a table type has these filed
-- -- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
-- --diagnostic_header = { " ", " ", " ", "ﴞ " },
-- diagnostic_header = { "", "כֿ", "", "" },
-- -- preview lines of lsp_finder and definition preview
-- max_preview_lines = 10,
-- -- use emoji lightbulb in default
-- --code_action_icon = "💡",
-- --code_action_icon = " ",
-- --code_action_icon = "盛",
-- code_action_icon = "", --"" "ﯧ " "ﯦ "
-- -- if true can press number to execute the codeaction in codeaction window
-- code_action_num_shortcut = true,
-- -- same as nvim-lightbulb but async
-- code_action_lightbulb = {
--   enable = true,
--   enable_in_insert = true,
--   cache_code_action = true,
--   sign = true,
--   update_time = 150,
--   sign_priority = 20,
--   virtual_text = true,
-- },
--
-- -- finder icons
-- finder_icons = {
--   def = '  ',
--   ref = '諭 ',
--   link = '  ',
-- },
-- -- finder do lsp request timeout
-- -- if your project big enough or your server very slow
-- -- you may need to increase this value
-- finder_request_timeout = 1500,
-- finder_action_keys = {
--   open = "o",
--   vsplit = "s",
--   split = "i",
--   tabe = "t",
--   quit = "q",
-- },
-- code_action_keys = {
--   quit = "q",
--   exec = "<CR>",
-- },
-- definition_action_keys = {
--   edit = '<C-c>o',
--   vsplit = '<C-c>v',
--   split = '<C-c>i',
--   tabe = '<C-c>t',
--   quit = 'q',
-- },
-- rename_action_quit = "<C-c>",
-- rename_in_select = true,
-- -- show symbols in winbar must nightly
-- -- in_custom mean use lspsaga api to get symbols
-- -- and set it to your custom winbar or some winbar plugins.
-- -- if in_cusomt = true you must set in_enable to false
-- symbol_in_winbar = {
--   in_custom = false,
--   enable = true,
--   separator = ' ',
--   show_file = true,
--   -- define how to customize filename, eg: %:., %
--   -- if not set, use default value `%:t`
--   -- more information see `vim.fn.expand` or `expand`
--   -- ## only valid after set `show_file = true`
--   file_formatter = "",
--   click_support = false,
-- },
-- -- show outline
-- show_outline = {
--   win_position = 'right',
--   --set special filetype win that outline window split.like NvimTree neotree
--   -- defx, db_ui
--   win_with = '',
--   win_width = 30,
--   auto_enter = true,
--   auto_preview = true,
--   virt_text = '┃',
--   jump_key = 'o',
--   -- auto refresh when change buffer
--   auto_refresh = true,
-- },
-- -- custom lsp kind
-- -- usage { Field = 'color code'} or {Field = {your icon, your color code}}
-- custom_kind = {},
-- -- if you don't use nvim-lspconfig you must pass your server name and
-- -- the related filetypes into this table
-- -- like server_filetype_map = { metals = { "sbt", "scala" } }
-- server_filetype_map = {},
--
--
