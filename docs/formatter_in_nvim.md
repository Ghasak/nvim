# Formatter in Nvim

## rustfmt

1. Ensure you have already installed the `rustfmt` using

```shell
rustup component add rustfmt
```

2. Using `Neovim` is our default formatter for any given buffer, but for Rust,
   it seems there is an issue that the arg `--edition` in not passed to the
   `rustfmt` command. The consequences is that it will affect anycode which is not
   written in the given version for rustc, in this case, a code written in `2015`
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

## None-ls

This formatter is not working as I want, it has some difficulty to integrate it with the `configlsp.nvim`.

## Conform

This is my current formatter is greate, but I cannot make it works right out of
the box. Check this plugin [here](https://github.com/stevearc/conform.nvim/blob/master/doc/recipes.md#format-command)
