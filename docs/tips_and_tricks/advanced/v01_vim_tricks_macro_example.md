# Vim Trick : Macro Example 1

Assume we wantt to transfer the block of code

```sh
-- minpac
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-endwise', {'type': 'opt'})
call minpac#add('tpope/vim-wahevera you want here ')
call minpac#add('tpope/vim-unimpaired')
call minpac#add('tpope/vim-vim-repeat ')
call minpac#add('tpope/vim-commentary/ale' {'type': 'opt'})
call minpac#add('tpope/vim-commentary', {'type' : 'opt'})
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-ctext')
```

to be similar to the following

```sh
use 'wbthomason/packer.nvim'
use {'neoclide/coo.nvim', branch = 'release'}

```

Using macro we need to do the following

1. lets record a macro

- Press `qa`, at top line to start recording a macro, following the characters `dt(iuse f';jkAA D0j`.
- This will record a macro at the register `a`.

```sh
use ('tpope/vim-commentary')
use ('tpope/vim-commentary')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-commentary')
call minpac#add('tpope/vim-commentary')

```

2. Then you can apply the macro using @a and there are many ways, the one I like to apply for all lines

- Use `vip` for selecting the whole paragraph of all types of lines that you want to apply your macro on.
- Then use `:norma @a`, or repeat by numbers `50@a`


2. Not lets apply the macro


```sh
use ('tpope/vim-wahevera you want here')
use ('tpope/vim-wahevera you want here')
use ('tpope/vim-wahevera you want here')
use ('tpope/vim-wahevera you want here')
use ('tpope/vim-unimpaired')
use ('tpope/vim-vim-repeat')
use ('tpope/vim-commentary/ale')
use ('tpope/vim-commentary')
use ('tpope/vim-commentary')
use ('tpope/vim-ctext')
```

