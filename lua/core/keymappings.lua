---@diagnostic disable: 2
-- ====================================================================================================
---
--         ██╗░░██╗███████╗██╗░░░██╗  ███╗░░░███╗░█████╗░██████╗░██████╗░██╗███╗░░██╗░██████╗░░██████╗
--         ██║░██╔╝██╔════╝╚██╗░██╔╝  ████╗░████║██╔══██╗██╔══██╗██╔══██╗██║████╗░██║██╔════╝░██╔════╝
--         █████═╝░█████╗░░░╚████╔╝░  ██╔████╔██║███████║██████╔╝██████╔╝██║██╔██╗██║██║░░██╗░╚█████╗░
--         ██╔═██╗░██╔══╝░░░░╚██╔╝░░  ██║╚██╔╝██║██╔══██║██╔═══╝░██╔═══╝░██║██║╚████║██║░░╚██╗░╚═══██╗
--         ██║░╚██╗███████╗░░░██║░░░  ██║░╚═╝░██║██║░░██║██║░░░░░██║░░░░░██║██║░╚███║╚██████╔╝██████╔╝
--         ╚═╝░░╚═╝╚══════╝░░░╚═╝░░░  ╚═╝░░░░░╚═╝╚═╝░░╚═╝╚═╝░░░░░╚═╝░░░░░╚═╝╚═╝░░╚══╝░╚═════╝░╚═════╝░
--
-- ====================================================================================================
-- Basics Configurations
-- Following: https://youtu.be/ppMX4LHIuy4
-- There are three types of configuration options
-- 1.) Global optoins (vim.o)
-- 2.) Local to window (vim.wo)
-- 3.) Local to buffer (vim.bo)
-- Adding some configurations
-- How to know to which configuration use :h expandtab
-- My Leader key
-- KeyMapping Order:
-- 1. Load the plugins which means (load the lspconfig custom_attach key-mapping at first).
-- 2. Load the settings which will load the current configurations,
-- 3. Load the lsp-saga, at the end of this file
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2

---@diagnostic disable-next-line: unused-local
local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  term_mode = "t",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
}

vim.keymap.set("n", "x", '"_x')
-- Increment/decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")
-- Delete a word backwards
vim.keymap.set("n", "dw", 'vb"_d')

