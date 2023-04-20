version 6.0
let s:cpo_save=&cpo
set cpo&vim
cnoremap <silent> <Plug>(TelescopeFuzzyCommandSearch) e "lua require('telescope.builtin').command_history { default_text = [=[" . escape(getcmdline(), '"') . "]=] }"
inoremap <silent> <C-S> :w
cnoremap <expr> <C-K> pumvisible() ? "\" : "\"
cnoremap <expr> <C-J> pumvisible() ? "\" : "\<NL>"
inoremap <C-W> u
inoremap <C-U> u
xnoremap <silent>  <Cmd>lua require('neoscroll').scroll(-vim.api.nvim_win_get_height(0), true, 450)
nnoremap <silent>  <Cmd>lua require('neoscroll').scroll(-vim.api.nvim_win_get_height(0), true, 450)
xnoremap <silent>  <Cmd>lua require('neoscroll').scroll(vim.wo.scroll, true, 250)
nnoremap <silent>  <Cmd>lua require('neoscroll').scroll(vim.wo.scroll, true, 250)
xnoremap <silent>  <Cmd>lua require('neoscroll').scroll(0.10, false, 100)
nnoremap <silent>  <Cmd>lua require('neoscroll').scroll(0.10, false, 100)
xnoremap <silent>  <Cmd>lua require('neoscroll').scroll(vim.api.nvim_win_get_height(0), true, 450)
nnoremap <silent>  <Cmd>lua require('neoscroll').scroll(vim.api.nvim_win_get_height(0), true, 450)
tnoremap <silent>  h
nnoremap <silent>  h
nnoremap <silent> 	 :bnext
xnoremap <silent> <NL> :move '>+2gv-gv
nnoremap <silent> <NL> j
xnoremap <silent>  :move '<-2gv-gv
nnoremap <silent>  k
tnoremap <silent>  l
nnoremap <silent>  l
nnoremap <silent>  zz
nnoremap <silent>  zz
nnoremap <silent>  :w
xnoremap <silent>  <Cmd>lua require('neoscroll').scroll(-vim.wo.scroll, true, 250)
nnoremap <silent>  <Cmd>lua require('neoscroll').scroll(-vim.wo.scroll, true, 250)
xnoremap <silent>  <Cmd>lua require('neoscroll').scroll(-0.10, false, 100)
nnoremap <silent>  <Cmd>lua require('neoscroll').scroll(-0.10, false, 100)
tnoremap  :q!
tnoremap  
nnoremap <silent>  :nohlsearch|:echo
nnoremap <silent>  m :Glow
nnoremap  tt :call OpenTerminal()
nnoremap  bn :call OpenTerminal()
nnoremap <silent>  o <Cmd>Lspsaga outline
nnoremap <silent>  cd <Cmd>Lspsaga show_cursor_diagnostics
nnoremap <silent>  gd <Cmd>Lspsaga peek_definition
nnoremap <silent>  ar <Cmd>Lspsaga rename
nnoremap <silent>  <F2> <Cmd>Lspsaga lsp_finder
vnoremap <silent>  ca <Cmd>Lspsaga code_action
nnoremap <silent>  ca <Cmd>Lspsaga code_action
nnoremap <silent>  gh <Cmd>Lspsaga lsp_finder
nnoremap <silent>  <F1> :lua vim.lsp.buf.hover()
nmap  fr :Neoformat
nmap  s :ASToggle
nmap  gw :call Google()
nmap  gu :call OpenUrlUnderCursor()
nnoremap  t :FloatermToggle
nnoremap  r :RnvimrToggle
nnoremap  l $
nnoremap  h ^
nnoremap  w <Cmd>Bdelete
nnoremap <silent>  - :vertical resize -5
nnoremap <silent>  + :vertical resize +5
nnoremap <silent>  q :qa
nnoremap <silent>  y y$
nnoremap <silent>  p <Cmd>lua require('fzf-lua').files()
nnoremap <silent>  u :<Cmd>NvimTreeClose :UndotreeToggle
nnoremap <silent>  e :<Cmd>UndotreeHide:NvimTreeToggle
nnoremap <silent>   :w!
xnoremap # y?\V"
nnoremap & :&&
xnoremap * y/\V"
nnoremap + 
nnoremap ,P Op
nnoremap ,p op
nnoremap - 
vnoremap <silent> < <gv
vnoremap <silent> > >gv
nnoremap N Nzzzv:call HighlightCursorMatch()
nnoremap <silent> Y y$
nnoremap <silent> [e <Cmd>Lspsaga diagnostic_jump_prev
nnoremap \z <Cmd>:Lazy
nnoremap <silent> ]e <Cmd>Lspsaga diagnostic_jump_next
nnoremap dw vb"_d
nnoremap grv <Plug>ReplaceWithRegisterVisual
nnoremap grl <Plug>ReplaceWithRegisterLine
nnoremap gr <Plug>ReplaceWithRegisterOperator
xmap gx <Plug>NetrwBrowseXVis
nmap gx :call OpenUrlUnderCursor()
nmap j <Plug>(accelerated_jk_gj_position)
nmap k <Plug>(accelerated_jk_gk_position)
nnoremap n nzzzv:call HighlightCursorMatch()
xnoremap p "_dP
snoremap <silent> p "_dP
nnoremap x "_x
xnoremap <silent> zt <Cmd>lua require('neoscroll').zt(250)
nnoremap <silent> zt <Cmd>lua require('neoscroll').zt(250)
xnoremap <silent> zb <Cmd>lua require('neoscroll').zb(250)
nnoremap <silent> zb <Cmd>lua require('neoscroll').zb(250)
xnoremap <silent> zz <Cmd>lua require('neoscroll').zz(250)
nnoremap <silent> zz <Cmd>lua require('neoscroll').zz(250)
nnoremap <silent> { {zz
nnoremap <silent> } }zz
xnoremap <silent> <C-B> <Cmd>lua require('neoscroll').scroll(-vim.api.nvim_win_get_height(0), true, 450)
nnoremap <silent> <C-B> <Cmd>lua require('neoscroll').scroll(-vim.api.nvim_win_get_height(0), true, 450)
xnoremap <silent> <C-U> <Cmd>lua require('neoscroll').scroll(-vim.wo.scroll, true, 250)
xnoremap <silent> <C-F> <Cmd>lua require('neoscroll').scroll(vim.api.nvim_win_get_height(0), true, 450)
nnoremap <silent> <C-F> <Cmd>lua require('neoscroll').scroll(vim.api.nvim_win_get_height(0), true, 450)
xnoremap <silent> <C-Y> <Cmd>lua require('neoscroll').scroll(-0.10, false, 100)
nnoremap <silent> <C-Y> <Cmd>lua require('neoscroll').scroll(-0.10, false, 100)
xnoremap <silent> <C-E> <Cmd>lua require('neoscroll').scroll(0.10, false, 100)
nnoremap <silent> <C-E> <Cmd>lua require('neoscroll').scroll(0.10, false, 100)
xnoremap <silent> <C-D> <Cmd>lua require('neoscroll').scroll(vim.wo.scroll, true, 250)
nnoremap <Plug>PlenaryTestFile :lua require('plenary.test_harness').test_directory(vim.fn.expand("%:p"))
nnoremap <silent> <Plug>(accelerated_jk_k_position) :call accelerated#position_driven#command('k')
nnoremap <silent> <Plug>(accelerated_jk_j_position) :call accelerated#position_driven#command('j')
nnoremap <silent> <Plug>(accelerated_jk_gk_position) :call accelerated#position_driven#command('gk')
nnoremap <silent> <Plug>(accelerated_jk_gj_position) :call accelerated#position_driven#command('gj')
nnoremap <silent> <Plug>(accelerated_jk_k) :call accelerated#time_driven#command('k')
nnoremap <silent> <Plug>(accelerated_jk_j) :call accelerated#time_driven#command('j')
nnoremap <silent> <Plug>(accelerated_jk_gk) :call accelerated#time_driven#command('gk')
nnoremap <silent> <Plug>(accelerated_jk_gj) :call accelerated#time_driven#command('gj')
nnoremap <silent> <F6> :set spell! spelllang=en
xnoremap <silent> <C-J> :move '>+2gv-gv
xnoremap <silent> <C-K> :move '<-2gv-gv
nnoremap <silent> <S-Tab> :bprevious
nnoremap <silent> <C-S> :w
tnoremap <silent> <C-L> l
tnoremap <silent> <C-H> h
nnoremap <silent> <C-Down> j
nnoremap <silent> <C-Up> k
nnoremap <silent> <C-Left> h
nnoremap <silent> <C-Right> l
nnoremap <silent> <C-J> j
nnoremap <silent> <C-H> h
nnoremap <silent> <C-K> k
nnoremap <silent> <C-U> <Cmd>lua require('neoscroll').scroll(-vim.wo.scroll, true, 250)
nnoremap <silent> <C-P> zz
nnoremap <silent> <C-N> zz
nnoremap <silent> <C-D> <Cmd>lua require('neoscroll').scroll(vim.wo.scroll, true, 250)
xnoremap <silent> <Plug>NetrwBrowseXVis :call netrw#BrowseXVis()
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#BrowseX(netrw#GX(),netrw#CheckIfRemote(netrw#GX()))
nnoremap <silent> <C-L> l
cnoremap <expr> <NL> pumvisible() ? "\" : "\<NL>"
cnoremap <expr>  pumvisible() ? "\" : "\"
inoremap <silent>  :w
inoremap  u
inoremap  u
let &cpo=s:cpo_save
unlet s:cpo_save
set clipboard=unnamed,unnamedplus
set expandtab
set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
set fileformats=unix,dos,mac
set fillchars=diff:â•±,eob:\ ,fold:\ ,foldclose:â–¸,foldopen:â–¾,foldsep:â”‚,msgsep:â€¾,vert:â–•
set formatoptions=jtqln
set guicursor=
set helpheight=80
set helplang=en
set history=100
set ignorecase
set lazyredraw
set noloadplugins
set mouse=a
set packpath=~/dev/neovim/share/nvim/runtime
set pumheight=10
set runtimepath=~/.config/nvim,~/.local/share/nvim/lazy/lazy.nvim,~/.local/share/nvim/lazy/neoformat,~/.local/share/nvim/lazy/nvim-notify,~/.local/share/nvim/lazy/rust-tools.nvim,~/.local/share/nvim/lazy/cmp-nvim-lsp,~/.local/share/nvim/lazy/neodev.nvim,~/.local/share/nvim/lazy/mason-tool-installer.nvim,~/.local/share/nvim/lazy/mason-lspconfig.nvim,~/.local/share/nvim/lazy/nvim-lspconfig,~/.local/share/nvim/lazy/neoscroll.nvim,~/.local/share/nvim/lazy/plenary.nvim,~/.local/share/nvim/lazy/telescope.nvim,~/.local/share/nvim/lazy/accelerated-jk,~/.local/share/nvim/lazy/lualine.nvim,~/.local/share/nvim/lazy/nvim-web-devicons,~/.local/share/nvim/lazy/fzf-lua,~/.local/share/nvim/lazy/glow.nvim,~/.local/share/nvim/lazy/markdown-preview.nvim,~/.local/share/nvim/lazy/nvim-treesitter-context,~/.local/share/nvim/lazy/nvim-treesitter-textsubjects,~/.local/share/nvim/lazy/nvim-ts-context-commentstring,~/.local/share/nvim/lazy/nvim-ts-autotag,~/.local/share/nvim/lazy/nvim-treesitter-textobjects,~/.local/share/nvim/lazy/nvim-treesitter,~/.local/share/nvim/lazy/nvim-ts-rainbow,~/.local/share/nvim/lazy/mason.nvim,~/.local/share/nvim/lazy/onedark.nvim,~/dev/neovim/share/nvim/runtime,~/dev/neovim/lib/nvim,~/.local/share/nvim/lazy/cmp-nvim-lsp/after,~/.config/nvim/after,~/.local/state/nvim/lazy/readme
set scrolloff=2
set shiftwidth=4
set showmatch
set showtabline=2
set sidescroll=2
set sidescrolloff=15
set smartcase
set smartindent
set splitbelow
set splitright
set statusline=%#Normal#
set noswapfile
set synmaxcol=240
set tabstop=4
set termguicolors
set timeoutlen=500
set updatetime=300
set wildignore=.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**
set window=50
set nowritebackup
" vim: set ft=vim :
