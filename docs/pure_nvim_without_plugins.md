# Pure Nvim without Plugings

Sometimes Vim can be very slow to load large files since it is very slow at
syntax highlighting and such operations. In such situations, I like to open Vim
without loading any of my plugins or settings. Note that when you do not have a
vimrc in your home directory, Vim is still loading the system vimrc which loads
many plugins that ship with Vim.

I do this by asking Vim to use nothing (NONE) as its vimrc file:

```sh
$ vim -u NONE
$ vim -u NONE fileyouwantopen
```

Trying to use the vim.tiny or vim.basic executables that are shipped on Linux
directly does not work since they try to load your vimrc and fail since they
are compiled with many important features of Vim turned off.

## REFERENCES

- [Code Yarnks Tech Blog - Personal Blog](https://codeyarns.com/tech/2014-05-20-how-to-start-vim-without-any-settings-or-plugins.html#gsc.tab=0)
