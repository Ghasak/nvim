# Tools for inpsections in nvim

## Keymapping
You can use one of the following,

1. Telescope
Assume you already triggered the `telescope` using `<leader>f`, then run:

```vim
:telescope keymapping
```

2. nmap, noremap, map
```vim
nmap <key>
# Example
:nmap <c-w>
```

3. All mappings

```vim
:map
```
4. Using verbose

```vim
:verbose map <ke>
:verbose map <c-k>

```



## Getting buffer name

```lua
:buffers <- this will tell you all the current buffers

:lua vim.pretty_print(vim.api.nvim_buf_get_name(0))

```


## References
- [keymapping form Lunarvim](https://github.com/LunarVim/LunarVim/blob/rolling/lua/lvim/keymappings.lua)
