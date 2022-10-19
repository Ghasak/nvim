# Debugging In depth in Neovim

## In theory
you will need
1. Adapter client for the given programming language (adapters for a given
   language, check the reference below).
2. UI/UX for the debugging to support a nice layout (previously it was
   dabInstaller, now we run everything with Mason).
3. Debugger engine (here we will use nvim-dap only, viminspector is not being
   currently used).

## Dap Python
### Install python requirements
You will need for either `default python environment`, (i.e., comes with the
system), and also for the `virtualenv` (virtualenv either local or like the pipenv)

- A. `pip install debugpy`.
- B. `pynvim` which host the nvim inside the virtualenv.

## Several adapters of lldb
There are several adpaters for `lldb`, but only the one I install from the `brew` is working
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

