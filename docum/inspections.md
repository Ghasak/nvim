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

## getting operation system info
```lua
:lua vim.pretty_print(vim.loop.os_uname())
```

## Getting variables names in lua


```lua
local max_job_limit = function()
  if vim.fn.has "mac" == 1 then
    vim.g.custom_max_jobs_limit = 50
  else
    vim.g.custom_max_jobs_limit = 100
  end
  return vim.g.custom_max_jobs_limit
end

:lua vim.pretty_print(vim.inspect(vim.g.custom_max_jobs_limit))
-- or:
:lua vim.pretty_print(vim.inspect(vim.api.nvim_get_var('custom_max_jobs_limit')))
```

## References
- [keymapping form Lunarvim](https://github.com/LunarVim/LunarVim/blob/rolling/lua/lvim/keymappings.lua)
