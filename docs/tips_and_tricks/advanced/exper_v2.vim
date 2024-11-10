
function! BetterSubV2() abort
  let word = expand('<cword>')  " Get the word under the cursor
  let reg = getreg('0')         " Get the content of register 0

  if !empty(word) && !empty(reg)
    exec "%s/\\<" . word . "\\>/" . reg . "/g"
    echom word . " >>> " . reg
  else
    echom "No word under cursor or register 0 is empty."
  endif
endfunction

nnoremap <leader>z :call BetterSubV2()<CR>

"1. Source this buffer using :so %
"2. Yank the `first`
"3. put the cursor on `Second
"4. Now, you apply `<leader> Z


"first
"second
"second
"second
"second
"second
"second
"second
"second
"second
"second
"second
"second
"second
"second
"second











"second
"second
"second
"second
"second
"second
