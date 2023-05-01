# Session In Nvim

## Introduction
The `session` in `nvim` is about creating a shortcut for your environment that
you can jump to it anytime. Currently it doesn't support if the `Nvim-tree`
window is opened, so, close it first then create the session.

## Create Nvim Session

To create a session in nvim you can use the following formula:

```vim
:mks <directory>/<session_name>
"Or you can use
:mksession <directory>/<session_name>
```

for example:

```vim
:mks ~/.cache/nvim/sessions/myPythonProjectEnv
```

- This will create a `myPythonProjectEnv` file which contains all the necessary
  information to load your exact environment including (splits, tabs, bufffers
  ..etc.)

## To Load Nvim Session

There are two ways, either from inside the `nvim` using

```vim
source <directory>/<session_name>
```

for example

```vim
:source ~/.cache/nvim/sessions/myPythonProjectEnv
```

or, you can also use the environment from the `nvim` command line by passing
the environment (session_name) as an argument

```vim
nvim -S <directory>/<session_name>
```

for example

```vim
nvim -S ~/.cache/nvim/sessions/myPythonProjectEnv
```

## Automate the loading
I have created a function called `open_session` and store it in the
`special_color_highlight.lua` module, to check more about this function.

- It works only when you have already stored your session in the
  `~/.cache/nvim/sessions/` directory
- It will switch the environment based on the selected session assume the
  `Telescope` is already installed.
- Only one caveat is that the nvim statusbar, doesn't show the correct
  `lsp-server` at the momenet (but it works without any problem).


## References
- [How to use Session in Vim](https://bocoup.com/blog/sessions-the-vim-feature-you-probably-arent-using)
