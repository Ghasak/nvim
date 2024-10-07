# Multi Cursor Movements

<!-- vim-markdown-toc Redcarpet -->

* [Requirements](#requirements)
* [How to use it](#how-to-use-it)
    * [1. Add a cursor to each line of your visual selection](#1-add-a-cursor-to-each-line-of-your-visual-selection)
        * [1.1 Selecting similar occurance](#1-1-selecting-similar-occurance)
        * [1.2 Selecting cursor at random places](#1-2-selecting-cursor-at-random-places)
* [Modes in multi-visual-cursor](#modes-in-multi-visual-cursor)

<!-- vim-markdown-toc -->

## Requirements

1. You will need the plugin called `vim-visual-multi` from
   [here](https://github.com/terryma/vim-multiple-cursors), note that the
   [vim-multiple-cursors](https://github.com/terryma/vim-multiple-cursors?tab=readme-ov-file#-this-plugin-is-deprecated-use-vim-visual-multi-instead-) is deprecated.

2. Put the following for your keybindings

```lua
vim.keymap.set("n", "<leader>cu", "<Plug>(VM-Add-Cursor-Up)", { desc = "vim visual multi" })
vim.keymap.set("n", "<leader>cd", "<Plug>(VM-Add-Cursor-Down)", { desc = "vim visual multi" })
```

## How to use it

| idx | Note                                                               |
| --- | ------------------------------------------------------------------ |
| 1   | select words with `Ctrl-N` (like `Ctrl-d` in Sublime Text/VS Code) |
| 2   | create cursors vertically with `Ctrl-Down/Ctrl-Up`                 |
| 3   | select one character at a time with Shift-Arrows                   |
| 4   | **press** n/N to get next/previous occurrence                      |
| 5   | **press** [/] to select next/previous cursor                       |
| 6   | **press** q to skip current and get next occurrence                |
| 7   | **press** Q to remove current cursor/selection                     |
| 8   | start insert mode with i,a,I,                                      |

### 1. Add a cursor to each line of your visual selection

#### 1.1 Selecting similar occurance

This type of cursor selection involves highlighting multiple occurrences of
identical terms by positioning the cursor on any one of those instances and
pressing either `<C-n>` or `<C-N>`. This creates a cursor under each
occurrence, allowing for various actions to be taken using `i`, `r`, `A`, or
`c`, `d`, `x` ..etc..

- Now, you can utilize "A" for appending, "c" for changing, "i" for
  inserting, and "r" for replacing at the end.

#### 1.2 Selecting cursor at random places

This type of cursor selection involves selecting the cursor at various
locations, not necessarily identical ones. The locations do not need to be
predetermined or similar in nature. (but must be either down or up).

1. Assume you have the following, secquence and you want to adjust them
   horizontally.

- Here we will position the cursor at each word's initial letter by executing:
  - Move to the beginning of "Mon" and press `<leader>cd` to move down a line
    and land on "Tue", while also maintaining the previous cursor position
    under "M". continue do the same until you cover all the names up to `Sun`, with cursor on `S`.
  - Now, you can use all vim movment in vim, supporting
    - `ciw`: change inner word
    - `ci"`: change inside "
    - `ysiw"`: add to the inner word with `""`, you can also `''`. `require surrounded tpop` plugin
    - `csiw"'`: change the inner word surrounded " -> '.`require surrounded tpop` plugin
    - ...etc.

```
Mon
Tue
Wed
Thu
Fir
Sat
Sun
```

2. Now, let's put a cursor at the beginning of each of these sequences:
   - Place the cursor on the word `Mon`.
   - Use the keybinding `<leader>cd ` to create one cursor down, allowing for
     any placement, not just on Tue. This will split the buffer (file) into up
     and down sections and enable you to create a new cursor location below your
     initial selection rather than above.

```
Mon
Tue
Wed
Thu
Fir
Sat
Sun

Mon
Mon
Mon
```

## Modes in multi-visual-cursor

There are two main modes:

- in cursor mode commands work as they would in normal mode
- in extend mode commands work as they would in visual mode
  press `Tab` to switch between `«cursor»` and `«extend»` mode

- Most vim commands work as expected (motions, r to replace characters, ~ to
  change case, etc). Additionally you can:
  - run macros/ex/normal commands at cursors
  - align cursors
  - transpose selections
  - add patterns with regex, or from visual mode
And more... of course, you can enter insert mode and autocomplete will work.




