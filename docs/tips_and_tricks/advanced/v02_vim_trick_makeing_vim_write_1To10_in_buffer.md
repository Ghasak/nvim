# Vim Tric: Making vim write 1 to 10 in the buffer

## VIM script

Lets write this piece of code which is,

1. Open a new buffer with a `file_name.vim`,
2. Use the code snippet below in this buffer

```vim
for i in range(1,10)
    exec "normal! a" .. i
endfor
```

- Using `a` for horizontal numeral increament.
- Using `o` for vertical numeral increament.

3. To activate it automatically in the buffer you can use `Leader + shift + r`.

```vim
nnoremap <silent><buffer> <leader>R :so %<CR>
```

or

```lua
-- execute the vim script in a given buffer
vim.keymap.set("n", "<leader>R", ":so %<CR>", { desc = "Execute" })

```
