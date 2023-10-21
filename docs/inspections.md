# Tools for inpsections in nvim

<!-- vim-markdown-toc GitLab -->

* [Keymapping](#keymapping)
* [Getting buffer name](#getting-buffer-name)
* [getting operation system info](#getting-operation-system-info)
* [Getting variables names in lua](#getting-variables-names-in-lua)
* [References](#references)
* [HOW TO TO DEBUGE AND CHECK MODULES](#how-to-to-debuge-and-check-modules)
* [Developement testing](#developement-testing)
* [REFERENCES](#references-1)
* [RUNTIME PATH](#runtime-path)
* [Asking user for entry](#asking-user-for-entry)
* [How to use codlens](#how-to-use-codlens)
* [Getting stats of buffer](#getting-stats-of-buffer)
* [vim.api.nvim_exec2](#vimapinvim_exec2)
* [How to Run Inspector Helper](#how-to-run-inspector-helper)

<!-- vim-markdown-toc -->

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

## Developement testing

1. Create a `lua` file named `testing_file.lua` inside the `lua` directory as:

```shell
  rwxr-xr-x   8   gmbp   staff    256 B     Fri Oct 21 18:26:35 2022    core/
  rwxr-xr-x   6   gmbp   staff    192 B     Fri Oct 21 01:55:21 2022    plugins/
  rwxr-xr-x   4   gmbp   staff    128 B     Fri Oct 14 12:25:51 2022    units/
  rwxr-xr-x   6   gmbp   staff    192 B     Fri Oct 14 12:25:51 2022    settings/
  rwxr-xr-x   6   gmbp   staff    192 B     Fri Oct  7 15:54:01 2022    scripts/
  rw-r--r--   1   gmbp   staff    369 B     Fri Oct 21 19:56:12 2022    testing_file.lua
```

Inside the `testing_file.lua` put the following:

```lua
M = {}

M.setup = function()

  local dict_test = {
 '1', '2', '3','4', '5'
  }
  return dict_test

end
return M

```

2. Inside your `init.lua` put the following:

```lua

require("core.myInspectorFucntions")
local fn = require("testing_file")
P(fn.setup())
```

3. You will see that the file will be executed everytime we restart the `init.lua` exit and load the file again.
   but, there is a way to load the file that we can change the `testing_file.lua`
   and keep on printing the resutls in the `init.lua` everytime we change the
   `testing_file.lua`. Now, we need to do the following:

4. For developement, we need to use the following

- Loading automaticall by calling

```lua
require('plenary.reload').reload_module('plugins.configs.dap.dap_engine', true)

```

- Or, using the command that we created called `RELOADED` created here `./lua/core/myInspectorFucntions.lua`
  - Use first `RELOAD` command then `RELOADED testing_file` then eveytime you change the file, it will be changed as well.
  - Later I have updated this requested feature, now lua will load the file we request to be loaded. This is so good feature for developement.

## REFERENCES

- [loading the modules automatically ](https://www.reddit.com/r/neovim/comments/jxub94/reload_lua_config/)

## RUNTIME PATH

`lua` programming `runtime` can see up to the directory you named inside the
`lua` directory. Which means, you don't need to require(`lua.dir1.dir2`), and so on, as lua already can see `dir1`.

## Asking user for entry

You can use the following, In your nvim commandline:

```lua
:lua vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
```

## How to use codlens

```lua
:lua vim.pretty_print(vim.lsp.codelens.get(bufnr))
```

## Getting stats of buffer

```lua
:lua vim.pretty_print(vim.api.nvim__buf_stats(vim.api.nvim_get_current_buf()))
```

## vim.api.nvim_exec2

This API is used to run Vim commands via Lua. This API serves as a replacement
for the old version, and here's an example:

- Added on 21/10/2023, using AI searching the web based on `Open.ai`.

```lua
local my_variable = 10
--nvim_exec2({string.format(":echo  %s",my_variable)}, false) -- deprecated
-- New usage
vim.api.nvim_exec2(string.format(":echo  %s", my_variable), {output = false})
```

- To inspect the output produced by the `nvim_exec2` function when the `output`
  option is set to `true`, you would typically capture the return value of the
  function into a variable, and then examine the contents of the `output` field
  in the returned dictionary. Here's a step-by-step process on how you could do
  this in Lua within Neovim:

1. **Execute the Vimscript Code with `nvim_exec2`:**
   Execute your Vimscript code using `nvim_exec2`, with the `output` option set
   to `true` in the optional parameters table, and capture the return value into a
   variable.

```lua
local result = vim.api.nvim_exec2("echo 'Hello, World!'", {output = true})
```

2. **Inspect the `output` Field:**
   The `output` field in the returned dictionary will contain any output
   produced by the Vimscript code. You can inspect this field to see the output.

```lua
print(result.output)
```

In this example, you would see `Hello, World!` printed to Neovim's command line.

3. **Examine Other Fields (if any):**
   If there are other fields in the returned dictionary, you can examine them
   as well to get more information about the execution.

```lua
for key, value in pairs(result) do
    print(key, value)
end
```

This will print all keys and values in the returned dictionary, which might
provide additional information about the execution of the Vimscript code.
Remember, the `output` option in `nvim_exec2` only captures and returns
non-error and non-shell output. If there are errors during the execution, they
would not be captured in the `output` field, but would cause `nvim_exec2` to
fail with a Vimscript error, updating `v:errmsg` instead【20†source】.

## How to Run Inspector Helper

- In the core module, locate the `init.lua` file and include it in the list of
  modules loaded along with others, as shown in the following:

```lua

local init_modules = {
  -- following options are the default
  "core.global",
  --"core.event",
  --"core.utils",
  "core.myInspectorFucntions",
  "core.keymappings",
}
```

- You will notice that pressing "Ctrl" + "Enter" will load your buffer, making it
  very useful when developing a plugin.

- For example, it will prompt you to select a file to load. Simply add the
  filename to obtain the current buffer.
  - Lets do this example, in your `init.lua` file
  - put `vim.print("Hello World")` in this buffer save it then `Ctrl` +
    `Enter`.
