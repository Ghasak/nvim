# Formatter in Nvim

<!-- vim-markdown-toc GitLab -->

* [ChangeLog](#changelog)
* [Formatter plugin types](#formatter-plugin-types)
    * [NeoFormat](#neoformat)
    * [None-ls](#none-ls)
    * [Conform.nvim](#conformnvim)
* [Languages specific](#languages-specific)
    * [RScript/R language](#rscriptr-language)
* [Clang-format support](#clang-format-support)
    * [Note:](#note)
    * [Link:](#link)

<!-- vim-markdown-toc -->

## ChangeLog

- `2023-10-26`: added support for the `clang-format` now it runs based on the instructions file of `.clang-format`.
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

## Clang-format support

1. Adding a configuration for your `conform.nvim` plugin as following. Notice
   that you can pass the exact file directory of `.clang-format`, and here you
   have two stratgies, either
   - You follow the a single file you put in your home directory like
     `.clang-format`, and point to it, like `--args =
"--style=file:~/Desktop/devCode/cppDev/AnimationEngineCPP/.clang-format"`,
     or,
   - Make it load the specific `.clang-format` file from your project home,
     using `file`. directory.

```lua
  my_cpp_formatter = {
    command = "/opt/homebrew/bin/clang-format",
    --args = "--style=file:~/Desktop/devCode/cppDev/AnimationEngineCPP/.clang-format",
    args = "--style=file",
    stdin = true,
  },
```

2. You can add for your project any configuration, such as, here, I have added `.clang-format` file with the following content.

```sh

---
Language:        Cpp
BasedOnStyle:  Google
AccessModifierOffset: -4
Standard:        c++17
IndentWidth:     4
TabWidth:        4
UseTab:          Never
ColumnLimit:     100
AlignAfterOpenBracket: Align
BinPackParameters: false
AlignEscapedNewlines: Left
AlwaysBreakTemplateDeclarations: Yes
PackConstructorInitializers: Never
BreakConstructorInitializersBeforeComma: false
IndentPPDirectives: BeforeHash
SortIncludes:    Never
DerivePointerAlignment: false
PointerAlignment: Left
...

```

3. You can add later the keymapping in `nvim`, and its better to use the option
   `lsp_fallback` = `false`, to know you are really loading the correct
   formatter, `in cpp its my_cpp_formatter`, otherwise, it will reterive to the
   origianl supported by the `lspconfig` server.

```lua
':lua require("conform").format({ lsp_fallback = false, async = true, timeout_ms = 500 })<CR>',
```

### Note:

To make the pointer on the left when formatting, I use the following format
`.clang-format` support: The answer is that Google's style (one can inspect it
with `clang-format -style=google -dump-config | less`) defines:

```sh
DerivePointerAlignment: true
```

- The documentation says it:
  - If true, analyze the formatted file for the most common alignment of `&`
    and `*`. Pointer and reference alignment styles are going to be updated
    according to the preferences found in the file. PointerAlignment is then used
    only as fallback. Which means one must explicitly set
    `DerivePointerAlignment: false` if one wants to handle it by oneself.
- After that you can add the `PointerAlignment`, which will work as we need.

### Link:

- [why-do-the-pointeralignment-options-not-work](https://stackoverflow.com/questions/56537847/why-do-the-pointeralignment-options-not-work)
- [Neoformat](https://github.com/sbdchd/neoformat/blob/master/autoload/neoformat/formatters/c.vim)
- [vim-autoformat](https://github.com/vim-autoformat/vim-autoformat/blob/master/plugin/defaults.vim)
- [ClangFormatStyleOptions](https://clang.llvm.org/docs/ClangFormatStyleOptions.html)
- [lspvimbufformat_parameters_make_tab_indent_4](https://www.reddit.com/r/neovim/comments/12ndqo5/lspvimbufformat_parameters_make_tab_indent_4/)
- [formatter.nvim](https://github.com/mhartington/formatter.nvim)
- [does_vimlspbufformat_apply_clangd_formatting](https://www.reddit.com/r/neovim/comments/12otscq/does_vimlspbufformat_apply_clangd_formatting/)
