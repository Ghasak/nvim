



function! s:better_sub() abort
    let reg = getreg(0)
    let word = expand('<cword>')
    echom word '>>>' reg
endfunc


nnoremap <leader>z :call <SID>better_sub()<CR>

" Here I will automate this using the :so % meaning :source the current buffer.
" we can use also vim.keymap.set("n", "<leader>R", ":so %<CR>", { desc = "Execute" })





" First_Word
" Second_Word

















