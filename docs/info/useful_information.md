# Useful Information

## Difference between TabLine, TablineFill and TabLineSel

- In Neovim, TabLine, TabLineFill, and TabLineSel are all highlight groups used
  to control the appearance of the tab line.
- TabLine is the highlight group used for the active tab in the tab line. This
  means that the tab containing the currently active buffer will be highlighted
  using the colors and attributes specified in this group.
- TabLineSel is the highlight group used for the inactive tabs in the tab line.
  This means that any tabs that are not currently active will be highlighted
  using the colors and attributes specified in this group.
- TabLineFill is the highlight group used for the area of the tab line that is
  not occupied by any tabs. This means that the area to the left and right of
  the active and inactive tabs will be filled using the colors and attributes
  specified in this group.
- The TabLine and TabLineSel groups are the most commonly used, as they are
  responsible for defining the appearance of the active and inactive tabs
  respectively. However, TabLineFill can also be used to customize the
  appearance of the space between tabs.
- In summary, TabLine is used for the active tab, TabLineSel is used for the
  inactive tabs, and TabLineFill is used for the empty space between tabs in
  the tab line.

## Getting the file type in Nvim

In order to know the file type in Lua with Neovim, you can use the
`vim.bo.filetype` variable. This variable returns a string representing the
current file type.

Example:

```lua
local file_type = vim.bo.filetype
print("File type:", file_type)
```

You can also use the `filetype()` function to get the file type of a specific
buffer. This function takes a buffer number as an argument and returns the file
type of the corresponding buffer.
- Example:

```lua
local buffer_number = 1 -- Change this to the buffer number you want to check
local file_type = vim.fn.filetype(buffer_number)
print("File type:", file_type)
```

- **Note** that the vim.bo and vim.fn modules provide access to the
  buffer-local variables and functions, respectively. These modules are used to
  get information about the current buffer and its contents.


## How to know buffer name and language server name in lua nvim
In order to know the buffer name and language server name in Lua with Neovim,
you can use the following commands:

To get the buffer name, you can use the bufname() function. This function
returns the full file path of the current buffer if called without any
arguments, or the full file path of the buffer specified by the buffer number
if an argument is passed. Example:
```lua
local buffer_name = vim.fn.bufname()
print("Buffer name:", buffer_name)
```
To get the language server name, you can use the `vim.lsp.buf_get_clients()`
function. This function returns a table containing information about the active
language server clients for the current buffer. You can then access the name
field of each client to get the language server name. Example:
```lua
local clients = vim.lsp.buf_get_clients()
for _, client in ipairs(clients) do
  print("Language server name:", client.name)
end
```
Note that the vim.lsp module requires a language server to be installed and
configured. If you haven't done so already, you'll need to install a language
server and set up Neovim to use it.

## what is different between Search and CurSearch?
Search and CurSearch are both highlight groups used in the neovim editor, but
they serve different purposes.

Search is a highlight group used to highlight all matches when you perform a
search in the editor using the / command. All matches are highlighted with the
color defined for the Search highlight group.

CurSearch, on the other hand, is a highlight group used to highlight the
current search match when you navigate through the matches using the n and N
commands. Only the current match is highlighted with the color defined for the
CurSearch highlight group.

So, in summary: Search highlights all matches of a search term in the editor
CurSearch highlights only the current match of a search term when navigating
through matches By default, the Search highlight group has a yellow background
color and black foreground color, while the CurSearch highlight group has a
yellow background color and black foreground color. However, these colors can
be customized in your init.vim configuration file or in your chosen color
scheme file.

## How about IncSearch
IncSearch is another highlight group used in the neovim editor that is related
to searching. It is used to highlight the current search match as you type the
search term, instead of waiting for you to press enter to start the search.

When you type a search term in neovim, IncSearch is used to highlight the
current search match as you type. This allows you to see the effect of your
search term on the document in real time, and helps you quickly refine your
search.

Unlike Search and CurSearch, which are used after the search is complete,
IncSearch is used during the search process itself.

By default, the IncSearch highlight group has a yellow background color and
black foreground color. However, this can be customized in your init.vim
configuration file or in your chosen color scheme file.

Here's an example of how to customize the IncSearch highlight group in your
init.vim file:

```vim
"Set the background color to red and the foreground color to white
highlight IncSearch ctermbg=red ctermfg=white
```
This will change the colors used for the IncSearch highlight group to red and
white, respectively.



## Getting all package loaded
I use the following command to get all packages which are loaded on fly.
```lua
:lua vim.print(package.loaded)
```

