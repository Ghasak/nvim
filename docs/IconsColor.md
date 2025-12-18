# Icons colors

Notice that the colors for the `nvim-web-devicons` located here
[nvim-web-dev-icons](https://github.com/nvim-tree/nvim-web-devicons/tree/master)
can control the color of the icons in `nvim` espciecally the colors of icons of
`nvim-tree` plugin. We simply change the color of the icon enterially how they
appear in `nvim` by adjusting the configurations of the called
`nvim-web-devicons` plugin. For example, I changed the color of the `.gitigonre` for the `nvim` icon using

```lua
{
    "kyazdani42/nvim-web-devicons",
    event = "VimEnter",
    config = function()
        require("nvim-web-devicons").setup({
            default = true,
            -- takes effect when `strict` is true
            override_by_filename = {
                [".gitignore"] = {
                    icon = "",
                    color = "#f1502f", -- this color is red
                    name = "Gitignore"
                }
            }
        })
    end
},
```

### Hint,

Changing the color of the icons that appear next to the filename such as
`meldoy` icons, is done by changing the color of the corresponding color
highlight theme in our color theme plugin `github.nvim` mainly by changing the
following compoenents. To read more read here (:help nvim-tree) and search for
`NvimTreeRootFolder` for example.

- You can change the color either from the `github.nvim` theme of the file
  `highlights.lua` located at
  `~/.local/share/nvim/lazy/githubG.nvim/lua/onedark/highlights.lua`

```lua
hl.plugins.nvim_tree = {
    NvimTreeNormal = {fg = c.fg, bg = cfg.transparent and c.none or c.black},
    NvimTreeVertSplit = {
        fg = c.white,
        bg = cfg.transparent and c.none or c.black
    },
    NvimTreeEndOfBuffer = {
        fg = cfg.ending_tildes and c.bg2 or c.white,
        bg = cfg.transparent and c.none or c.black
    },
    NvimTreeRootFolder = {fg = c.orange, fmt = "bold"},
    NvimTreeGitDirty = colors.Yellow,
    NvimTreeGitNew = {fg = c.white, bg = c.black},
    NvimTreeGitDeleted = colors.Red,
    NvimTreeSpecialFile = {fg = c.yellow, fmt = "underline"},
    NvimTreeIndentMarker = colors.Fg,
    NvimTreeImageFile = {fg = c.purple_e},
    NvimTreeSymlink = c.purple_e,
    NvimTreeFolderName = c.blue
}
```

- Or, load the color in the `config` of the plugin on startup in the full table
  of the `lazy plugins`, located at

```lua
    -- nvim-tree
    {
        "kyazdani42/nvim-tree.lua",
        lazy = true,
        dependencies = {"kyazdani42/nvim-web-devicons"},
        cmd = {"NvimTreeToggle", "NvimTreeToggle", "NvimTreeClose"},
        -- module = { "nvim-tree", "nvim-tree.actions.root.change-dir" },
        config = function() require("plugins.configs.myNvimTree") end
    }, -- undotree
```

## Changes that I made

Usually, you will need to know the `filen type` you open in `nvim`.
For example I was searching for `latex`. and here is the one I use:

1. I opened a file `gh.tex` which is `*.tex` extension for the `latex` files.
2. I use the command

```lua
:lua print(vim.bo.filetype)
-- Ouput
tex
```

3. I added `tex` with the color and the icon I want under the `nvim-tree` config function.

```lua

    {
        "kyazdani42/nvim-web-devicons",
        event = "VimEnter",
        config = function()
            require("nvim-web-devicons").setup({
                default = true,
                -- takes effect when `strict` is true
                override_by_filename = {
                    [".gitignore"] = {
                        icon = "",
                        color = "#f1502f",
                        name = "Gitignore"
                    },
                    ["tex"] = {
                        icon = "󰙩",
                        color = "#70B77E",
                        name = "Gitignore"
                    },

                }
            })
        end
    },
```





