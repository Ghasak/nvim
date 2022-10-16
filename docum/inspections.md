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
It will show you when last time got setted.
```vim
:verbose nmap <leader>

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


## HOW TO TO DEBUGE AND CHECK MODULES

Suppose you have two modules (`*.lua` files) like
`module_a.lua` and `module_b.lua`, then you run the modules particulary to the following
then you required the `module_b` inside `module_b`,
anytime you change something in `module_b` it suppose to be shown in `module_a`
as well. But, the real case, is that, you need always to restart your nvim by
exiting the `module_a` and then enter again the `module_a` if you want `:source
%` or `:luafile %` to run. But, luckily, we have something can reload your modules without exisiting (you will need `plenary`)

- FOR DEBUGGING PURPOSES ONLY USE THIS ON TOP OF YOUR `module_a`
```lua

require('plenary.reload').reload_module('module_b', true)
-- For example I use in my module developement.
require('plenary.reload').reload_module('plugins.configs.dap.dap_engine', true)

```

Run the following example ...
in `module_a` which is the `init.lua` inside the `dap` directory which is inside `configs` up to `plugins`
```lua
require('plenary.reload').reload_module('plugins.configs.dap.dap_engine', true)
local fn1 = require("plugins.configs.dap.dap_engine").setup()
vim.pretty_print(fn1)
```
Then inside `dap_engine.lua`, put the following:

```lua
local M = {}

M.setup = function()
  local x = "Finally it is working, adding to see if it is working ?!!"
  local y = "another series, but this time more added... -<<<<"
  local z = x .. y
  return z
end
return M

```


## REFERENCES
- [loading the modules automatically ](https://www.reddit.com/r/neovim/comments/jxub94/reload_lua_config/)

## RUNTIME PATH
`lua` programming `runtime`  can see up to the directory you named inside the
`lua` directory. Which means, you don't need to require(`lua.dir1.dir2`), and so on, as lua already can see `dir1`.



## Asking user for entry
You can use the following, In your nvim commandline:
```lua
:lua vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
```
