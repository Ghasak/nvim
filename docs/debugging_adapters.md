# Debugging In depth in Neovim

## Major update 2023-05-01 22:48

- In our `Nvim 0.9` update, I have added the following functionality for the
  `dap` nvim plugin.
  - Support virtual text using the `nvim-dap-virtual-text`. Check the
    configuration file for this plugin.
  - For `Rust`, `rust-tools` session. I have added the capability support which
    was not supported before.
  - For `Rust`, `rust-tools` I have added `Telescope` support which is when you
    go to `main` function and use the command `RustHoverActions` will allow us
    to Run or debug the project.
  - I added also for the `which-key` support for more features for the dap
    session. For example check out the `<leader>de`, it will show the value of
    the current variable in the debugging session.

## In theory

you will need

1. Adapter client for the given programming language (adapters for a given
   language, check the reference below).
2. UI/UX for the debugging to support a nice layout (previously it was
   dabInstaller, now we run everything with Mason).
3. Debugger engine (here we will use nvim-dap only, viminspector is not being
   currently used).
4. Sometime the `TabNine` needs `x86-32` compatible binary (fix the binary
   following the steps in the [read here](./tabnine.md)

## Scripting languages

## Dap Python

### Install python requirements

You will need for either `default python environment`, (i.e., comes with the
system), and also for the `virtualenv` (virtualenv either local or like the pipenv)

- A. `pip install debugpy`.
- B. `pip install pynvim` which host the nvim inside the virtualenv.
- Sometime you need to install the compatible treesitter parser if you using
  ARM64 instead of x86-32 CPU, using `TSInstall python`.

## Debugging languages

- Best documentation about how to perform debugging in `Rust` can be found at
  `Rusthub` project.

## Several adapters of lldb

- There are several adpaters for `lldb`, but only the one I install from the
`brew` is working

```shell
brew install llvm
```

it is located at

```shell
$(brew --prefix llvm)/bin
```

both the `vs-lldb`, and the `lldb-server`. I use the `vs-lldb` to debug the `cpp` projects

## Checking the log

You can check the `nvim-dap` log at
`~/.cache/nvim/dap.log`

## REFERENCES

- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
