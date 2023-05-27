-- Function used to color (yellow) the upper cases words
_G.highlight_upper_letter_cases = function()
    -- The following
    -- This will work if you add to (common) for the color scheme.
    -- Defing first the synatx group by linking them to existed on using:
    -- highlight def link <you_custom_group_name> guifg=<hash-color-name>
    -- Then assign to the specific pattern that you want to highlight
    -- You can link from other group using:
    -- vim.api.nvim_command([[hi def link GGX Title]])
    -- Or create a new group
    -- vim.highlight.create('GGX', {guifg="#EEEDBF"}, true)
    vim.api.nvim_set_hl('GGX', {guifg = "#EEEDBF"}, true)
    -- vim.api.nvim_command([[highlight GGX guifg=#EEEDBF]])
    vim.api.nvim_command([[syn match GGX /[A-Z]+/]])
    vim.api.nvim_command([[syn match GGX /[A-Z]\{2,\}/]])
    vim.api.nvim_command([[syn match GGX "\v<[A-Z]+>"]])
    -- this will be executed only when open vim on event VimEnter (then source all nvim files)
    vim.cmd([[autocmd VimEnter ~/.config/nvim/* source %]])
end

local function status_line()
    local mode = "%-5{%v:lua.string.upper(v:lua.vim.fn.mode())%}"
    local file_name = "%-.16t"
    local buf_nr = "[%n]"
    local modified = " %-m"
    local file_type = " %y"
    local right_align = "%="
    local line_no = "%10([%l/%L%)]"
    local pct_thru_file = "%5p%%"

    return string.format("%s%s%s%s%s%s%s%s", mode, file_name, buf_nr, modified,
                         file_type, right_align, line_no, pct_thru_file)
end

-- vim.opt.statusline = status_line()
-- this function will be trigger only when TextYankPost event happens.
_G.highlight_while_yank = function()
    local exec = vim.api.nvim_exec -- execute Vimscript
    -- highlight on yank
    vim.highlight.create('YANK_HIGHLIGHT_COLOR_GROUP',
                         {ctermbg = 0, guibg = "#FFC49B", guifg = "#EEEDBF"},
                         true)
    -- Having source % can cause problems for certain files
    --  exec([[
    --    augroup YankHighlight
    --      autocmd!
    --      autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="YANK_HIGHLIGHT_COLOR_GROUP", timeout=700}
    --      autocmd TextYankPost  ~/.config/nvim/* source %
    --    augroup end
    --  ]], true)
    vim.cmd [[
    augroup _general_settings
      autocmd!
      autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
      autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'YANK_HIGHLIGHT_COLOR_GROUP', timeout = 200})
      autocmd BufWinEnter * :set formatoptions-=cro
      autocmd FileType qf set nobuflisted
    augroup end
    ]]
end

-- ----------------------------------------------------------------------------------------
-- Function to check all files at packer plugins
-- https://www.twitch.tv/videos/756229115
-- https://github.com/alpha2phi/dotfiles/blob/release-0.1.0/config/nvim/lua/config/telescope.lua
-- https://github.com/craftzdog/dotfiles-public/blob/master/.config/nvim/after/plugin/telescope.rc.lua
-- ----------------------------------------------------------------------------------------
-- the following function will open any file at your packer plugins
_G.edit_neovim_files = function()
    local ok, picker = pcall(require, 'telescope.builtin')
    if ok then
        picker.find_files {
            shorten_path = true,
            cwd = "~/.config/nvim/",
            prompt = "~ nvim config dir ~ ",
            hight = 10
        }
    end
end

-- The following function will search any keyword in packer plugins
_G.search_keyword_lazy_plugins = function()
    local ok, picker = pcall(require, 'telescope.builtin')
    if ok then
        picker.live_grep({
            cwd = "~/.local/share/nvim/lazy/",
            prompt = "~ Lazy Plugins ~ "
        })
    end
end
-----------------------------------------------------------
--              Experiment function
-----------------------------------------------------------
_G.search_for_word_in_lazy_plugins = function(word)
    vim.notify(string.format("%s : this is the word that you have selected",
                             word))
end

-----------------------------------------------------------
-- Other configurations got from ChristMachine
--              Nvim from scratch
-----------------------------------------------------------
-- autocmd! remove all autocommands, if entered under a group it will clear that group

-- ----------------------------------------------------------------------------------------
--                        nvim-tree helper
-- ----------------------------------------------------------------------------------------

-- This is special configuration to close nvim-tree automatically if we closed the last buffer
-- See disucssion here (https://github.com/kyazdani42/nvim-tree.lua/issues/1005)

-- nvim-tree is also there in modified buffers so this function filter it out
local modifiedBufs = function(bufs)
    local t = 0
    for _, v in pairs(bufs) do
        if v.name:match("NvimTree_") == nil then t = t + 1 end
    end
    return t
end

vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and
            vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil and
            modifiedBufs(vim.fn.getbufinfo({bufmodified = 1})) == 0 then
            vim.cmd "quit"
        end
    end
})

-- vim.api.nvim_create_autocmd("BufEnter", {
--   group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
--   pattern = "NvimTree_*",
--   callback = function()
--     local layout = vim.api.nvim_call_function("winlayout", {})
--     if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("confirm quit") end
--   end
-- })

-- ----------------------------------------------------------------------------------------
--                  Functions can show the directory at startup
--                  Dependencies: notify, plenary
-- ----------------------------------------------------------------------------------------
-- Function to show the full path in nvim when you open a given file
local function show_full_path()
    local file = vim.fn.expand("%:p")
    local async = require("plenary.async")
    local notify = require("notify").async
    -- vim.notify(file)
    async.run(function()
        local messege = string.format(" %s at %s ... ", file,
                                      os.date("%H:%M:%S"))
        notify(messege, "INFO", {title = " Initializing file"})
    end)
end

-- ----------------------------------------------------------------------------------------
--                  Allow to wrap the lines when we spit the window
--                  Source:  https://www.reddit.com/r/neovim/comments/yq7jpz/how_to_automatically_wrap_lines_when_split_screen/
--                  It will affect also the nvim-tree, which must be avoided.
-- ----------------------------------------------------------------------------------------
-- vim.api.nvim_create_autocmd({ "WinNew", "WinClosed", "WinEnter" }, {
--     group = vim.api.nvim_create_augroup("on_demand_wrap", {}),
--     callback = function()
--         local should_wrap = vim.api.nvim_win_get_width(0) ~= vim.o.columns
--         vim.api.nvim_win_set_option(0, "wrap", should_wrap)
--     end,
-- })

-- ----------------------------------------------------------------------------------------
--                    Custome function for showing flashing the line
-- More detals: https://www.youtube.com/watch?v=2Hsr4drhAV4
-- ----------------------------------------------------------------------------------------
local function line_flasher()

    local timer = vim.loop.new_timer()
    local i = 0

    timer:start(0, 100, vim.schedule_wrap(function()
        vim.cmd "set cursorline"
        print("timer counting! i = " .. tostring(i))
        -- vim.cmd "hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white"
        -- if i % 2 == 0 then
        --   vim.cmd "set cursorline"
        -- else
        --   vim.cmd "set nocursorline"
        -- end

        if i > 10 then
            timer:stop()
            print("timer stopped")
        end
        i = i + 1
    end))
end

-- ----------------------------------------------------------------------------------------
-- -------------------                                       ------------------------------
-- ----------------------------------------------------------------------------------------
_G.open_session = function()
    -- Current function is used to switch to environment
    -- To create an environment use: mksession ~/.cache/nvim/sessions/<session_environment_name>
    -- We will map this function to the <leader><leader>p to load any project/session faster
    -- Read more about making sessions here:
    -- https://bocoup.com/blog/sessions-the-vim-feature-you-probably-arent-using
    local path = vim.fn.expand("~/.cache/nvim/sessions/")
    local ok, picker = pcall(require, 'telescope.builtin')
    if ok then
        picker.find_files {
            shorten_path = true,
            cwd = path,
            prompt = "~ nvim session dir ~ ",
            hidden = true,
            -- layout_strategy = 'horizontal',
            -- layout_config = {width = 0.9, height = 0.8},
            layout_strategy = 'vertical',
            layout_config = {height = 10},
            attach_mappings = function(prompt_bufnr, map)
                map('i', '<CR>', function()
                    local selection =
                        require("telescope.actions.state").get_selected_entry(
                            prompt_bufnr)
                    local environment_name = selection[1]
                    local full_path = path .. environment_name
                    require('telescope.actions').close(prompt_bufnr)
                    vim.cmd("source " .. tostring(full_path))
                    ----------------- Just for showing banner ------------------
                    local async = require("plenary.async")
                    local notify = require("notify").async
                    -- vim.notify(file)
                    async.run(function()
                        local messege = string.format(
                                            "Switching to: %s at\n%s ... ",
                                            tostring(environment_name),
                                            os.date("%H:%M:%S"))
                        notify(messege, "INFO", {title = " Initializing Env."})
                    end, function() end)
                    ------------------------------------------------------------
                end)
                return true
            end
        }

    end
end
