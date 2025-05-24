------------------------------------------------------------
--                                                        --
--             ░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀               --
--             ░█░█░█▀▀░░█░░░█░░█░█░█░█░▀▀█               --
--             ░▀▀▀░▀░░░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀               --
--                                                        --
-- Neovim settings                                        --
--- General Neovim settings                               --
-------------------------------------------------------------
-----------------------------------------------------------
-- Neovim API aliases
-----------------------------------------------------------
-- local map = vim.api.nvim_set_keymap  -- set global keymap
local cmd = vim.cmd -- execute Vim commands
-- local exec = vim.api.nvim_exec -- execute Vimscript
-- local fn = vim.fn -- call Vim functions
local g = vim.g -- global variables
local opt = vim.opt -- global/buffer/windows-scoped options
local vim = vim
-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.mouse = "a" -- enable mouse support, clicking and scrolling,
opt.mousemodel = "popup" -- since v.10
-- Now I use, option from my mac If you use iTerm,
-- <<defaults write com.googlecode.iterm2 AlternateMouseScroll -bool true>>
opt.clipboard = "unnamedplus" -- copy/paste to system clipboard

vim.cmd [[
  set clipboard=unnamed
  if has("unnamedplus") " X11 support
      set clipboard+=unnamedplus
  endif
]]

vim.cmd [[
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set encoding=utf-8
]]

-- vim.cmd [[
-- set encoding=utf-8
-- set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
-- set fileformats=unix,dos,mac
-- ]]

opt.swapfile = false -- don't use swapfile

-- mapping for paste  Ref: https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
vim.cmd [[
  xnoremap p "_dP
]]
--

-----------------------------------------------------------
--              For Neovide - Compatibility
-----------------------------------------------------------
vim.g.neovide_scale_factor = 1.0
-----------------------------------------------------------
--               For Tmux Support colors
-----------------------------------------------------------
-- vim.cmd [[
-- set background=dark
-- set t_Co=256
-- ]]

vim.cmd [[
set modifiable
set write
]]
-----------------------------------------------------------
--              Spelling and dictionary
--        This takes so much time costing around 30 millsec
-----------------------------------------------------------
-- vim.cmd([[
--    set spell
--    set spelllang=en_us
--    "set spellfile = /usr/share/myspell/en_US.dic
-- ]])
-- vim.cmd("set dictionary+=/usr/share/dict/words")
-- Now we trigger the spell-checking using <F6>
-- These options to trigger the spelling attachment.
-- vim.opt.spell = true
-- vim.opt.spelllang = { 'en_us' }

-----------------------------------------------------------
-- Configurations form my old vim script
-----------------------------------------------------------
-- opt.cmdheight = 1 -- vim.cmd('set cmdheight=0') -- Control the height of cmdline
opt.cmdheight = 2
opt.wrap = false
vim.o.wrapscan = false -- Disable search wrapping to stop at EOF instead of cycling to the top.
opt.relativenumber = true
opt.errorbells = false
opt.signcolumn = "yes"
opt.cursorline = true
opt.ruler = true
opt.fileencoding = "utf-8"
opt.pumheight = 10
opt.encoding = "utf-8"
opt.updatetime = 300
opt.timeoutlen = 500
cmd [[set formatoptions-=cro]] -- Stop newline continution of comments
opt.laststatus = 2 -- originally its 0,  this will allow lua statusline to be shown, otherwise it will not
opt.backup = false -- Recommended by COC
opt.writebackup = false -- Recommended by COC
opt.showtabline = 2
opt.showmode = false -- This will show the ModeMsg when the mode is changed I turned off as it shows in the status line already.
opt.conceallevel = 0
opt.tabstop = 2
opt.shiftwidth = 2
opt.wildignore = ".git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**"
opt.fillchars = {
  vert = "▕", -- alternatives │
  fold = " ",
  eob = " ", -- suppress ~ at EndOfBuffer
  diff = "╱", -- alternatives = ⣿ ░ ─
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸",
}
-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.syntax = "enable" -- enable syntax highlighting
opt.number = true -- show line number
opt.showmatch = true -- highlight matching parenthesis
opt.foldmethod = "manual" -- enable folding (default 'foldmarker'), if not manual, the ufo.nvim will not work.
opt.colorcolumn = "130" -- line lenght marker at 80 columns
-- to show the color of the vertical ruler set to 120 width for now
-- vim.cmd([[hi ColorColumn ctermbg=0 guibg=lightgray]])
-- cmd([[highlight ColorColumn ctermbg=0 guibg=lightgrey]])
opt.splitright = true -- vertical split to the right
opt.splitbelow = true -- orizontal split to the bottom
opt.ignorecase = true -- ignore case letters when search
opt.smartcase = true -- ignore lowercase for the whole pattern

