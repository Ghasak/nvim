# CREATING VIEW

<!-- vim-markdown-toc GitLab -->

* [mkview](#mkview)
* [loadview](#loadview)
* [Where sessions storeda](#where-sessions-storeda)
* [References](#references)

<!-- vim-markdown-toc -->

We create views primarily for refactoring code purposes, and one way to achieve
this is by loading the `ufo.nvim` plugin via `UfoAttach`. We mainly create
views for the purpose of refactoring code and load the `ufo.nvim` plugin using
`UfoAttach`.

**NOTE**: There are two types of folding in nvim, native one using `fold`,
`openfload`, `closeflod` ..etc., and there is also simiarl folding system using
`ufo.nvim`.

## mkview

First to make a view, we need loading the `ufo.nvim` using `UfoAttach`. and
then we create a view using:

```sh
:mkview
```

- The `mkview` without given a directory will store all views at the following
  directory `/.local/state/nvim/view`. but we can also pass a directory, for example

```sh
:mkview Users/user_name/.cache/nvim/my_view_1
```

## loadview

We can load the view using the following:

```
:loadview
```

- Similary, either passing the directory to the command or leave it alone and
  it will load the one from the directory that created by default when we dont
  pass a directory to the command `mkview`, which is at
  `/.local/state/nvim/view`.

## Where sessions storeda

You can use the command

```
:echo &viewdir
```

- This command will show that automatically the `nvim` will store the views at
  this location when we dont pass a directory.

## References

- [nvim-where-do-mkview-get-saved-on-m1-mac](https://vi.stackexchange.com/questions/38900/nvim-where-do-mkview-get-saved-on-m1-mac)