-- Select to the end of line in visual mode
vim.keymap.set("v", "<S-a>", "$", { desc = "Select to end of lines in visual block" })
vim.keymap.set("v", "<S-l>", "^", { desc = "Select to beginning of lines in visual block" })
-- vim.api.nvim_set_keymap('v', '<S-a>', '$', { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('v', '<S-l>', '^', { noremap = true, silent = true })

-- Better paste with indentation
vim.keymap.set("n", ",p", "o<Esc>p")
vim.keymap.set("n", ",P", "O<Esc>p")
-- To Replace with regsiter [ you can yank a word then use <ESC>b then grw]
vim.keymap.set("n", "gr", "<Plug>ReplaceWithRegisterOperator")
vim.keymap.set("n", "grl", "<Plug>ReplaceWithRegisterLine")
vim.keymap.set("n", "grv", "<Plug>ReplaceWithRegisterVisual")

-- Better verticl movmenet control
-- We have shift + { or shit + } for moving vertically, but I found the ctrl + n/p are better
-- - [Vim As Your Editor - Vertical Movements ](https://www.youtube.com/watch?v=KfENDDEpCsI)
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-n>", "<C-n>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-p>", "<C-p>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- How about {} jumping, which are working same,
vim.api.nvim_set_keymap("n", "{", "{zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "}", "}zz", { noremap = true, silent = true })
-- For better searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- For better searching you can also try (select the word then #, * to get your word loaded in the search, then n, or N to jump on occurrences).
-- Select all But it will affect the increament
-- vim.keymap.set('n', '<C-a>', 'gg<S-v>G')

-- Require Neovide configurations
-- require("units.neovideConfig").neovide_config()

-- Using Ctrl-jhkl to navigate splits (buffers)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })

-- Arrow  mapping for navigation among opened windows
vim.api.nvim_set_keymap("n", "<C-Right>", "<C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Left>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Up>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-Down>", "<C-w>j", { noremap = true, silent = true })

-- These will causing a problem with the lua-fzf when you select choices up and down.
-- vim.api.nvim_set_keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", { noremap = true, silent = true })
-- These have no problem
vim.api.nvim_set_keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", { noremap = true, silent = true })

-- navigate tab completion with <c-j> and <c-k>
-- runs conditionally, in command mode only
vim.api.nvim_set_keymap("c", "<C-j>", 'pumvisible() ? "\\<C-n>" : "\\<C-j>"', { noremap = true, expr = true })
vim.api.nvim_set_keymap("c", "<C-k>", 'pumvisible() ? "\\<C-p>" : "\\<C-k>"', { noremap = true, expr = true })

-- Source our init.lua file
-- vim.api.nvim_set_keymap("n", "<space><CR>", ":source ~/.config/nvim/init.lua<CR>", { noremap = true, silent = true, })
vim.api.nvim_set_keymap("n", "<space><CR>", ":w!<CR>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<c-s>", ":w<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<c-s>", "<Esc>:w<CR>", { noremap = true, silent = true })

-- Better indenting using (<) and (>)
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Tab switch buffers
vim.api.nvim_set_keymap("n", "<TAB>", ":bnext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<S-TAB>", ":bprevious<CR>", { noremap = true, silent = true })

-- delete backward a single word using `Shift+Del (backspace)`.
-- For Normal Mode
vim.api.nvim_set_keymap("n", "<C-S-BS>", "db", { noremap = true, silent = true })
-- For Insert Mode
vim.api.nvim_set_keymap("i", "<C-S-BS>", "<C-w>", { noremap = true, silent = true })

-- map the leader in nvim to space
vim.g.mapleader = " "
-- Explorer with Nvim-tree( ensure first the undotree is not toggled )
vim.api.nvim_set_keymap(
  "n",
  "<Leader>ft",
  ":<cmd>UndotreeHide<CR>:NvimTreeToggle<CR>",
  { noremap = true, silent = true }
)
-- this will be source with setting directory which shoould be put at the end of the loaded dictionaries
vim.api.nvim_set_keymap(
  "n",
  "<leader>u",
  ":<cmd>NvimTreeClose<CR> :UndotreeToggle<CR>",
  { noremap = true, silent = true }
)
-- Ctrl + P to open the the navigator faster
vim.api.nvim_set_keymap("n", "<leader>p", "<cmd>lua require('fzf-lua').files()<CR>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>p',"<cmd>lua require('fzf-lua').files({ fzf_opts = {['--layout'] = 'reverse-list'} })<CR>",{ noremap = true, silent = true })

-- Move/selected line / block of text in visual mode
vim.api.nvim_set_keymap("x", "<C-k>", ":move '<-2<CR>gv-gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("x", "<C-j>", ":move '>+2<CR>gv-gv", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<C>k", ":move .-2<CR>==", { noremap = true, silent = true, })
-- vim.api.nvim_set_keymap("n", "<C>j", ":move .+1<CR>==", { noremap = true, silent = true, })

-- yank to the end of a line
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>y", "y$", { noremap = true, silent = true })

-- close all windows and exit from neovim
vim.api.nvim_set_keymap("n", "<leader>q", ":qa<CR>", { noremap = true, silent = true })

-- mapping for paste  Ref: https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text
vim.cmd [[
  xnoremap p "_dP
  xnoremap <silent> p p:let @+=@0<CR>
]]
-- Paste over currently selected text without yanking it
vim.api.nvim_set_keymap("v", "p", '"_dP', { noremap = true, silent = true })

-- Cancel search highlighting with ESC
vim.api.nvim_set_keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", { noremap = true, silent = true })

-- Maximize and minimize windows
vim.api.nvim_set_keymap("n", "<space>+", ":vertical resize +5<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<space>-", ":vertical resize -5<CR>", { noremap = true, silent = true })

-- close windows without affecting other buffers
--vim.api.nvim_set_keymap("n", "<leader>w", "<cmd>Bdelete<cr>", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<leader>w", "<cmd>BufDel<cr>", { noremap = true, silent = false })

-- Move to beginning and end of line in normal mode
vim.api.nvim_set_keymap("n", "<leader>h", "<ESC>^", { noremap = true, silent = false })
vim.api.nvim_set_keymap("n", "<leader>l", "<ESC>$", { noremap = true, silent = false })

-- Rnvim (Ranger) for Nvim
vim.api.nvim_set_keymap("n", "<Leader>r", ":RnvimrToggle<CR>", { noremap = true, silent = false })

-- Floating terminal for nvim
vim.api.nvim_set_keymap("n", "<Leader>t", ":Lspsaga term_toggle<CR>", { noremap = true, silent = false })

-- Better nav for omni-complete
-- vim.api.nvim_set_keymap("i", "<c-j>", '("<C-n>")', { noremap = true, silent = true, expr = true, })
-- vim.api.nvim_set_keymap("i", "<c-k>", '("<C-p>")', { noremap = true, silent = true, expr = true, })

-- open a link in vim in browser: in linux use : xdg-open instead of open (for mac).
-- source: " https://stackoverflow.com/questions/9458294/open-url-under-cursor-in-vim-with-browser "
-- nnoremap <silent> gx :execute 'silent! !open ' . shellescape(expand('<cWORD>'), 1)<cr>
-- let path="/Applications/Safari.app", the web-link should have soome space
-- with quotation like " www.something.com ", not "www.something.com"
vim.cmd [[
function! OpenUrlUnderCursor()
    let path="/Applications/Firefox.app",
    execute "normal BvEy"
    let url=matchstr(@0, '[a-z]*:\/\/[^ >,;]*')
    if url != ""
        silent exec "!open -a ".path." '".url."'" | redraw!
        echo "opened ".url
    else
        echo "No URL under cursor."
    endif
endfunction
nmap <leader>gu :call OpenUrlUnderCursor()<CR>
nmap gx :call OpenUrlUnderCursor()<CR>

]]

vim.cmd [[
nmap <leader>gw :call Google()<CR>
fun! Google()
    let keyword = expand("<cword>")
    let url = "http://www.google.com/search?q=" . keyword
    let path="/Applications/Firefox.app"
    "let path = "C:/Program Files/Mozilla Firefox/"
    "exec 'silent ! path url'
    silent exec "!open -a ".path." '".url."'" | redraw!
endfun

]]

-- Turn-off the default key-bindings of the coq-nvim code snippets +9000
vim.cmd [[
    " Set recommended to false
    let g:coq_settings = { "keymap.recommended": v:false }
]]

-- For accelerate the nvim cursor works on any operating system.
vim.cmd [[
         nmap j <plug>(accelerated_jk_gj_position)
         nmap k <plug>(accelerated_jk_gk_position)
         ]]

-- Lua APIs can be all mapped
-- :lua vim.lsp.buf.hover() or  implementation(), ..etc.

---- *****************************************************************************************
----                    Checking spelling - Builtin suggesions
---- *****************************************************************************************
vim.api.nvim_set_keymap("n", "<F6>", ":set spell! spelllang=en<CR>", { noremap = true, silent = true })
-- Add a spell word to your custom dictionary using
-- -> zg (as z for spell and g for good word)
-- -> zw (as z for spell and w for bad word)
-- -> zuw (as z for spell and u as undo and w for bad word)
-- -> z= (to see the suggestions, must put the cursor under the word for spell suggestions)
-- -> [s ,[S, ]s and ]S are for navigating the words for spelling checking
---- *****************************************************************************************
----                   Auto-save plugin to save file every changes happen
---- *****************************************************************************************
-- To trigger auto-save for the given file
vim.api.nvim_set_keymap("n", "<leader>s", ":ASToggle<CR>", {})

---- *****************************************************************************************
----                   Auto-save plugin to save file every changes happen
---- *****************************************************************************************
-- vim.api.nvim_set_keymap("n", "<leader>fr", ":Neoformat<CR>", { noremap = true, silent = true })
-- For Rust, if it is faild you can run (:!cargo fmt)
-- Or using (:!rustfmt --edition=2021 src/main.rs)
-- Key binding for normal mode
vim.api.nvim_set_keymap(
  "n",
  "<leader>fr",
  ':lua require("conform").format({ lsp_fallback = true, async = true, timeout_ms = 500 })<CR>',
  {
    noremap = true,
    silent = true,
    desc = "Format file or range (using conform.nvim)",
  }
)

-- Key binding for visual mode
vim.api.nvim_set_keymap(
  "v",
  "<leader>fr",
  ':lua require("conform").format({ lsp_fallback = false, async = true, timeout_ms = 500 })<CR>',
  {
    noremap = true,
    silent = true,
    desc = "Format file or range (using conform.nvim)",
  }
)
-- vim.api.nvim_set_keymap("n", "<leader>fr", ":Format<CR>", { noremap = true, silent = true })
-- In visual mode, you can use v the :<,>:Format to format only the given range.
---- *****************************************************************************************
----                   Auto-save plugin to save file every changes happen
---- *****************************************************************************************
-- This function will support many hovering style including "toml crate" files
local show_documentation = function()
  local filetype = vim.bo.filetype
  if vim.tbl_contains({ "vim", "help" }, filetype) then
    vim.cmd("h " .. vim.fn.expand "<cword>")
  elseif vim.tbl_contains({ "man" }, filetype) then
    vim.cmd("Man " .. vim.fn.expand "<cword>")
  elseif vim.fn.expand "%:t" == "Cargo.toml" and require("crates").popup_available() then
    require("crates").show_popup()
  else
    vim.lsp.buf.hover()
  end
end

vim.keymap.set("n", "gH", show_documentation, { noremap = true, silent = true })

---- *****************************************************************************************
----                     Lspsaga KeyMapping
---- *****************************************************************************************

-- Show definition of function based on nvim-lspConfig instead of K
vim.api.nvim_set_keymap("n", "<leader><F1>", ":lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })

-- KeyMapping
-- use <C-t> to jump back
vim.keymap.set("n", "<leader>gh", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
-- Code action
vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
-- Check
vim.keymap.set("n", "<F2>", "<cmd>Lspsaga peek_type_definition<CR>", { silent = true })
-- Rename
vim.keymap.set("n", "<leader>ar", "<cmd>Lspsaga rename<CR>", { silent = true })
-- Peek Definition
-- support tagstack C-t jump back
vim.keymap.set("n", "<leader>gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
-- Show line diagnostics
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
-- Show cursor diagnostic
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
-- Diagnsotic jump can use `<c-o>` to jump back
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
-- Only jump to error
vim.keymap.set("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev {
    severity = vim.diagnostic.severity.ERROR,
  }
end, { silent = true })
vim.keymap.set("n", "]E", function()
  require("lspsaga.diagnostic").goto_next {
    severity = vim.diagnostic.severity.ERROR,
  }
end, { silent = true })

-- Outline
vim.keymap.set("n", "<leader>o", "<cmd>Lspsaga outline<CR>", { silent = true })

---- *****************************************************************************************
----                     Debugging Color Syntx for Color theme
----                     URL: https://github.com/nvim-treesitter/playground
---- *****************************************************************************************
vim.keymap.set("n", "<leader><leader>", "<cmd>TSHighlightCapturesUnderCursor<CR>", { silent = true })

---- *****************************************************************************************
----                    Switching between Sessions (Projects)
----          check the function _G.open_session at special_color_highlight.lua
---- *****************************************************************************************
--------- Load the session pallete using <leader><leader>p ---------
vim.api.nvim_set_keymap("n", "<leader><leader>p", ":lua open_session()<CR>", { noremap = true, silent = true })

---- *****************************************************************************************
--                              Find in visual mode (no plugin is required)
--                       https://github.com/Ajnasz/nvim-rfind
---- *****************************************************************************************
vim.keymap.set("x", "/", "<Esc>/\\%V")

---- *****************************************************************************************
----                    Switching between Sessions (Projects)
----          check the function _G.open_session at special_color_highlight.lua
---- *****************************************************************************************
-- setup mapping to call :LazyGit
vim.api.nvim_set_keymap("n", "<leader>gg", ":LazyGit<CR>", { noremap = true, silent = true })

---- *****************************************************************************************
----                        From plugin gen.nvim (AI)
----             Check: https://github.com/David-Kunz/gen.nvim/tree/main
----             https://ollama.ai/download
---- *****************************************************************************************
vim.api.nvim_set_keymap("v", "<leader>ai", ":Gen<CR>", { noremap = true, silent = true })
--vim.api.nvim_set_keymap("v", "<leader>ai", ":Gen Enhance_Grammar_Spelling<CR>", { noremap = true, silent = true })
-------------------------------

-- vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleForward)")
-- vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleBackward)")

---- *****************************************************************************************
-- For faster mapping for :Lazy Plugin Manager.
---- *****************************************************************************************
vim.keymap.set("n", "<leader>z", "<cmd>:Lazy<cr>", { desc = "Plugin Manager" })

---- *****************************************************************************************
----                             VIM-VISUAL-MULTI MODE
----                               :help visual-multi
---- *****************************************************************************************
vim.keymap.set("n", "<leader>cu", "<Plug>(VM-Add-Cursor-Up)", { desc = "vim visual multi" })
vim.keymap.set("n", "<leader>cd", "<Plug>(VM-Add-Cursor-Down)", { desc = "vim visual multi" })
---- *****************************************************************************************
----                         For folding with nvim
--             Check Ufo configirations at ../plugins/configs/my_ufo.lua
---- *****************************************************************************************
-- vim.keymap.set("n", "<leader>1", ":foldclose<CR>", { desc = "vim visual multi" })
-- vim.keymap.set("v", "<leader>1", ":fold<CR>", { desc = "vim visual multi" })
-- vim.keymap.set("n", "<leader>2", ":foldopen<CR>", { desc = "vim visual multi" })
-- --

---- *****************************************************************************************
----                  SUPPORT FOR TELEKASTEN NOTES (OBSIDIAN)
---- *****************************************************************************************
-- Launch panel if nothing is typed after <leader>z
vim.keymap.set("n", "<leader>tk", "<cmd>Telekasten panel<CR>")

---- *****************************************************************************************
----                               VENN NVIM DIGRAMS
----                reference: https://github.com/jbyuki/venn.nvim
---- *****************************************************************************************
-- venn.nvim: enable or disable keymappings

function _G.Toggle_venn()
  --local async = require "plenary.async"
  local notify = require "notify"
  local message, title

  -- Check if Venn is enabled
  if vim.b.venn_enabled then
    -- Venn is currently enabled, so disable it
    message = string.format("[OFF] VENN DIAGRAMS Status: deactivated at:\n%s", os.date "%H:%M:%S")
    title = "Venn Deactivated"
    vim.cmd [[setlocal ve=]]
    local maps = { "J", "K", "L", "H" }
    for _, key in ipairs(maps) do
      vim.api.nvim_buf_del_keymap(0, "n", key)
    end
    vim.api.nvim_buf_del_keymap(0, "v", "f")
    vim.b.venn_enabled = nil
  else
    -- Venn is currently disabled, so enable it
    message = string.format("[ON] VENN DIAGRAMS Status: activated at:\n%s", os.date "%H:%M:%S")
    title = "Venn Activated"
    vim.b.venn_enabled = true
    vim.cmd [[setlocal ve=all]]
    vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
    vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
  end

  -- Notify the user of the change
  notify(message, "info", { title = title, timeout = 5000 })
end

-- Toggle key mappings for Venn using <leader>v
vim.api.nvim_set_keymap("n", "<leader>v", ":lua Toggle_venn()<CR>", { noremap = true, silent = true })

-- Create a keymap to toggle markdown rendering
vim.api.nvim_set_keymap(
  "n", -- Normal mode
  "<leader>m", -- The keybinding, you can change '<leader>m' to your preferred key combination
  ":RenderMarkdown toggle<CR>", -- The command to toggle the markdown rendering
  { noremap = true, silent = true } -- Keymap options
)

-- Execute the vim script in a given buffer
vim.keymap.set("n", "<leader>R", ":so %<CR>", { desc = "Execute" })
