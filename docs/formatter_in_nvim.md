# Formatter in Nvim

<!-- vim-markdown-toc GitLab -->

* [ChangeLog](#changelog)
* [Formatter plugin types](#formatter-plugin-types)
    * [NeoFormat](#neoformat)
    * [None-ls](#none-ls)
    * [Conform.nvim](#conformnvim)
* [Languages specific](#languages-specific)
    * [RScript/R language](#rscriptr-language)

<!-- vim-markdown-toc -->

## ChangeLog

- `2023-10-09`: Added the conform.nvim formatter with robust configurations for
  all languages.
  - [x] Add loader to the `require("conform")` to ensure safely loading.
  - [x] Speak about the problem in the current formatter.
  - [x] How to install `conform.nvim` and how I use it as my current daily
        drive instead of `NeoFormat`.
  - [x] Problem with other formatters, and how I solved them using the
        `conform.nvim` plugin.
  - [x] Added formatter for most used languages.
    - Now it support all my daily usages, and still some of them are not
      defined yet.

## Formatter plugin types

### NeoFormat

Current problem with the `rustfmt`, which based on the `toolchain` of Rust, the
`rustc` foramt the old version of rust by defualt which support the
`--edition=2015`. If you want to run for modern syntax of edition `2021` for
example, then you must pass the flag `--edition=2020`.

1. Ensure you have already installed the `rustfmt` using

```shell
rustup component add rustfmt
```

2. Using `Neovim` is our default formatter for any given buffer, but for Rust,
   it seems there is an issue that the arg `--edition` in not passed to the
   `rustfmt` command. The consequences is that it will affect any code which is not
   written in the given version for rustc, in this case, a code written in `2021` syntax
   will not be parsed correctly.

- Working around solution, either

  - Using shell command in the `nvim` buffer

  ```sh
     # For Rust, if it is faild you can run:
     :!cargo fmt
     # Or using
     :!rustfmt --edition=2021 src/main.rs
  ```

- If you want to fix the problem for in `Neoformat` without waiting for the
  `PR`, use:

  - Go to the location of `rust` in `Neoformat` plugin locally at:
    `~/.local/share/nvim/lazy/neoformat/autoload/neoformat/formatters/rust.vim`

  ```sh
  # Add only the args
  # Before:
  function! neoformat#formatters#rust#rustfmt() abort
    return {
        \ 'exe': 'rustfmt',
        \ 'stdin': 1,
        \ }
   endfunction
  # After
  function! neoformat#formatters#rust#rustfmt() abort
    return {
        \ 'exe': 'rustfmt',
        \ 'args': ['--edition=2021'],
        \ 'stdin': 1,
        \ }
  endfunction
  ```

- Check the fix here `feat(rust): add global flag g:rustfmt_edition_opt #405`
  at - [global flat g:rustfmt_edition_opt](https://github.com/sbdchd/neoformat/pull/405)

### None-ls

This formatter is not working as I want, it has some difficulty to integrate it
with the `configlsp.nvim`. The plugin is a shift from `null-ls` by the author
as he archived his plugin, and after that the community uses the `none-ls` as a
replacement. Before the name was `null-ls` and called using
`jose-elias-alvarez/null-ls.nvim`, but now it becomes `nvimtools/none-ls.nvim`.

- Using the lsp

```lua
use {
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" }
}

```

### Conform.nvim

This is my current formatter is greate, It supports all the languages and I use it as my daily drive.
I make it works right out of the box. Check this plugin
[here](https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#format-command)
and [here](https://github.com/stevearc/conform.nvim#formatopts-callback) You
can see that, the following

- Calling using `lazy.nvim`

```lua
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    lazy = true,
    config = function()
      require("plugins.configs.myConform").config()
    end,
  },
```

- Then, I load it using the myConform.lua file, can be found at
  `../lua/plugins/configs/myConform.lua`.

- The following command is used to call it, `<leader>ft`, which if its fail it
  will fall-back to `vim.lsp.buf.format()` which is supported by the `lspconfig`
  plugin by default if there is not plugin for formatting installed.

- It support to change any formatter cli by passing an arg, for example, I have
  changed the rustfmt formatter, but uncomment it form the `formatters_by_ft` and
  added the section `formatters` in the `../lua/plugins/configs/myConform.lua`.

## Languages specific

### RScript/R language

In order to make it works, you will need to install the following libraries

1. `readr` package, [read here](https://readr.tidyverse.org)

```R
install.packages("readr")
```

2. `style` which is come installed with the R distribution automatically [read here](https://cran.r-project.org/web/packages/styler/index.html).
