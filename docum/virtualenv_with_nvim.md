# Virtualenv with nvim

As for now, I face no problem with the current `nvim` workflow, but sometime
you want to get the `python` of the system default instead of the virtualenv.

## Using System python instead the virtualenv
In case this is helpful to anyone, here is what I use instead:

```vim
" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
    let g:python_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), '\n', '', 'g')
else
    let g:python_host_prog=substitute(system("which python3"), '\n', '', 'g')
endif

```

This tries to use the global Python install even if you're inside of a
virtualenv. Edit: Revised version using @tweekmonster's suggestions:

```vim
" Figure out the system Python for Neovim.
if exists("$VIRTUAL_ENV")
    let g:python3_host_prog=substitute(system("which -a python3 | head -n2 | tail -n1"), "\n", '', 'g')
else
    let g:python3_host_prog=substitute(system("which python3"), "\n", '', 'g')
endif
```



# Reference
- [Neovim with virtualenv](https://github.com/neovim/neovim/issues/1887)