-- ===========================================================================
--                      Remove any white space on saving event
-- ===========================================================================

-- remove whitespace on save
vim.cmd [[au BufWritePre * :%s/\s\+$//e]]
-----------------------------------------------------------
-- Memory, CPU
-----------------------------------------------------------
opt.hidden = true -- enable background buffers
opt.history = 100 -- remember n lines in history
opt.lazyredraw = true -- faster scrolling
opt.synmaxcol = 240 -- max column for syntax highlight
-- Added new options
opt.scrolloff = 2 -- make scrolling better
opt.sidescroll = 2 -- make scrolling better
opt.shiftwidth = 2 -- set indentation width
opt.sidescrolloff = 15 -- make scrolling better
-----------------------------------------------------------
-- Colorscheme
-----------------------------------------------------------
opt.termguicolors = true -- enable 24-bit RGB colors
-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true -- use spaces instead of tabs
opt.shiftwidth = 4 -- shift 4 spaces when tab
opt.tabstop = 4 -- 1 tab == 4 spaces
opt.smartindent = true -- autoindent new lines
opt.autoindent = true
-- don't auto commenting new lines
vim.cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

-- remove line lenght marker for selected filetypes
vim.cmd [[
  autocmd FileType text,markdown,xml,html,xhtml,javascript setlocal cc=0
]]

-- 2 spaces for selected filetypes
vim.cmd [[
  autocmd FileType xml,html,xhtml,css,scss,javascript,lua,yaml setlocal shiftwidth=2 tabstop=2
]]

-- 8 spaces for Go files
vim.cmd [[autocmd FileType go setlocal shiftwidth=8 tabstop=8]]

-- IndentLine
-- g.indentLine_setColors = 0  -- set indentLine color
-- g.indentLine_char = '|'       -- set indentLine character

-- disable IndentLine for markdown files (avoid concealing)
vim.cmd [[
	autocmd FileType markdown let g:indentLine_enabled=0
]]

-- Configurations for the mac
local global = require "core.global"
if global.is_mac then
  vim.g.clipboard = {
    name = "macOS-clipboard",
    copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
    paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
    cache_enabled = 0,
  }
end

-- Check if Python 3 interpreter exists in /opt/anaconda3/bin/, fallback to system Python
if vim.fn.executable "/opt/anaconda3/bin/python3" == 1 then
  vim.g.python3_host_prog = "/opt/anaconda3/bin/python3"
else
  vim.g.python3_host_prog = "/usr/bin/python3" -- Fallback to system Python
end
-- ||||||| Stash base
-- -- vim.g.python_host_prog = "/usr/bin/python2"
-- -- vim.g.python_host_prog = "$HOME/anaconda3/bin/python2" -- '/usr/local/bin/python3'
-- vim.g.python2_host_prog = vim.fn.expand "~" .. "/anaconda3/bin/python2"
-- -- vim.g.python3_host_prog = "$HOME/anaconda3/bin/python3" -- '/usr/local/bin/python3'
-- vim.g.python3_host_prog = vim.fn.expand "~" .. "/anaconda3/bin/python3"
-- vim.g.python_host_prog = vim.fn.expand "~" .. "/anaconda3/bin/python3"
-- =======

-- Disable Python 2 provider (no longer supported in Neovim 0.5+)
vim.g.loaded_python_provider = 0

-- Optionally set python_host_prog to match python3_host_prog for backward compatibility
vim.g.python_host_prog = vim.g.python3_host_prog
-----------------------------------------------------------
--          Glow for Markdown
-----------------------------------------------------------
vim.g.glow_border = "double"
vim.g.glow_width = 200
-- vim.g.glow_use_pager = true
-- vim.g.glow_style = "light"
vim.opt.termguicolors = true

-----------------------------------------------------------
--      Unload some default plugins shipped with nvim
-----------------------------------------------------------
-- local g = vim.g

-- Disable some builtin vim plugins
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  -- "netrw",
  -- "netrwPlugin",
  -- "netrwSettings",
  -- "netrwFileHandlers",
  "matchit",
  "matchparen",
  "tar",
  "tarPlugin",
  "rrhelper",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

local disable_distribution_plugins = function()
  vim.g.loaded_gzip = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1
  vim.g.loaded_getscript = 1
  vim.g.loaded_getscriptPlugin = 1
  vim.g.loaded_vimball = 1
  vim.g.loaded_vimballPlugin = 1
  vim.g.loaded_matchit = 1
  vim.g.loaded_matchparen = 1
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_logiPat = 1
  vim.g.loaded_rrhelper = 1
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_netrwSettings = 1
  vim.g.loaded_netrwFileHandlers = 1
end

-----------------------------------------------------------
--            Remove whitespace on save
-----------------------------------------------------------
vim.cmd [[au BufWritePre * :%s/\s\+$//e]]

-----------------------------------------------------------
-- This will auto load the nvim if the file got changed
--        by other editor or buffer
--  (if you change the file in vscode for example)
-----------------------------------------------------------
-- vim.cmd([[
-- au BufWinEnter *.<fileextension> set updatetime=300 | set ft=<filetype>| set autoread
-- au CursorHold *.<fileextension>  checktime
-- ]])

-----------------------------------------------------------
--  Createa a yanking highlight _ colored from onedark config ( IncSearch: increment search color group)
-----------------------------------------------------------
-- vim.highlight.create('XXX', {ctermbg=0, guibg="#FFC49B", guifg="#EEEDBF"}, true)
-- Having source % can cause problems for certain files
--  exec([[
--    augroup YankHighlight
--      autocmd!
--      autocmd TextYankPost * silent! lua vim.highlight.on_yank{higroup="YANK_HIGHLIGHT_COLOR_GROUP", timeout=700}
--      autocmd TextYankPost  ~/.config/nvim/* source %
--    augroup end
--  ]], true)

-----------------------------------------------------------
--                 Ruler Color for Nvimm
-----------------------------------------------------------
vim.cmd [[highlight ColorColumn ctermbg=black guibg=#373d46]]

-----------------------------------------------------------
--            ON YANKING HIGHLIGHT
-----------------------------------------------------------
-- vim.cmd [[
--   augroup _general_settings
--     autocmd!
--     autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
--     autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'IncSearch', timeout = 700})
--     autocmd BufWinEnter * :set formatoptions-=cro
--     autocmd FileType qf set nobuflisted
--   augroup end
--   ]]
--
-- This is implementation of the same above for the Nvim using Lua API
vim.api.nvim_create_autocmd("TextYankPost", {
  -- group = vim.api.nvim_create_augroup('highlight_yank'),
  desc = "Hightlight selection on yank",
  pattern = "*",
  callback = function() vim.highlight.on_yank { higroup = "TextYankPost_style", timeout = 700 } end,
})
-- ===========================================================================
--            This will highlight the Cursor Line Number ()
-- ===========================================================================
-- Read more here:
-- https://www.folkstalk.com/2022/09/vim-line-numbers-background-color-with-code-examples.html
-- :hi LineNr ctermfg=grey ctermbg=white
-- :hi CursorLineNr ctermfg=45 cterm=bold
-- vim.cmd([[
--     hi CursorLineNr term=bold cterm=bold ctermfg=green guifg=red guibg=black2
-- ]])
-----------------------------------------------------------
--  Highlight symbols with (/) search command event
-----------------------------------------------------------
-- Setting for the multi-instance searching with /
-- vim.cmd([[set hlsearch]])
-- vim.cmd([[hi Search term=reverse guibg=peru guifg=wheat]])
--
-- ===============================================================
--            HIGHLIGHT THE HOPPING MATCHES
--         Based on the color style of IncSearch
-- https://vi.stackexchange.com/questions/18546/
-- can-i-use-a-different-color-for-the-selected-match-than-for-other-matches/
-- 18555#18555?newreg=22db9c3cafc846cc905fb0da27633f18
-- It will be triggered once, we enter the buffer.
-- ===============================================================
vim.api.nvim_create_autocmd("BufEnter", {
  nested = true,
  callback = function()
    vim.cmd [[
function! HighlightSearch(timer)
    if (g:firstCall)
        let g:originalStatusLineHLGroup = execute("hi StatusLine")
        let g:firstCall = 0
    endif
    if (exists("g:searching") && g:searching)
        let searchString = getcmdline()
        if searchString == ""
            let searchString = "."
        endif
        let newBG = search(searchString) != 0 ? "green" : "red"
        if searchString == "."
            set whichwrap+=h
            normal h
            set whichwrap-=h
        endif
        let g:highlightTimer = timer_start(50, 'HighlightSearch')
        let g:searchString = searchString
    else
        let originalBG = matchstr(g:originalStatusLineHLGroup, 'ctermfg=\zs[^ ]\+')
        if exists("g:highlightTimer")
            call timer_stop(g:highlightTimer)
            call HighlightCursorMatch()
        endif
    endif
endfunction
function! HighlightCursorMatch()
    try
        let l:patt = '\%#'
        if &ic | let l:patt = '\c' . l:patt | endif
        exec 'match IncSearch /' . l:patt . g:searchString . '/'
    endtry
endfunction
nnoremap n nzzzv:call HighlightCursorMatch()<CR>
nnoremap N Nzzzv:call HighlightCursorMatch()<CR>

augroup betterSeachHighlighting
    autocmd!
    autocmd CmdlineEnter * if (index(['?', '/'], getcmdtype()) >= 0) | let g:searching = 1 | let g:firstCall = 1 | call timer_start(1, 'HighlightSearch') | endif
    autocmd CmdlineLeave * let g:searching = 0

augroup END
]]
  end,
})

-- ===========================================================================
--                 Create Directories for Caching files
-- ===========================================================================
local createdir = function()
  -- This function is used to create cache directories for our nvim sessionn
  local data_dir = {
    global.cache_dir .. "backup",
    global.cache_dir .. "session",
    global.cache_dir .. "swap",
    global.cache_dir .. "tags",
    global.cache_dir .. "undo",
  }
  for key, dirx in pairs(data_dir) do
    -- if vim.fn.empty(vim.fn.glob(dirx)) > 0 then
    vim.api.nvim_command(
      ([[echohl WarningMsg | echomsg "[-] The directory:%s is not existed, will be created ." | echohl None]]):format(dirx)
    )
    os.execute("mkdir -p " .. dirx)
  end
end

-- ===========================================================================
--                 Auto Load netrwPlugin at startup
--        (when you use nvim without specifying the file_name)
-- https://stackoverflow.com/questions/63238533/autoload-netrw-when-starting-vim/76054055#76054055
-- ===========================================================================
-- Moder Lua auto-command for launching netrwPlugin which shipped with the nvim
-- Previously: Instead of callback I used -> command = ":silent! Explore",
local mygroup = vim.api.nvim_create_augroup("loading_netrwPlugin", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  pattern = { "*" },
  callback = function()
    -- Getting the file name that you pass when you launch nvim,
    local current_file = vim.fn.expand "%"
    -- if we have already file_name, then, we edit it
    if current_file ~= "" then
      vim.cmd(":silent! edit " .. current_file)
    else
      -- We will check if the window (buffer) is the lazy nvim, as it conflict if the buffer (popup menu) is lazy
      local lazy_popup_buf_exists = false
      -- We will get list of all current opened buffers
      local buf_list = vim.api.nvim_list_bufs()
      for _, buf in ipairs(buf_list) do
        -- We will obtain from the table only the filetype
        local buf_ft = vim.api.nvim_buf_get_option(buf, "filetype")
        if buf_ft == "lazy" then lazy_popup_buf_exists = true end
      end -- Check if vim-floaterm is loaded
      local has_floaterm, _ = pcall(require, "floaterm")
      if not lazy_popup_buf_exists and not has_floaterm then
        -- Then we can safely loading netrwPlugin at startup
        vim.cmd ":silent! Explore"
      end
    end
  end,
  group = mygroup,
})

-- ===========================================================================
--                     -- GOT REPLACED BY UFO NVIM --
-- ===========================================================================
-- To enhance grammar and spelling, we're modifying the original sentence.
-- Instead of two hyphens followed by a space, we're using three consecutive hyphens (--),
-- indicating a section break or a heading. This is common in Markdown syntax.
-- ===========================================================================
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- ===========================================================================
--                   OLD JUNKS FROM PERVIOUS CONFIGS
-- ===========================================================================

-- Or simply use
-- vim.cmd([[
-- " Open Netrw after Vim starts up
-- augroup InitNetrw
-- autocmd!
-- autocmd VimEnter * :silent! Explore
-- augroup END
-- ]])

-- ===========================================================================
--                       Change the shape of Cursor
-- By default, you will see the
-- ===========================================================================
-- cmd([[set guicursor=]]) -- This will keep the cursor form changing. [important command]
--cmd ([[set guicursor+=n-v-c:blinkon1-blinkoff1]]) -- since v.10
-----------------------------------------------------------
--              Cursor shape
-----------------------------------------------------------
-- cmd[[set guicursor=a:/iCursor-blinkon40-blinkoff40-blinkwait10]]   -- To change the  cursor options such as the size and blinking, not used at the moment
-- cmd[[set guicursor=i-ci:ver30-iCursor-blinkon40-blinkoff40-blinkwait10]]   -- To change the  cursor options such as the size and blinking
-- (a) means all modes, (i) insert, (v) visual model, and iCursor is different from blockCurosr see (:h guicurosr)
-- cmd([[set guicursor=a:ver50-iCursor-blinkon40-blinkoff40-blinkwait10]]) -- To change the  cursor options such as the size and blinking,
-- cmd([[set guicursor=i:ver50-iCursor-blinkon40-blinkoff40-blinkwait10]]) -- To change the  cursor options such as the size and blinking,
-----------------------------------------------------------
-- local mygroup2 = vim.api.nvim_create_augroup("ChangeMyCursor", {clear = true})
-- vim.api.nvim_create_autocmd({"InsertEnter"}, {
--     pattern = "*",
--     command = vim.cmd([[silent set guicursor=i:ver100-blockCurosr-blinkon40-blinkoff40-blinkwait10]]),
--     group = mygroup2
-- })
--
-- vim.api.nvim_create_autocmd({"InsertLeave"}, {
--     pattern = "*",
--     command = vim.cmd([[silent set guicursor=i:ver100-iCursor-blinkon40-blinkoff100-blinkwait100]]),
--     group = mygroup2
-- })
