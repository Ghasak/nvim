function! s:better_sub() abort
  let reg = getreg(0)          " Get content from register 0
  let line = getline('.')       " Get the current line
  let start = col("'<")         " Start of visual selection
  let end = col("'>")           " End of visual selection

  " Handle reversed selection
  if start > end
    let temp = start
    let start = end
    let end = temp
  endif

  " Extract the selected word (trim quotes or spaces)
  let word = substitute(line[start - 1 : end - 1], '"', '', 'g')

  " Escape any special characters in the word
  let escaped_word = escape(word, '\.*[]~$^')

  " Perform the global substitution
  try
    exec "%s/\\<" . escaped_word . "\\>/" . reg . "/g"
  catch /^Vim\%((\a\+)\)\=:E486/
    echom "Error: Pattern not found for word: '" . escaped_word . "'"
  endtry

  " Exit visual mode
  call feedkeys("\<Esc>")
endfunction

" Map to <leader>z
noremap <leader>z <cmd>call <SID>better_sub()<CR>

"0. source this function and the keybinding at first.
"1. you need to yank the part of the word for example on `first` from the word `first_word`
"2. then for all words that you want to change, you can highligh them all like `vip`
"3. Now, you can use `<leader>z` as shown in the function

"first_word

"second_word
"second_word
"second_word
"second_word
"second_word
"second_word
"second_word
"second_word
