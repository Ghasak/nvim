-- Here, I am using a vim-function with the formula <exec(fun, bool)>
--local exec = vim.api.nvim_exec2 -- execute Vimscript
-- It seems that the (finish) doesnt work with the cmd in current configuration ... I removed already
-- check here: (https://github.com/mbbill/undotree/blob/master/plugin/undotree.vim#L15)

-- Set maximum number of changes that can be undone
vim.o.undolevels = 1000

-- Set maximum number of lines to save for undo on buffer reload
vim.o.undoreload = 100000

vim.api.nvim_exec2(
  [[
let g:loaded_undotree = 1
if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif
"=================================================
"Options:

" Window layout
" style 1
" +----------+------------------------+
" |          |                        |
" |          |                        |
" | undotree |                        |
" |          |                        |
" |          |                        |
" +----------+                        |
" |          |                        |
" |   diff   |                        |
" |          |                        |
" +----------+------------------------+
" Style 2
" +----------+------------------------+
" |          |                        |
" |          |                        |
" | undotree |                        |
" |          |                        |
" |          |                        |
" +----------+------------------------+
" |                                   |
" |   diff                            |
" |                                   |
" +-----------------------------------+
" Style 3
" +------------------------+----------+
" |                        |          |
" |                        |          |
" |                        | undotree |
" |                        |          |
" |                        |          |
" |                        +----------+
" |                        |          |
" |                        |   diff   |
" |                        |          |
" +------------------------+----------+
" Style 4
" +-----------------------++----------+
" |                        |          |
" |                        |          |
" |                        | undotree |
" |                        |          |
" |                        |          |
" +------------------------+----------+
" |                                   |
" |                            diff   |
" |                                   |
" +-----------------------------------+
if !exists('g:undotree_WindowLayout')
    let g:undotree_WindowLayout = 1
endif

" e.g. using 'd' instead of 'days' to save some space.
if !exists('g:undotree_ShortIndicators')
    let g:undotree_ShortIndicators = 0
endif

" undotree window width
if !exists('g:undotree_SplitWidth')
    if g:undotree_ShortIndicators == 0
        let g:undotree_SplitWidth = 20
    else
        let g:undotree_SplitWidth = 20
    endif
endif

" diff window height
if !exists('g:undotree_DiffpanelHeight')
    let g:undotree_DiffpanelHeight = 10
endif

" auto open diff window
if !exists('g:undotree_DiffAutoOpen')
    let g:undotree_DiffAutoOpen = 1
endif

" if set, let undotree window get focus after being opened, otherwise
" focus will stay in current window.
if !exists('g:undotree_SetFocusWhenToggle')
    let g:undotree_SetFocusWhenToggle = 0
endif

" tree node shape.
if !exists('g:undotree_TreeNodeShape')
    let g:undotree_TreeNodeShape = '*'
endif

" tree vertical shape.
if !exists('g:undotree_TreeVertShape')
    let g:undotree_TreeVertShape = '|'
endif

" tree split shape.
if !exists('g:undotree_TreeSplitShape')
    let g:undotree_TreeSplitShape = '/'
endif

" tree return shape.
if !exists('g:undotree_TreeReturnShape')
    let g:undotree_TreeReturnShape = '\'
endif

if !exists('g:undotree_DiffCommand')
    let g:undotree_DiffCommand = "diff"
endif

" relative timestamp
if !exists('g:undotree_RelativeTimestamp')
    let g:undotree_RelativeTimestamp = 1
endif

" Highlight changed text
if !exists('g:undotree_HighlightChangedText')
    let g:undotree_HighlightChangedText = 1
endif

" Highlight changed text using signs in the gutter
if !exists('g:undotree_HighlightChangedWithSign')
    let g:undotree_HighlightChangedWithSign = 1
endif

" Highlight linked syntax type.
" You may chose your favorite through ":hi" command
if !exists('g:undotree_HighlightSyntaxAdd')
    let g:undotree_HighlightSyntaxAdd = "DiffAdd"
endif
if !exists('g:undotree_HighlightSyntaxChange')
    let g:undotree_HighlightSyntaxChange = "DiffChange"
endif
if !exists('g:undotree_HighlightSyntaxDel')
    let g:undotree_HighlightSyntaxDel = "DiffDelete"
endif

" Deprecates the old style configuration.
if exists('g:undotree_SplitLocation')
    echo "g:undotree_SplitLocation is deprecated,
                \ please use g:undotree_WindowLayout instead."
endif

" Show help line
if !exists('g:undotree_HelpLine')
    let g:undotree_HelpLine = 1
endif

" Show cursorline
if !exists('g:undotree_CursorLine')
    let g:undotree_CursorLine = 1
endif

"=================================================
" User commands.
command! -n=0 -bar UndotreeToggle   :call undotree#UndotreeToggle()
command! -n=0 -bar UndotreeHide     :call undotree#UndotreeHide()
command! -n=0 -bar UndotreeShow     :call undotree#UndotreeShow()
command! -n=0 -bar UndotreeFocus    :call undotree#UndotreeFocus()

" vim: set et fdm=marker sts=4 sw=4:

]],
  { output = true }
)
