











" gorbachov
" abe_shinzo
"
function! s:close(id) abort
    bw! "register"  " Close the buffer without saving
endfunction

function! s:open() abort
    " Save the current command-line input
    let cmd = getcmdline()

    " Exit command-line mode
    call feedkeys("\<C-U>\<Esc>", 'n')

    " Open a small horizontal split with 3 lines
    3split "register"

    " Write the registers' content into the buffer
    call append(0, [getreg(0), getreg('-')])
    "
    " Set a short timer to close the split
    call timer_start(1500, function('s:close'))  " Close after 1.5s

    " Restore the command-line input
    call feedkeys(':' .. cmd .. "\<C-R>", 'n')
endfunction

" Map <C-R> in command-line mode to open the split
cnoremap <C-R> <cmd>call <SID>open()<CR>


"first word
"
"seocnd word
"seocnd word
"seocnd word
