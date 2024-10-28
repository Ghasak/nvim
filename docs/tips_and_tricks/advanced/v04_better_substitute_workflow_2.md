# Better Substitute Workflow 1

We want to keep the cursor after applying the substitution for the words for
the entir buffer in same place without move it to the end.

1. Here is for testing

```vim

function! s:better_sub() abort
    let reg = getreg(0)
    let word = expand('<cword>')
    echom word '>>>' reg
endfunc


nnoremap <leader>z :call <SID>better_sub()<CR>


```

2. Now, we need a library from google called `maktaba` for google

- [vim maktaba library](https://github.com/google/vim-maktaba)

```vim
function! s:better_sub_v2() abort
    let reg = getreg(0)
    let word = expand('<cword>')
    call maktaba#buffer#Substitute(word,reg)
    echom word '>>>' reg
endfunc


nnoremap <leader>z :call <SID>better_sub_v2()<CR>

```

## Can we use without Maktaba

Yes! You can achieve this substitution functionality in Neovim **without using
the `maktaba` library** by leveraging built-in Vim commands directly in a Lua
or Vimscript function. Here’s how you can implement it:

### **Solution in Lua (Recommended for Neovim)**

This version works by getting the word under the cursor and the content from
register 0, then performing a substitution across the buffer.

```lua
vim.keymap.set("n", "<leader>Z", function()
  local word = vim.fn.expand("<cword>")  -- Get the word under the cursor
  local reg_content = vim.fn.getreg("0") -- Get content from register 0

  if word ~= "" and reg_content ~= "" then
    vim.cmd(string.format("%%s/\\<%s\\>/%s/g", word, reg_content))
    print(string.format("Replaced '%s' with '%s'", word, reg_content))
  else
    print("No word under cursor or register 0 is empty.")
  end
end, { desc = "Replace word under cursor with register 0 content" })
```

### **Explanation:**

1. **`vim.fn.expand("<cword>")`**: Retrieves the word under the cursor.
2. **`vim.fn.getreg("0")`**: Retrieves the content of register 0.
3. **`vim.cmd()`**: Executes the `:substitute` command to replace the word globally.
4. **`%%s/\\<%s\\>/%s/g`**: Ensures that only whole words are matched and replaced.

### **Vimscript Version** (if you prefer):

If you want to stick with Vimscript:

```vim
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

nnoremap <leader>Z :call BetterSubV2()<CR>
```

### **How This Works:**

1. **`expand('<cword>')`**: Gets the word under the cursor.
2. **`getreg('0')`**: Fetches the contents of register 0.
3. **`exec`**: Executes the substitution command across the entire buffer.

This way, you don't need any external libraries like `maktaba`—everything is
handled natively with Neovim/Vim built-ins.

