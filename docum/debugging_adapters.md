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


## REFERENCES
- [nvim-dap](https://github.com/mfussenegger/nvim-dap)
