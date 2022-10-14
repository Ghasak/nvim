# Auto Group and Auto command *

Simply use the following information

- `:help events`
- `:help buffers`

The following `autocmd` will be triggered only when you are starting writing in
the `cmd` and once you leave it will print another message.

```lua
local function custom_key_mapping_set_enter()
     vim.pretty_print("Wow, we Entered to the nvim-cmd")
end

local function custom_key_mapping_set_exit()
      vim.pretty_print("Wow, we Exited to the nvim-cmd")
end
local myCustomGroup = vim.api.nvim_create_augroup("myGroup", { clear = true })
vim.api.nvim_create_autocmd("CmdLineEnter", {
  callback = custom_key_mapping_set_enter,
  --command = [[echo "Wow ..."]],
  group = myCustomGroup
})

vim.api.nvim_create_autocmd("CmdLineLeave", {
  callback =  custom_key_mapping_set_exit,
  --command = [[echo "Wow ..."]],
  group = myCustomGroup
})

```

## REFERENCES
- [au.lua snippets](https://gist.github.com/numToStr/1ab83dd2e919de9235f9f774ef8076da)
- [Neovim for Beginners - Lua autocmd and keymap functions](https://alpha2phi.medium.com/neovim-for-beginners-lua-autocmd-and-keymap-functions-3bdfe0bebe42)

