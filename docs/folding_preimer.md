# FOLDING IN NVIM

<!-- vim-markdown-toc GitLab -->

* [ChangeLog](#changelog)
* [1. FOLD METHODS](#1-fold-methods)
    * [1.1. Types](#11-types)
        * [1.1.1. Manual](#111-manual)
        * [1.1.2. Indent](#112-indent)
        * [1.1.3. Marker](#113-marker)
        * [1.1.4. Expr](#114-expr)
        * [1.1.5. Syntax](#115-syntax)
        * [1.1.5. Diff](#115-diff)
    * [1.2. Default behavior - no plubin required](#12-default-behavior-no-plubin-required)
    * [1.3. Using UFO](#13-using-ufo)
        * [1.3.1 How to work daily](#131-how-to-work-daily)
* [2. References](#2-references)

<!-- vim-markdown-toc -->

## ChangeLog

- `10/07/2024 15:54:47`: I am using now `UFO` with `UFOAttach`.

The following configurations are based on the explanation by the
[ref1](https://www.youtube.com/watch?v=f_f08KnAJOQ). The author of this video
shows there are several ways to create folding.

## 1. FOLD METHODS

### 1.1. Types

In `nvim`, we can modify the method of folding by configuring its settings

1. To change on fly using the `cmdline`:

```nvim
:set foldmethod=<folding_method>
'for example'
:set foldmethod=manual
```

2. To permanently change something using the `nvim option`.

```nvim
-- enable folding (default 'foldmarker'),
-- if not manual, the ufo.nvim will not work.
opt.foldmethod = "manual"
```

Basic folding method in `nvim`are:

#### 1.1.1. Manual

Manually define folds, this is the option, that

#### 1.1.2. Indent

More indent means a higher fold level

#### 1.1.3. Marker

Fold defined by markers in the text.

#### 1.1.4. Expr

Specify an expression to define folds

#### 1.1.5. Syntax

Fold defined by syntax highlighting

#### 1.1.5. Diff

Folds for unchanged text.

### 1.2. Default behavior - no plubin required

If you just set the following in the `option` file of our nvim configuration,

```nvim
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true
```

These will enable us to utilize folding primitive to `nvim` without any
comprehension of the `lsp`, `treesitter`, or `indent` mechanisms. You can test
this using

1. Select the block of code that you want to fold using the `visual` model
   (`v`).
2. Now, use the `cmdline` command `:fold` and it will be fold at this point.
3. you toggle the folding it also using `:foldclose` `:foldopen`.

### 1.3. Using UFO

`ufo.nvim` is configured as a plugin, and its functionality is now working
correctly. In the past, an issue existed with the configuration in the
`option.lua` file where the folding method was set to "manual" using
`opt.foldmethod = "marker"`. I have changed the `marker` to `manual` and now it
works flawlessly

#### 1.3.1 How to work daily

1. Run the command `UFOAttach` from the `cmdline` prompt.
2. Now you have the optoins `<leader>1` for fold/unfload under cursor.
   `<leader>2` to fold/ufold for overall buffer. Also, you have `<leader>3`
   which will peek what inside the folding point to see the code without open the
   folding.

## 2. References

- [Code Foldign in Neovim - Andrew Courter](https://www.youtube.com/watch?v=f_f08KnAJOQ)
